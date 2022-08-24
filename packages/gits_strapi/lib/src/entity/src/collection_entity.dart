import 'package:flutter/foundation.dart';

import 'body_entity/body_entity.dart';

class CollectionEntity<T> {
  final List<T>? data;
  final MetaEntity? meta;
  final ErrorEntity? error;

  const CollectionEntity(
      {required this.data, required this.meta, required this.error});

  @override
  bool operator ==(covariant CollectionEntity<T> other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data) &&
        other.meta == meta &&
        other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ meta.hashCode ^ error.hashCode;

  @override
  String toString() =>
      'CollectionEntity(data: $data, meta: $meta, error: $error)';
}
