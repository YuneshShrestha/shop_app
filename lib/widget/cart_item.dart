import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';

// ignore: must_be_immutable
class CartItem extends StatelessWidget {
  String productId;
  String id;
  String title;
  int quantity;
  double price;
  CartItem(this.productId, this.id, this.title, this.quantity, this.price,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        padding: const EdgeInsets.only(right: 20.0),
        color: Theme.of(context).errorColor,
        child: const Icon(Icons.delete, color: Colors.white, size: 40.0),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text("Rs $price")),
            ),
            title: Text(title),
            subtitle: Text("Total: ${price * quantity}"),
            trailing: Text("$quantity X"),
          ),
        ),
      ),
    );
  }
}
