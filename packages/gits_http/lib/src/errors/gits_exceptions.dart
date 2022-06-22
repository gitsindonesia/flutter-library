import 'package:gits_http/src/errors/status_code_name.dart';

import '../../gits_http.dart';

abstract class GitsException {
  GitsFailure toGitsFailure();
}

class RedirectionException implements GitsException, StatusCodeName {
  RedirectionException({
    required this.statusCode,
    required this.jsonBody,
  });
  final int statusCode;
  final String jsonBody;

  @override
  GitsFailure toGitsFailure() {
    return RedirectionFailure(
      toString(),
      statusCode: statusCode,
      jsonBody: jsonBody,
    );
  }

  @override
  String toStatusCodeName() {
    return statusCodeNameByStatusCode(statusCode);
  }

  @override
  String toString() =>
      'RedirectionException with status code $statusCode or ${toStatusCodeName()}';
}

class ClientException implements GitsException, StatusCodeName {
  ClientException({
    required this.statusCode,
    required this.jsonBody,
  });
  final int statusCode;
  final String jsonBody;

  @override
  GitsFailure toGitsFailure() {
    return ClientFailure(
      toString(),
      statusCode: statusCode,
      jsonBody: jsonBody,
    );
  }

  @override
  String toStatusCodeName() {
    return statusCodeNameByStatusCode(statusCode);
  }

  @override
  String toString() =>
      'ClientException with status code $statusCode or ${toStatusCodeName()}';
}

class ServerException implements GitsException, StatusCodeName {
  ServerException({
    required this.statusCode,
    required this.jsonBody,
  });
  final int statusCode;
  final String jsonBody;

  @override
  GitsFailure toGitsFailure() {
    return ServerFailure(
      toString(),
      statusCode: statusCode,
      jsonBody: jsonBody,
    );
  }

  @override
  String toStatusCodeName() {
    return statusCodeNameByStatusCode(statusCode);
  }

  @override
  String toString() =>
      'ServerException with status code $statusCode or ${toStatusCodeName()}';
}

class UnauthorizedException implements GitsException, StatusCodeName {
  UnauthorizedException({
    required this.statusCode,
    required this.jsonBody,
  });

  final int statusCode;
  final String jsonBody;

  @override
  GitsFailure toGitsFailure() {
    return UnauthorizedFailure(
      toString(),
      statusCode: statusCode,
      jsonBody: jsonBody,
    );
  }

  @override
  String toString() =>
      'UnauthorizedException with status code $statusCode or ${toStatusCodeName()}';

  @override
  String toStatusCodeName() => 'Unauthorized';
}

class TimeoutException implements GitsException {
  @override
  GitsFailure toGitsFailure() {
    return TimeoutFailure(toString());
  }

  @override
  String toString() =>
      'TimeoutException timeout request and receive response api';
}

class InternalException implements GitsException {
  @override
  GitsFailure toGitsFailure() {
    return InternalFailure(toString());
  }

  @override
  String toString() => 'InternalException something error with internal code';
}

class RefreshTokenException implements GitsException, StatusCodeName {
  RefreshTokenException({
    required this.statusCode,
    required this.jsonBody,
  });
  final int statusCode;
  final String jsonBody;

  @override
  GitsFailure toGitsFailure() {
    return ServerFailure(
      toString(),
      statusCode: statusCode,
      jsonBody: jsonBody,
    );
  }

  @override
  String toStatusCodeName() {
    return statusCodeNameByStatusCode(statusCode);
  }

  @override
  String toString() =>
      'RefreshTokenException with status code $statusCode or ${toStatusCodeName()}';
}
