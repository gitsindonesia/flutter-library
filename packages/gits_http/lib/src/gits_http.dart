import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:gits_http/src/utils/auth_token_option.dart';
import 'package:gits_http/src/utils/refresh_token_option.dart';
import 'package:gits_inspector/gits_inspector.dart'
    show GitsInspector, Inspector, RequestInspector, ResponseInspector;
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import 'errors/gits_exceptions.dart' as gits_exception;

class GitsHttp implements Client {
  GitsHttp({
    int timeout = 30000,
    GitsInspector? gitsInspector,
    bool showLog = true,
    Map<String, String>? headers,
    AuthTokenOption? authTokenOption,
    RefreshTokenOption? refreshTokenOption,
  })  : _timeout = timeout,
        _gitsInspector = gitsInspector,
        _showLog = showLog,
        _headers = headers,
        _authTokenOption = authTokenOption,
        _refreshTokenOption = refreshTokenOption;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      errorMethodCount: 0,
      methodCount: 0,
      printEmojis: false,
    ),
  );

  final int _timeout;
  final GitsInspector? _gitsInspector;
  final bool _showLog;
  final Map<String, String>? _headers;
  final AuthTokenOption? _authTokenOption;
  final RefreshTokenOption? _refreshTokenOption;

  Future<Map<String, String>?> _putIfAbsentHeader(
    Uri url,
    Map<String, String>? headers,
  ) async {
    final mapEntityToken = await _authTokenOption?.getMapEntryToken(url);

    if (mapEntityToken == null && _headers == null) {
      return headers;
    }

    final newHeaders = headers ?? {};
    if (mapEntityToken != null) {
      newHeaders.putIfAbsent(mapEntityToken.key, () => mapEntityToken.value);
    }
    _headers?.forEach((key, value) {
      newHeaders.putIfAbsent(key, () => value);
    });
    return newHeaders;
  }

  Object? _getBodyRequest(BaseRequest request, Object? body) {
    if (request is MultipartRequest) {
      final files = request.files
          .map((e) => {
                'filename': e.filename,
                'mime_type': e.contentType.mimeType,
                'field': e.field,
                'length': e.length.toString(),
              })
          .toList();

      return {
        'files': files,
        'body': request.fields,
      };
    }
    return body;
  }

  void _loggerRequest(BaseRequest request, Object? body) {
    if (kReleaseMode || !_showLog) return;
    _logger.d('----> Request');
    _logger.d(
      '${request.method.toUpperCase()} ${request.url.toString()}',
    );
    if (request.headers.isNotEmpty) _logger.d(request.headers);
    if (body != null) _logger.d(_getBodyRequest(request, body));
  }

  void _loggerResponse(Response response) {
    if (kReleaseMode || !_showLog) return;
    _logger.d('<---- Response ${response.statusCode}');
    try {
      _logger.d(jsonDecode(response.body));
    } catch (e) {
      _logger.d(response.body);
    }
  }

  Future<void> _inspectorRequest(
    String uuid,
    BaseRequest request,
    Object? body,
  ) async {
    await _gitsInspector?.inspectorRequest(
      Inspector(
        uuid: uuid,
        request: RequestInspector(
          url: request.url,
          method: request.method,
          headers: request.headers,
          body: body,
          size: request.contentLength,
        ),
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> _inspectorResponse(String uuid, Response response) async {
    Object? body;
    try {
      body = json.decode(response.body);
    } catch (e) {
      body = response.body;
    }
    await _gitsInspector?.inspectorResponse(
      uuid,
      ResponseInspector(
        headers: response.headers,
        body: body,
        status: response.statusCode,
        size: response.contentLength,
      ),
    );
  }

  Future<void> _inspectorResponseTimeout(String uuid) async {
    await _gitsInspector?.inspectorResponseTimeout(uuid);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return request.send();
  }

  Future<Response> _fetch(BaseRequest request, Object? body) async {
    final uuid = const Uuid().v4();
    _loggerRequest(request, body);
    await _inspectorRequest(uuid, request, body);
    final streamResponse = await request.send().timeout(
      Duration(milliseconds: _timeout),
      onTimeout: () async {
        await _inspectorResponseTimeout(uuid);
        throw gits_exception.TimeoutException();
      },
    );
    final response = await Response.fromStream(streamResponse);
    _loggerResponse(response);
    _inspectorResponse(uuid, response);
    return response;
  }

  Request _getRequest(String method, Uri url, Map<String, String>? headers,
      [body, Encoding? encoding]) {
    var request = Request(method, url);

    if (headers != null) request.headers.addAll(headers);
    if (encoding != null) request.encoding = encoding;
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.bodyFields = body.cast<String, String>();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }
    return request;
  }

  Future<Response> _sendUnstreamed(
      String method, Uri url, Map<String, String>? headers,
      [body, Encoding? encoding]) async {
    final newHeaders = await _putIfAbsentHeader(url, headers);

    final request = _getRequest(method, url, newHeaders, body, encoding);
    Response response = await _fetch(request, body);

    // do refresh token if condition is true
    if (_refreshTokenOption?.condition(request, response) ?? false) {
      response = await _doRefreshTokenThenRetry(request, response, body);
    }

    _handleErrorResponse(response);

    await _authTokenOption?.handleConditionAuthTokenOption(request, response);
    return response;
  }

  Future<Response> _doRefreshTokenThenRetry(
      BaseRequest request, Response response, Object? body) async {
    await _sendRefreshToken(_refreshTokenOption!);

    final copyRequest = _copyRequest(request);
    return _fetch(copyRequest, body);
  }

  Future<void> _sendRefreshToken(
    RefreshTokenOption refreshTokenOption,
  ) async {
    final method = refreshTokenOption.method.toString();
    final url = refreshTokenOption.url;
    final headers = await refreshTokenOption.getHeaders?.call();
    final body = await refreshTokenOption.getBody?.call();
    final encoding = refreshTokenOption.encoding;

    var request = _getRequest(method, url, headers, body, encoding);
    final response = await _fetch(request, body);
    _handleRefreshTokenErrorResponse(
      response,
    );
    await refreshTokenOption.onResponse(response);
  }

  @override
  Future<Response> get(
    Uri url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    Map<String, String>? queryParameters = body?.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    final urlWithBody = url.replace(queryParameters: queryParameters);
    return _sendUnstreamed('GET', urlWithBody, headers);
  }

  @override
  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('POST', url, headers, body, encoding);

  @override
  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('PUT', url, headers, body, encoding);

  @override
  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('PATCH', url, headers, body, encoding);

  @override
  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('DELETE', url, headers, body, encoding);

  MultipartRequest _getMultiPartRequest(
    Uri url, {
    Map<String, File>? files,
    Map<String, String>? headers,
    Map<String, String>? body,
  }) {
    var request = MultipartRequest('POST', url);
    files?.forEach((key, value) async {
      request.files.add(await MultipartFile.fromPath(key, value.path));
    });

    if (!(headers?.containsKey('Content-type') ?? false)) {
      request.headers.addAll({"Content-type": "multipart/form-data"});
    }
    if (headers != null) request.headers.addAll(headers);
    if (body != null) request.fields.addAll(body);
    return request;
  }

  Future<Response> postMultipart(
    Uri url, {
    Map<String, File>? files,
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    final newHeaders = await _putIfAbsentHeader(url, headers);

    final request = _getMultiPartRequest(url,
        files: files, headers: newHeaders, body: body);
    Response response = await _fetch(request, body);

    // do refresh token if condition is true
    if (_refreshTokenOption?.condition(request, response) ?? false) {
      response = await _doRefreshTokenThenRetry(request, response, body);
    }

    _handleErrorResponse(response);
    return response;
  }

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) =>
      _sendUnstreamed('HEAD', url, headers);

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) async {
    final response = await get(url, headers: headers);
    _checkResponseSuccess(url, response);
    return response.body;
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) async {
    final response = await get(url, headers: headers);
    _checkResponseSuccess(url, response);
    return response.bodyBytes;
  }

  void _checkResponseSuccess(Uri url, Response response) {
    if (response.statusCode < 400) return;
    var message = 'Request to $url failed with status ${response.statusCode}';
    if (response.reasonPhrase != null) {
      message = '$message: ${response.reasonPhrase}';
    }
    throw gits_exception.ClientException(
      jsonBody: response.body,
      statusCode: response.statusCode,
    );
  }

  BaseRequest _copyRequest(BaseRequest request) {
    BaseRequest requestCopy;

    if (request is Request) {
      requestCopy = Request(request.method, request.url)
        ..encoding = request.encoding
        ..bodyBytes = request.bodyBytes;
    } else if (request is MultipartRequest) {
      requestCopy = MultipartRequest(request.method, request.url)
        ..fields.addAll(request.fields)
        ..files.addAll(request.files);
    } else if (request is StreamedRequest) {
      throw Exception('copying streamed requests is not supported');
    } else {
      throw Exception('request type is unknown, cannot copy');
    }

    requestCopy
      ..persistentConnection = request.persistentConnection
      ..followRedirects = request.followRedirects
      ..maxRedirects = request.maxRedirects
      ..headers.addAll(request.headers);

    return requestCopy;
  }

  void _handleErrorResponse(Response response) {
    if (response.statusCode >= 500) {
      throw gits_exception.ServerException(
        statusCode: response.statusCode,
        jsonBody: response.body,
      );
    } else if (response.statusCode == 401) {
      throw gits_exception.UnauthorizedException(
        statusCode: response.statusCode,
        jsonBody: response.body,
      );
    } else if (response.statusCode >= 400) {
      throw gits_exception.ClientException(
        statusCode: response.statusCode,
        jsonBody: response.body,
      );
    } else if (response.statusCode >= 300) {
      throw gits_exception.RedirectionException(
        statusCode: response.statusCode,
        jsonBody: response.body,
      );
    }
  }

  void _handleRefreshTokenErrorResponse(Response response) {
    if (response.statusCode >= 300) {
      throw gits_exception.RefreshTokenException(
        statusCode: response.statusCode,
        jsonBody: response.body,
      );
    }
  }

  @override
  void close() {
    try {
      _logger.close();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }
}
