import 'package:flutter/foundation.dart';

class CartItem {
  String? id;
  String? title;
  int? quantity;
  double? price;
  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  final Map<String, CartItem>? _items = {};
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
              quantity: existingProduct.quantity! + 1,
              price: existingProduct.price));
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
}
