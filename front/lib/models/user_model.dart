class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String image;
  final String password;

  User(
      {required this.id,
      required this.image,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user_id'],
        image: json['image_url'],
        name: json['username'],
        email: json['email'],
        phoneNumber: json['phone'],
        password: json['password']);
  }
}
