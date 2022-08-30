import 'package:gits_strapi/gits_strapi.dart';

class ProductResponseWithImages {
  String? name;
  String? description;
  String? price;
  String? stock;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  CollectionResponse<DataResponse<ImageResponse>>? images;

  ProductResponseWithImages({
    this.name,
    this.description,
    this.price,
    this.stock,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.images,
  });

  ProductResponseWithImages.fromMap(
      Map<String, dynamic> map, Function(Map<String, dynamic>) build) {
    name = map['name'];
    description = map['description'];
    price = map['price'];
    stock = map['stock'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
    publishedAt = map['publishedAt'];
    images = map['images'] != null ? build(map['images']) : null;
  }
}
