class DataResponse<T> {
  final int? id;
  final T? attributes;

  const DataResponse({
    required this.id,
    required this.attributes,
  });

  factory DataResponse.fromMap(
      Map<String, dynamic> map, Function(Map<String, dynamic>) build) {
    return DataResponse<T>(
      id: map['id'].toInt() as int,
      attributes: build(map['attributes']),
    );
  }

  @override
  bool operator ==(covariant DataResponse<T> other) {
    if (identical(this, other)) return true;

    return other.id == id && other.attributes == attributes;
  }

  @override
  int get hashCode => id.hashCode ^ attributes.hashCode;

  @override
  String toString() => 'DataResponse(id: $id, attributes: $attributes)';
}
