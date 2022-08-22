import 'package:gits_strapi/src/entity/src/body_entity/src/user_entity.dart';

class AuthEntity {
  String? jwt;
  UserEntity? user;

  AuthEntity({this.jwt, this.user});

  @override
  String toString() => 'AuthEntity(jwt: $jwt, user: $user)';

  @override
  bool operator ==(covariant AuthEntity other) {
    if (identical(this, other)) return true;

    return other.jwt == jwt && other.user == user;
  }

  @override
  int get hashCode => jwt.hashCode ^ user.hashCode;
}
