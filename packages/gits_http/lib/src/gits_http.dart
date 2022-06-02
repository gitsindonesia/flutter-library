import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
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
  })  : _timeout = timeout,
        _gitsInspector = gitsInspector,
        _showLog = showLog,
        _headers = headers;

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
  MapEntry<String, String>? _mapEntityToken;

  void setToken(
    String token, {
    String key = 'Authorization',
    String prefixValue = 'Bearer',
  }) {
    _mapEntityToken = MapEntry(
      key,
      prefixValue.isNotEmpty ? '$prefixValue $token' : token,
    );
  }

  Map<String, String>? _putIfAbsentHeader(
    Map<String, String>? headers,
  ) {
    if (_mapEntityToken == null && _headers == null) {
      return headers;
    }

    final newHeaders = headers ?? {};
    if (_mapEntityToken != null) {
      newHeaders.putIfAbsent(
        _mapEntityToken!.key,
        () => _mapEntityToken!.value,
      );
    }
    _headers?.forEach((key, value) {
      newHeaders.putIfAbsent(key, () => value);
    });
    return newHeaders;
  }

  void _loggerRequest(BaseRequest request, Object? body) {
    if (kReleaseMode || !_showLog) return;
    _logger.d('----> Request');
    _logger.d(
      '${request.method.toUpperCase()} ${request.url.toString()}',
    );
    if (request.headers.isNotEmpty) _logger.d(request.headers);
    if (body != null) _logger.d(body);
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
    await _gitsInspector?.inspectorResponse(
      uuid,
      ResponseInspector(
        headers: response.headers,
        body: json.decode(response.body),
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
    _handleErrorResponse(response);
    return response;
  }

  Future<Response> _sendUnstreamed(
      String method, Uri url, Map<String, String>? headers,
      [body, Encoding? encoding]) async {
    var request = Request(method, url);

    final newHeaders = _putIfAbsentHeader(headers);
    if (newHeaders != null) request.headers.addAll(newHeaders);
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

    return _fetch(request, body);
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

  Future<Response> postMultipart(
    Uri url, {
    Map<String, File>? files,
    Map<String, String>? headers,
    Map<String, String>? body,
  }) async {
    final newHeaders = _putIfAbsentHeader(headers);
    var request = MultipartRequest('POST', url);
    files?.forEach((key, value) async {
      request.files.add(await MultipartFile.fromPath(key, value.path));
    });

    if (!(newHeaders?.containsKey('Content-type') ?? false)) {
      request.headers.addAll({"Content-type": "multipart/form-data"});
    }
    if (newHeaders != null) request.headers.addAll(newHeaders);
    if (body != null) request.fields.addAll(body);

    final uuid = const Uuid().v4();
    _loggerRequest(request, _getBodyRequest(request));
    await _inspectorRequest(uuid, request, _getBodyRequest(request));
    final response = await Response.fromStream(
      await send(request).timeout(
        Duration(milliseconds: _timeout),
        onTimeout: () async {
          await _inspectorResponseTimeout(uuid);
          throw gits_exception.TimeoutException();
        },
      ),
    );
    _loggerResponse(response);
    _inspectorResponse(uuid, response);
    _handleErrorResponse(response);
    return response;
  }

  Object? _getBodyRequest(BaseRequest request) {
    if (request is Request) {
      return request.body;
    } else if (request is MultipartRequest) {
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
    return null;
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

  @override
  void close() {
    try {
      _logger.close();
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }
}
