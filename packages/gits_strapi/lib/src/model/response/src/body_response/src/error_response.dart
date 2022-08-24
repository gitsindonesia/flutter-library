class ErrorResponse {
  int? status;
  String? name;
  String? message;

  ErrorResponse({this.status, this.name, this.message});

  ErrorResponse.fromMap(Map<String, dynamic> map) {
    status = map['status'];
    name = map['name'];
    message = map['message'];
  }

  @override
  String toString() =>
      'ErrorResponse(status: $status, name: $name, message: $message)';

  @override
  bool operator ==(covariant ErrorResponse other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.name == name &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ name.hashCode ^ message.hashCode;
}
