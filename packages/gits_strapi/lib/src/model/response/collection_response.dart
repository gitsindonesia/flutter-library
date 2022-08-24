import 'package:flutter/foundation.dart';
import 'body_response/body_response.dart';

class CollectionResponse<T> {
  final List<T>? data;
  final MetaResponse? meta;
  final ErrorResponse? error;

  const CollectionResponse(
      {required this.data, required this.meta, required this.error});

  factory CollectionResponse.fromMap(
      Map<String, dynamic> map, Function(List<dynamic>) build) {
    return CollectionResponse<T>(
      data: map['data'] != null ? build(map['data']) : null,
      meta: map['meta'] != null ? MetaResponse.fromMap(map['meta']) : null,
      error: map['error'] != null ? ErrorResponse.fromMap(map['error']) : null,
    );
  }

  @override
  bool operator ==(covariant CollectionResponse<T> other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data) &&
        other.meta == meta &&
        other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ meta.hashCode ^ error.hashCode;

  @override
  String toString() =>
      'CollectionResponse(data: $data, meta: $meta, error: $error)';
}
