class ProductEntity {
  final String id;
  final String createdAt;
  final String name;
  final ProduitDetails details;
  final int stock;

  ProductEntity({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.details,
    required this.stock,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      createdAt: json['createdAt'],
      name: json['name'],
      details: ProduitDetails.fromJson(json['details']),
      stock: json['stock'],
    );
  }
}

class ProduitDetails {
  final String price;
  final String description;
  final String color;

  ProduitDetails({
    required this.price,
    required this.description,
    required this.color,
  });

  factory ProduitDetails.fromJson(Map<String, dynamic> json) {
    return ProduitDetails(
      price: json['price'],
      description: json['description'],
      color: json['color'],
    );
  }
}
