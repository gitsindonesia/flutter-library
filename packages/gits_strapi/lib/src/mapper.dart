import 'package:gits_strapi/gits_strapi.dart';

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

extension ThumbnailResponseMapper on ThumbnailResponse {
  ThumbnailEntity toEntity() => ThumbnailEntity(
        name: name,
        hash: hash,
        ext: ext,
        mime: mime,
        path: path,
        width: width,
        height: height,
        size: size,
        url: url,
      );
}

extension FormatsResponseMapper on FormatsResponse {
  FormatsEntity toEntity() => FormatsEntity(
        thumbnail: thumbnail?.toEntity(),
        large: large?.toEntity(),
        medium: medium?.toEntity(),
        small: small?.toEntity(),
      );
}

extension ImageResponseMapper on ImageResponse {
  ImageEntity toEntity() => ImageEntity(
        name: name,
        alternativeText: alternativeText,
        caption: caption,
        width: width,
        height: height,
        formats: formats?.toEntity(),
        hash: hash,
        ext: ext,
        mime: mime,
        size: size,
        url: url,
        previewUrl: previewUrl,
        provider: provider,
        providerMetadata: providerMetadata,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
