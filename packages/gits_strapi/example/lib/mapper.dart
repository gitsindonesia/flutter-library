import 'package:example/entity/product_entity.dart';
import 'package:example/model/product_response.dart';

extension ProductResponseMapper on ProductResponse {
  ProductEntity toEntity<T extends Object>() => ProductEntity(
        name: name,
        description: description,
        price: price,
        stock: stock,
        createdAt: createdAt,
        updatedAt: updatedAt,
        publishedAt: publishedAt,
        images: images,
      );
}
