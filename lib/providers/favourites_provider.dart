import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product.dart';

class FavouritesProvider with ChangeNotifier {
  List<Product> _favourites = [];

  List<Product> get favourites => _favourites;

  bool isFavourite(int id) {
    return _favourites.any((item) => item.id == id);
  }

  void toggleFavourite(Product product) {
    if (isFavourite(product.id)) {
      _favourites.removeWhere((item) => item.id == product.id);
    } else {
      _favourites.add(product);
    }
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('favourites');
    if (data != null) {
      List jsonData = json.decode(data);
      _favourites = jsonData.map((e) => Product.fromJson(e)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = json.encode(_favourites.map((e) => _productToJson(e)).toList());
    prefs.setString('favourites', data);
  }

  Map<String, dynamic> _productToJson(Product product) => {
    "id": product.id,
    "title": product.title,
    "price": product.price,
    "description": product.description,
    "category": product.category,
    "image": product.image,
    "rating": {
      "rate": product.rating,
      "count": product.count,
    },
  };
}
