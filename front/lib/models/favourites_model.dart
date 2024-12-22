class Favourites {
  final int id;
  final int userid;
  final int productid;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String feature;
  int stock;

  Favourites({
    required this.id,
    required this.userid,
    required this.productid,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.feature,
    required this.stock,
  });

  factory Favourites.fromJson(Map<String, dynamic> json) {
    return Favourites(
      id: json['favourite_id'],
      userid: json['user_id'],
      productid: json['product_id'],
      imageUrl: json['image_url'],
      name: json['name'],
      description: json['description'],
      feature: json['features'],
      price: json['price'].toDouble(),
      stock: json['stock'],
    );
  }
}
