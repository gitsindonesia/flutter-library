import 'dart:convert';

class UserEntity {
  int? id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  bool? blocked;
  String? createdAt;
  String? updatedAt;

  UserEntity(
      {this.id,
      this.username,
      this.email,
      this.provider,
      this.confirmed,
      this.blocked,
      this.createdAt,
      this.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'provider': provider,
      'confirmed': confirmed,
      'blocked': blocked,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      provider: map['provider'] != null ? map['provider'] as String : null,
      confirmed: map['confirmed'] != null ? map['confirmed'] as bool : null,
      blocked: map['blocked'] != null ? map['blocked'] as bool : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserEntity(id: $id, username: $username, email: $email, provider: $provider, confirmed: $confirmed, blocked: $blocked, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserEntity other) {
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
