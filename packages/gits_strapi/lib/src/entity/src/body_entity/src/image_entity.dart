class ImageEntity {
  String? name;
  String? alternativeText;
  String? caption;
  int? width;
  int? height;
  FormatsEntity? formats;
  String? hash;
  String? ext;
  String? mime;
  double? size;
  String? url;
  dynamic previewUrl;
  String? provider;
  dynamic providerMetadata;
  String? createdAt;
  String? updatedAt;

  ImageEntity(
      {this.name,
      this.alternativeText,
      this.caption,
      this.width,
      this.height,
      this.formats,
      this.hash,
      this.ext,
      this.mime,
      this.size,
      this.url,
      this.previewUrl,
      this.provider,
      this.providerMetadata,
      this.createdAt,
      this.updatedAt});

  @override
  String toString() {
    return 'ImageEntity(name: $name, alternativeText: $alternativeText, caption: $caption, width: $width, height: $height, formats: $formats, hash: $hash, ext: $ext, mime: $mime, size: $size, url: $url, previewUrl: $previewUrl, provider: $provider, providerMetadata: $providerMetadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ImageEntity other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.alternativeText == alternativeText &&
        other.caption == caption &&
        other.width == width &&
        other.height == height &&
        other.formats == formats &&
        other.hash == hash &&
        other.ext == ext &&
        other.mime == mime &&
        other.size == size &&
        other.url == url &&
        other.previewUrl == previewUrl &&
        other.provider == provider &&
        other.providerMetadata == providerMetadata &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        alternativeText.hashCode ^
        caption.hashCode ^
        width.hashCode ^
        height.hashCode ^
        formats.hashCode ^
        hash.hashCode ^
        ext.hashCode ^
        mime.hashCode ^
        size.hashCode ^
        url.hashCode ^
        previewUrl.hashCode ^
        provider.hashCode ^
        providerMetadata.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

class FormatsEntity {
  ThumbnailEntity? thumbnail;
  ThumbnailEntity? large;
  ThumbnailEntity? medium;
  ThumbnailEntity? small;

  FormatsEntity({this.thumbnail, this.large, this.medium, this.small});

  @override
  String toString() {
    return 'FormatsEntity(thumbnail: $thumbnail, large: $large, medium: $medium, small: $small)';
  }

  @override
  bool operator ==(covariant FormatsEntity other) {
    if (identical(this, other)) return true;

    return other.thumbnail == thumbnail &&
        other.large == large &&
        other.medium == medium &&
        other.small == small;
  }

  @override
  int get hashCode {
    return thumbnail.hashCode ^
        large.hashCode ^
        medium.hashCode ^
        small.hashCode;
  }
}

class ThumbnailEntity {
  String? name;
  String? hash;
  String? ext;
  String? mime;
  String? path;
  int? width;
  int? height;
  double? size;
  String? url;

  ThumbnailEntity(
      {this.name,
      this.hash,
      this.ext,
      this.mime,
      this.path,
      this.width,
      this.height,
      this.size,
      this.url});

  @override
  String toString() {
    return 'ThumbnailEntity(name: $name, hash: $hash, ext: $ext, mime: $mime, path: $path, width: $width, height: $height, size: $size, url: $url)';
  }

  @override
  bool operator ==(covariant ThumbnailEntity other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.hash == hash &&
        other.ext == ext &&
        other.mime == mime &&
        other.path == path &&
        other.width == width &&
        other.height == height &&
        other.size == size &&
        other.url == url;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        hash.hashCode ^
        ext.hashCode ^
        mime.hashCode ^
        path.hashCode ^
        width.hashCode ^
        height.hashCode ^
        size.hashCode ^
        url.hashCode;
  }
}
