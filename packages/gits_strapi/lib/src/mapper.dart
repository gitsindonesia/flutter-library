import 'package:gits_strapi/gits_strapi.dart';
import 'package:gits_strapi/src/model/response/auth_response.dart';
import 'package:gits_strapi/src/model/response/body_response/src/user_response.dart';

extension SingleResponseMapper on SingleResponse {
  SingleEntity<T> toEntity<T extends Object>(Function(dynamic) build) =>
      SingleEntity(
          data: data != null ? build(data!) : null,
          meta: meta?.toEntity(),
          error: error?.toEntity());
}

extension CollectionResponseMapper on CollectionResponse {
  CollectionEntity<T> toEntity<T extends Object>(
          Function(List<dynamic>) build) =>
      CollectionEntity(
          data: data != null ? build(data!) : null,
          meta: meta?.toEntity(),
          error: error?.toEntity());
}

extension DataResponseMapper on DataResponse {
  DataEntity<T> toEntity<T extends Object>(Function(dynamic) build) =>
      DataEntity(id: id, attributes: build(attributes));
}

extension MetaResponseMapper on MetaResponse {
  MetaEntity toEntity() => MetaEntity(pagination: pagination?.toEntity());
}

extension PaginationResponseMapper on PaginationResponse {
  PaginationEntity toEntity() => PaginationEntity(
      page: page, pageSize: pageSize, pageCount: pageCount, total: total);
}

extension ErrorResponseMapper on ErrorResponse {
  ErrorEntity toEntity() =>
      ErrorEntity(status: status, name: name, message: message);
}

extension AuthResponseMapper on AuthResponse {
  AuthEntity toEntity() => AuthEntity(jwt: jwt, user: user?.toEntity());
}

extension UserResponseMapper on UserResponse {
  UserEntity toEntity() => UserEntity(
      id: id,
      username: username,
      email: email,
      provider: provider,
      confirmed: confirmed,
      blocked: blocked,
      createdAt: createdAt,
      updatedAt: updatedAt);
}
