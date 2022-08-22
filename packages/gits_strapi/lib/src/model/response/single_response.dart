import 'body_response/body_response.dart';

class SingleResponse<T> {
  final T? data;
  final MetaResponse? meta;
  final ErrorResponse? error;

  const SingleResponse({
    required this.data,
    required this.meta,
    required this.error,
  });

  factory SingleResponse.fromMap(
      Map<String, dynamic> map, Function(Map<String, dynamic>) build) {
    return SingleResponse<T>(
      data: map['data'] != null ? build(map["data"]) : null,
      meta: map['meta'] != null ? MetaResponse.fromMap(map['meta']) : null,
      error: map['error'] != null ? ErrorResponse.fromMap(map['error']) : null,
    );
  }

  @override
  bool operator ==(covariant SingleResponse<T> other) {
    if (identical(this, other)) return true;

    return other.data == data && other.meta == meta && other.error == error;
  }

  @override
  int get hashCode => data.hashCode ^ meta.hashCode ^ error.hashCode;

  @override
  String toString() =>
      'SingleResponse(data: $data, meta: $meta, error: $error)';
}
