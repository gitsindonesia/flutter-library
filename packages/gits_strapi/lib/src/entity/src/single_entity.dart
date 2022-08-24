import 'body_entity/body_entity.dart';

class SingleEntity<T> {
  final T? data;
  final MetaEntity? meta;
  final ErrorEntity? error;

  const SingleEntity({
    required this.data,
    required this.meta,
    required this.error,
  });

  @override
  bool operator ==(covariant SingleEntity<T> other) {
    if (identical(this, other)) return true;

    return other.data == data && other.meta == meta && other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ meta.hashCode ^ error.hashCode;

  @override
  String toString() => 'SingleEntity(data: $data, meta: $meta, error: $error)';
}
