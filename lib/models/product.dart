import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });

  // Convert Product to Map for Hive storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'iconCodePoint': icon.codePoint,
      'iconColorValue': iconColor.value,
      'bgColorValue': bgColor.value,
    };
  }

  // Restore Product from Map
  factory Product.fromMap(Map<dynamic, dynamic> map) {
    return Product(
      id: map['id'] as String,
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      icon: IconData(map['iconCodePoint'] as int, fontFamily: 'MaterialIcons'),
      iconColor: Color(map['iconColorValue'] as int),
      bgColor: Color(map['bgColorValue'] as int),
    );
  }
}