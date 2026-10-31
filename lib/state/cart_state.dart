import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/product.dart';

class CartState {
  static final Box _box = Hive.box('cart_box');

  // Load initial cart state from Hive box
  static final ValueNotifier<List<Product>> cartNotifier = ValueNotifier<List<Product>>(_loadFromHive());

  static List<Product> _loadFromHive() {
    final rawList = _box.get('items', defaultValue: []) as List;
    return rawList.map((e) => Product.fromMap(Map<dynamic, dynamic>.from(e as Map))).toList();
  }

  // Save updated list to Hive
  static Future<void> _saveToHive(List<Product> items) async {
    final rawList = items.map((e) => e.toMap()).toList();
    await _box.put('items', rawList);
  }

  // Add item to cart & persist
  static void addToCart(Product product) {
    final updatedList = [...cartNotifier.value, product];
    cartNotifier.value = updatedList;
    _saveToHive(updatedList);
  }

  // Remove item by index & persist
  static void removeFromCart(int index) {
    final updatedList = List<Product>.from(cartNotifier.value);
    updatedList.removeAt(index);
    cartNotifier.value = updatedList;
    _saveToHive(updatedList);
  }

  // Clear all items after checkout
  static void clearCart() {
    cartNotifier.value = [];
    _box.delete('items');
  }

  static double get totalPrice {
    return cartNotifier.value.fold(0, (sum, item) => sum + item.price);
  }
}