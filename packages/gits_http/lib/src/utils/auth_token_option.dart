import 'package:http/http.dart';

typedef GetToken = Future<String?> Function();
typedef OnAuthTokenResponse = Future<void> Function(Response response);
typedef AuthCondition = bool Function(BaseRequest request, Response response);
typedef ClearCondition = bool Function(BaseRequest request, Response response);
typedef OnClearToken = Future<void> Function();

class AuthTokenOption {
  AuthTokenOption({
    this.typeHeader = 'Authorization',
    this.prefixHeader = 'Bearer',
    required this.getToken,
    required this.authCondition,
    required this.onAuthTokenResponse,
    this.clearCondition,
    this.onClearToken,
    this.excludeEndpointUsageToken,
  });

  final String typeHeader;
  final String prefixHeader;
  final GetToken getToken;
  final AuthCondition authCondition;
  final OnAuthTokenResponse onAuthTokenResponse;
  final ClearCondition? clearCondition;
  final OnClearToken? onClearToken;
  final List<Uri>? excludeEndpointUsageToken;
}

extension AuthTokenOptionExtension on AuthTokenOption {
  Future<MapEntry?> getMapEntryToken(Uri url) async {
    if (excludeEndpointUsageToken?.contains(url) ?? true) {
      return null;
    }

    final token = await getToken();
    return MapEntry(
      typeHeader,
      prefixHeader.isNotEmpty ? '$prefixHeader $token' : token,
    );
  }

  Future<void> handleConditionAuthTokenOption(
    BaseRequest request,
    Response response,
  ) async {
    if (authCondition(request, response)) {
      await onAuthTokenResponse.call(response);
    }
    if (clearCondition?.call(request, response) ?? false) {
      await onClearToken?.call();
    }
  }
}
