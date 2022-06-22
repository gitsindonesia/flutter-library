import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GitsFailure extends Equatable {
  const GitsFailure(this.message);
  final String message;
}

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

class TimeoutFailure extends GitsFailure {
  const TimeoutFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

class InternalFailure extends GitsFailure {
  const InternalFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

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
