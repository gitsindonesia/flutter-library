class ProductEntity {
  String? name;
  String? description;
  String? price;
  String? stock;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  dynamic images;

  ProductEntity(
      {this.name,
      this.description,
      this.price,
      this.stock,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.images});

  @override
  String toString() {
    return 'ProductEntity(name: $name, description: $description, price: $price, stock: $stock, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt, images: $images)';
  }
}
