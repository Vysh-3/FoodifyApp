import 'package:flutter/material.dart';
import 'package:figma_foodapp/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  void addToCart(ProductModel product, int quantity) {
   final existingIndex = _cartItems.indexWhere((item) => item.title == product.title);

    if (existingIndex != -1) {
      // ✅ If product already in cart, increase its quantity
      _cartItems[existingIndex].quantity += quantity;
    } else {
      // ✅ If not in cart, add it
      _cartItems.add(ProductModel(
        title: product.title,
        image: product.image,
        price: product.price,
        description: product.description,
        quantity: quantity, // ✅ Store quantity
      ));
    }

    notifyListeners();
  }

  /// ✅ Increases product quantity
  void increaseQuantity(ProductModel product) {
    final index = _cartItems.indexWhere((item) => item.title == product.title);
    if (index != -1) {
      _cartItems[index].quantity++;
      notifyListeners();
    }
  }

  /// ✅ Decreases product quantity (removes if 0)
  void decreaseQuantity(ProductModel product) {
    final index = _cartItems.indexWhere((item) => item.title == product.title);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeFromCart(ProductModel product) {
     _cartItems.removeWhere((item) => item.title == product.title);
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}
