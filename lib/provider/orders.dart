import 'package:flutter/widgets.dart';
import 'package:shop_app/provider/cart.dart';

class OrderItem {
  String? id;
  double? amt;
  List<CartItem>? products;
  DateTime? dateTime;
  OrderItem({this.id, this.amt, this.products, this.dateTime});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItem, double amt) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amt: amt,
            products: cartItem,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
