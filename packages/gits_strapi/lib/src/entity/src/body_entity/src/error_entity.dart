class ErrorEntity {
  int? status;
  String? name;
  String? message;

  ErrorEntity({this.status, this.name, this.message});

  @override
  String toString() =>
      'ErrorEntity(status: $status, name: $name, message: $message)';

  @override
  bool operator ==(covariant ErrorEntity other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.name == name &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ name.hashCode ^ message.hashCode;
}
