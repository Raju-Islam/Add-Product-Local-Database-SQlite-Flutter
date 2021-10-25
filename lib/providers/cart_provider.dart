// ignore_for_file: prefer_final_fields, avoid_function_literals_in_foreach_calls

import 'package:flutter/cupertino.dart';
import 'package:product_app_demo/model/productModel.dart';

class CartPorvider extends ChangeNotifier {
  List<Product> _cartItems = [];
  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeAll() {
    _cartItems.clear();
    notifyListeners();
  }

  int get itemCount => _cartItems.length;
  double get totalprice {
    var total = 0.0;
    _cartItems.forEach((product) {
      total += product.price!;
    });
    return total;
  }
}
