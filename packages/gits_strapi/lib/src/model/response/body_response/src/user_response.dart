class UserResponse {
  int? id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  String? createdAt;
  String? updatedAt;

  UserResponse(
      {this.id,
      this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.createdAt,
      this.updatedAt});

  UserResponse.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    username = map['username'];
    email = map['email'];
    provider = map['provider'];
    confirmed = map['confirmed'];
    blocked = map['blocked'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
  }

  @override
  String toString() {
    return 'UserResponse(id: $id, username: $username, email: $email, provider: $provider, confirmed: $confirmed, blocked: $blocked, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserResponse other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.provider == provider &&
        other.confirmed == confirmed &&
        other.blocked == blocked &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        provider.hashCode ^
        confirmed.hashCode ^
        blocked.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
