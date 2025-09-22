import 'product.dart';

class UserModel {
  final int id;
  final String username;
  final List<Product> products;

  UserModel({required this.id, required this.username, required this.products});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var productList = (json['products'] as List)
        .map((p) => Product.fromJson(p))
        .toList();

    return UserModel(
      id: json['id'],
      username: json['username'],
      products: productList,
    );
  }
}
