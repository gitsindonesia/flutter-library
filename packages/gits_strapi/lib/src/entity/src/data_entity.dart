class DataEntity<T> {
  final int? id;
  final T? attributes;

  const DataEntity({
    required this.id,
    required this.attributes,
  });

  @override
  bool operator ==(covariant DataEntity<T> other) {
    if (identical(this, other)) return true;

    return other.id == id && other.attributes == attributes;
  }

  @override
  int get hashCode => id.hashCode ^ attributes.hashCode;

  @override
  String toString() => 'DataEntity(id: $id, attributes: $attributes)';
}
