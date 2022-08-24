import 'dart:convert';
import 'package:gits_http/gits_http.dart';
import 'package:gits_strapi/gits_strapi.dart';

class GitsStrapi {
  late GitsHttp http;

  GitsStrapi({
    int? timeout,
    GitsInspector? gitsInspector,
    bool? showLog,
    Map<String, String>? headers,
    AuthTokenOption? authTokenOption,
    RefreshTokenOption? refreshTokenOption,
  }) {
    http = GitsHttp(
        timeout: timeout ?? 3000,
        gitsInspector: gitsInspector,
        showLog: showLog ?? true,
        headers: headers ?? {'Content-Type': 'application/json'},
        authTokenOption: authTokenOption,
        refreshTokenOption: refreshTokenOption);
  }

  Future<SingleResponse<DataResponse<dynamic>>> getSingle(
      {Map<String, String>? headers, required Uri endpoint}) async {
    try {
      final raw = await http.get(endpoint, headers: headers);

      var single = SingleResponse<DataResponse<dynamic>>.fromMap(
        jsonDecode(raw.body),
        (data) => DataResponse<dynamic>.fromMap(data, (atr) => atr),
      );

      return single;
    } catch (e) {
      rethrow;
    }
  }

  Future<CollectionResponse<DataResponse<dynamic>>> getCollection(
      {Map<String, String>? headers, required Uri endpoint}) async {
    try {
      final raw = await http.get(endpoint, headers: headers);

      var collection = CollectionResponse<DataResponse<dynamic>>.fromMap(
        jsonDecode(raw.body),
        (data) {
          var result = data
              .map((item) => DataResponse<dynamic>.fromMap(item, (atr) => atr))
              .toList();

          return result;
        },
      );

      return collection;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> update(
      {Map<String, String>? headers,
      required Uri endpoint,
      required String id,
      required Map<String, dynamic> body}) async {
    var newPath = "${endpoint.origin}${endpoint.path}/$id";
    return await http.put(Uri.parse(newPath), body: body, headers: headers);
  }

  Future<Response> delete(
      {Map<String, String>? headers,
      required Uri endpoint,
      required String id}) async {
    try {
      var newPath = "${endpoint.origin}${endpoint.path}/$id";
      return await http.delete(Uri.parse(newPath), headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> create(
      {Map<String, String>? headers,
      required Uri endpoint,
      required Map<String, dynamic> body}) async {
    try {
      return await http.post(endpoint, body: body, headers: headers);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> login(
      {Map<String, String>? headers,
      required Uri endpoint,
      required Map<String, dynamic> body}) async {
    try {
      final raw = await http.post(endpoint, body: body, headers: headers);
      return AuthResponse.fromMap(jsonDecode(raw.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> register(
      {Map<String, String>? headers,
      required Uri endpoint,
      required Map<String, dynamic> body}) async {
    try {
      final raw = await http.post(endpoint, body: body, headers: headers);
      return AuthResponse.fromMap(jsonDecode(raw.body));
    } catch (e) {
      rethrow;
    }
  }
}
