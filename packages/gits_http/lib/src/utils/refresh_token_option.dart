import 'dart:convert';

import 'package:http/http.dart';

typedef RefreshTokenResponse = Future<void> Function(Response response);
typedef ConditionRequireRefreshToken = bool Function(
    BaseRequest request, Response response);
typedef GetHeaders = Future<Map<String, String>?> Function();
typedef GetBody = Future<Map<String, String>?> Function();

enum RefreshTokenMethod {
  get('GET'),
  post('POST');

  const RefreshTokenMethod(this.method);

  final String method;

  @override
  String toString() => method;
}

class RefreshTokenOption {
  RefreshTokenOption({
    required this.method,
    required this.url,
    this.getHeaders,
    this.getBody,
    this.encoding,
    required this.condition,
    required this.onResponse,
  });

  final RefreshTokenMethod method;
  final Uri url;
  final GetHeaders? getHeaders;
  final GetBody? getBody;
  final Encoding? encoding;
  final ConditionRequireRefreshToken condition;
  final RefreshTokenResponse onResponse;
}
