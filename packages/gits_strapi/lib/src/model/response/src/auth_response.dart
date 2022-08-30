import 'package:gits_strapi/src/model/response/src/body_response/src/user_response.dart';

class AuthResponse {
  String? jwt;
  UserResponse? user;

  AuthResponse({this.jwt, this.user});

  AuthResponse.fromMap(Map<String, dynamic> json) {
    jwt = json['jwt'];
    user = json['user'] != null ? UserResponse.fromMap(json['user']) : null;
  }

  @override
  String toString() => 'AuthResponse(jwt: $jwt, user: $user)';

  @override
  bool operator ==(covariant AuthResponse other) {
    if (identical(this, other)) return true;

    return other.jwt == jwt && other.user == user;
  }

  @override
  int get hashCode => jwt.hashCode ^ user.hashCode;
}
