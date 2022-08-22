class ImageResponse {
  String? name;
  String? alternativeText;
  String? caption;
  int? width;
  int? height;
  FormatsResponse? formats;
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

  ImageResponse(
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

  ImageResponse.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    alternativeText = map['alternativeText'];
    caption = map['caption'];
    width = map['width'];
    height = map['height'];
    formats =
        map['formats'] != null ? FormatsResponse.fromMap(map['formats']) : null;
    hash = map['hash'];
    ext = map['ext'];
    mime = map['mime'];
    size = map['size'];
    url = map['url'];
    previewUrl = map['previewUrl'];
    provider = map['provider'];
    providerMetadata = map['provider_metadata'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
  }

  @override
  String toString() {
    return 'ImageResponse(name: $name, alternativeText: $alternativeText, caption: $caption, width: $width, height: $height, formats: $formats, hash: $hash, ext: $ext, mime: $mime, size: $size, url: $url, previewUrl: $previewUrl, provider: $provider, providerMetadata: $providerMetadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ImageResponse other) {
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

class FormatsResponse {
  ThumbnailResponse? thumbnail;
  ThumbnailResponse? large;
  ThumbnailResponse? medium;
  ThumbnailResponse? small;

  FormatsResponse({this.thumbnail, this.large, this.medium, this.small});

  FormatsResponse.fromMap(Map<String, dynamic> map) {
    thumbnail = map['thumbnail'] != null
        ? ThumbnailResponse.fromMap(map['thumbnail'])
        : null;
    large =
        map['large'] != null ? ThumbnailResponse.fromMap(map['large']) : null;
    medium =
        map['medium'] != null ? ThumbnailResponse.fromMap(map['medium']) : null;
    small =
        map['small'] != null ? ThumbnailResponse.fromMap(map['small']) : null;
  }

  @override
  String toString() {
    return 'FormatsResponse(thumbnail: $thumbnail, large: $large, medium: $medium, small: $small)';
  }

  @override
  bool operator ==(covariant FormatsResponse other) {
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

class ThumbnailResponse {
  String? name;
  String? hash;
  String? ext;
  String? mime;
  String? path;
  int? width;
  int? height;
  double? size;
  String? url;

  ThumbnailResponse(
      {this.name,
      this.hash,
      this.ext,
      this.mime,
      this.path,
      this.width,
      this.height,
      this.size,
      this.url});

  ThumbnailResponse.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    hash = map['hash'];
    ext = map['ext'];
    mime = map['mime'];
    path = map['path'];
    width = map['width'];
    height = map['height'];
    size = map['size'];
    url = map['url'];
  }

  @override
  String toString() {
    return 'ThumbnailResponse(name: $name, hash: $hash, ext: $ext, mime: $mime, path: $path, width: $width, height: $height, size: $size, url: $url)';
  }

  @override
  bool operator ==(covariant ThumbnailResponse other) {
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
