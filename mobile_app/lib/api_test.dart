import 'dart:convert';
import 'models/user.dart';

void testJsonParsing() {
  String dummyJson = '''
  {
    "id": 1,
    "username": "farmer_john",
    "products": [
      {
        "id": 101,
        "name": "Tomatoes",
        "description": "Fresh organic tomatoes",
        "price": 15.50,
        "quantity": 30
      },
      {
        "id": 102,
        "name": "Carrots",
        "description": "Crunchy sweet carrots",
        "price": 12.00,
        "quantity": 50
      }
    ]
  }
  ''';

  var data = jsonDecode(dummyJson);
  var user = UserModel.fromJson(data);

  print("User: ${user.username}");
  for (var p in user.products) {
    print("Product: ${p.name} - ${p.price}");
  }
}
