import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../provider/cart.dart';

class OrderItem {
  final String id;
  final double amt;
  final List<CartItem> products;
  final DateTime dateTime;
  const OrderItem(
      {required this.id,
      required this.amt,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  final String authToken;
  final String userId;
  Orders(this.authToken, this._orders, this.userId);

  Future<void> fetchAndSetOrder() async {
    final url =
        "https://myapp-8ae0f-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body) as Map<String, dynamic>?;
    List<OrderItem> loadedOrders = [];

    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderID, orderData) {
      loadedOrders.insert(
          0,
          OrderItem(
              id: orderID,
              amt: orderData['amount'],
              dateTime: DateTime.parse(orderData['dateTime']),
              products: (orderData['products'] as List<dynamic>)
                  .map((item) => CartItem(
                        id: item['id'],
                        title: item['title'],
                        quantity: item['quantity'],
                        price: item['price'],
                      ))
                  .toList()));
    });
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartItem, double amt) async {
    final url =
        "https://myapp-8ae0f-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";
    final timestamp = DateTime.now();
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            "amount": amt,
            "dateTime": timestamp.toIso8601String(),
            "products": cartItem
                .map(
                  (item) => {
                    "id": item.id,
                    "title": item.title,
                    "quantity": item.quantity,
                    "price": item.price,
                  },
                )
                .toList()
          },
        ),
      );
      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amt: amt,
            products: cartItem,
            dateTime: timestamp,
          ));
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
