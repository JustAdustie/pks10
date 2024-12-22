class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String feature;
  int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.feature,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['product_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      description: json['description'],
      feature: json['features'],
      price: json['price'].toDouble(),
      stock: json['stock'],
    );
  }
}
