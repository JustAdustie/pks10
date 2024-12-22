class Cart {
  final int id;
  final int userid;
  final int productid;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String feature;
  int quantity;
  int stock;

  Cart({
    required this.id,
    required this.userid,
    required this.productid,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.feature,
    required this.quantity,
    required this.stock,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['cart_id'],
      userid: json['user_id'],
      productid: json['product_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      description: json['description'],
      feature: json['features'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      stock: json['stock'],
    );
  }
}
