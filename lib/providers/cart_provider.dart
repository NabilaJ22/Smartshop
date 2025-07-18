import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  bool isInCart(int id) {
    return _cartItems.any((item) => item.id == id);
  }

  int get itemCount => _cartItems.length;

  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }
}
