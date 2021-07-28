// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product({
    required this.available,
    required this.name,
    this.picture,
    required this.price,
    this.id,
  });

  bool available;
  String name;
  String? picture;
  double price;
  String? id; // Se lo creo manual

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };

  // Al pulsar sobre un registro vamos a obtener una copia de Product para mostralo
  Product copy() => Product(
      available: available,
      name: name,
      picture: picture,
      price: price,
      id: this.id);
}
