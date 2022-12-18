import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  const CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem>? _items = {};
  Map<String, CartItem> get items {
    return {..._items!};
  }

  int get itemCount {
    return _items!.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items!.containsKey(productId)) {
      // change quantity
      _items!.update(
          productId,
          (existingProduct) => CartItem(
              id: existingProduct.id,
              title: existingProduct.title,
              quantity: existingProduct.quantity + 1,
              price: existingProduct.price,));
    } else {
      // items list ma tyo product id xaina bhnae naya product add garnu natra mathi
      // ko if chalayera quantity badhaunu
      _items!.putIfAbsent(
          productId,
          () =>
              CartItem(id: productId, title: title, price: price, quantity: 1));
    }
    notifyListeners();
  }

  void removeSingleProduct(String productId) {
    if (!_items!.containsKey(productId)) {
      return;
    }
    if (_items![productId]!.quantity > 1) {
      _items!.update(
          productId,
          (existingItem) => CartItem(
              id: existingItem.id,
              title: existingItem.title,
              quantity: existingItem.quantity - 1,
              price: existingItem.price));
    } else {
      _items!.remove(productId);
    }
    notifyListeners();
  }

  double get findTotal {
    double price = 0.0;
    items.forEach((key, data) {
      price += data.quantity * data.price;
    });
    return price;
  }

  void removeItem(productId) {
    _items!.remove(productId);
    notifyListeners();
  }

  void clearItem() {
    _items = {};
    notifyListeners();
  }
}
