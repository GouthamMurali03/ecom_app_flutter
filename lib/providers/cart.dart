import 'package:flutter/material.dart';

class CartItem {
  final String cartItemId;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {@required this.cartItemId,
      @required this.price,
      @required this.quantity,
      @required this.title});
}

class Cart with ChangeNotifier {
  // Here we map a product idto a cart Item. So that when a same product is added, we will increase the quantity, else we will add that as new cart item.
  // CartItem id is different from productId and In this map, the productId is the key where the CartItem is the value for the key.
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

// In add item, we don't pass the quantity in the method as the quantity is always cosnidered as 1
// ProducId, Price and title are received as inputs while calling the assItem method
// We use DateTimeNow as a unique CartItemID as of now.
  void addItem(String productId, double prodPrice, String prodTitle) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
              cartItemId: existingCartItem.cartItemId,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1,
              title: existingCartItem.title));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
              cartItemId: DateTime.now().toString(),
              price: prodPrice,
              title: prodTitle,
              quantity: 1));
    }
    notifyListeners();
  }

  int get itemCount {
    return _cartItems.length;
  }

  double get totalPrice {
    var total = 0.0;
    _cartItems.forEach((key, cartitem) {
      total += cartitem.price * cartitem.quantity;
    });
    return total;
  }

  void removeItem(productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }
}
