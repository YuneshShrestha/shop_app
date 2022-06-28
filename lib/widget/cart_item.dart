import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CartItem extends StatelessWidget {
  String id;
  String title;
  int quantity;
  double price;
  CartItem(this.id, this.title, this.quantity, this.price, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text("Rs $price")),
          ),
          title: Text(title),
          subtitle: Text("Total: ${price*quantity}"),
          trailing: Text("$quantity X"),
        ),
      ),
    );
  }
}
