class ProductResponse {
  String? name;
  String? description;
  String? price;
  String? stock;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  dynamic images;

  ProductResponse({
    this.name,
    this.description,
    this.price,
    this.stock,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
    this.images,
  });

  ProductResponse.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    description = map['description'];
    price = map['price'];
    stock = map['stock'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
    publishedAt = map['publishedAt'];
    images = map['images'];
  }

  @override
  String toString() {
    return 'ProductResponse(name: $name, description: $description, price: $price, stock: $stock, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt, images: $images)';
  }
}
