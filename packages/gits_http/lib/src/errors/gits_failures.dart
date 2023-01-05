import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// The interface for Gits Failure after catch [GitsException].
@immutable
abstract class GitsFailure extends Equatable {
  const GitsFailure(
    this.message, {
    this.statusCode,
    this.jsonBody,
  });
  final String message;
  final int? statusCode;
  final String? jsonBody;
}

/// A failure caused by a http error status code 300-399.
class RedirectionFailure extends GitsFailure {
  const RedirectionFailure(
    super.message, {
    super.statusCode,
    super.jsonBody,
  });

  @override
  List<Object?> get props => [message, statusCode, jsonBody];
}

/// A failure caused by a http error status code 400-499.
class ClientFailure extends GitsFailure {
  const ClientFailure(
    super.message, {
    super.statusCode,
    super.jsonBody,
  });

  @override
  List<Object?> get props => [message, statusCode, jsonBody];
}

/// A failure caused by a http error status code 500-599.
class ServerFailure extends GitsFailure {
  const ServerFailure(
    super.message, {
    super.statusCode,
    super.jsonBody,
  });

  @override
  List<Object?> get props => [message, statusCode, jsonBody];
}

/// A failure caused by a http error status code 401.
class UnauthorizedFailure extends GitsFailure {
  const UnauthorizedFailure(
    super.message, {
    super.statusCode,
    super.jsonBody,
  });

  @override
  List<Object?> get props => [message, statusCode, jsonBody];
}

/// A failure caused by a http error timeout fetch http client.
class TimeoutFailure extends GitsFailure {
  const TimeoutFailure(super.message);

  @override
  List<Object?> get props => [message];
}

/// A failure caused by an error in internal app.
class InternalFailure extends GitsFailure {
  const InternalFailure(super.message);

  @override
  List<Object?> get props => [message];
}

/// A failure caused by a http error status code 300-599 in do refresh token.
class RefreshTokenFailure extends GitsFailure {
  const RefreshTokenFailure(
    super.message, {
    super.statusCode,
    super.jsonBody,
  });

  @override
  List<Object?> get props => [message, statusCode, jsonBody];
}

/// A failure caused by an error no internet connection.
class NoInternetFailure extends GitsFailure {
  const NoInternetFailure(super.message);

  @override
  List<Object?> get props => [message];
}

/// A failure caused by an error no found data in cache.
class CacheFailure extends GitsFailure {
  const CacheFailure(super.message);

  @override
  List<Object?> get props => [message];
}
