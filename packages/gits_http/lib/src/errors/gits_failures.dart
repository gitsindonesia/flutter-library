import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// The interface for Gits Failure after catch [GitsException].
@immutable
abstract class GitsFailure extends Equatable {
  const GitsFailure(this.message);
  final String message;
}

/// A failure caused by a http error status code 300-399.
class RedirectionFailure extends GitsFailure {
  const RedirectionFailure(
    String message, {
    required this.statusCode,
    required this.jsonBody,
  }) : super(message);

  final int statusCode;
  final String jsonBody;

  @override
  List<Object?> get props => [message, statusCode, jsonBody];
}

/// A failure caused by a http error status code 400-499.
class ClientFailure extends GitsFailure {
  const ClientFailure(
    String message, {
    required this.statusCode,
    required this.jsonBody,
  }) : super(message);

  final int statusCode;
  final String jsonBody;

  @override
  List<Object?> get props => [message, statusCode, jsonBody];
}

/// A failure caused by a http error status code 500-599.
class ServerFailure extends GitsFailure {
  const ServerFailure(
    String message, {
    required this.statusCode,
    required this.jsonBody,
  }) : super(message);

  final int statusCode;
  final String jsonBody;

  @override
  List<Object?> get props => [message, statusCode, jsonBody];
}

/// A failure caused by a http error status code 401.
class UnauthorizedFailure extends GitsFailure {
  const UnauthorizedFailure(
    String message, {
    required this.statusCode,
    required this.jsonBody,
  }) : super(message);

  final int statusCode;
  final String jsonBody;

  @override
  List<Object?> get props => [message, statusCode, jsonBody];
}

/// A failure caused by a http error timeout fetch http client.
class TimeoutFailure extends GitsFailure {
  const TimeoutFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

/// A failure caused by an error in internal app.
class InternalFailure extends GitsFailure {
  const InternalFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

/// A failure caused by a http error status code 300-599 in do refresh token.
class RefreshTokenFailure extends GitsFailure {
  const RefreshTokenFailure(
    String message, {
    required this.statusCode,
    required this.jsonBody,
  }) : super(message);

  final int statusCode;
  final String jsonBody;

  @override
  List<Object?> get props => [message, statusCode, jsonBody];
}
