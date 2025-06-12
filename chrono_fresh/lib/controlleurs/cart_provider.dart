import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  int _cartItemCount = 0;

  int get cartItemCount => _cartItemCount;

  void addItem() {
    _cartItemCount++;
    notifyListeners();
  }
  

  void clearCart() {
    _cartItemCount = 0;
    notifyListeners();
  }
}
