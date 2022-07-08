import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart' show Cart;
import 'package:shop_app/provider/orders.dart';
import 'package:shop_app/widget/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const route = '/cart_screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  const Spacer(),
                  Chip(
                      label: Text(
                        '${cart.findTotal}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  TextButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                            cart.items.values.toList() as List<CartItem>,
                            cart.findTotal);
                        cart.clearItem();
                      },
                      child: Text("Order Now".toUpperCase()))
                ],
              ),
            ),
          ),

          // Product List
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (cxt, index) {
              return CartItem(
                  // cart.items.keys.toList()[index],
                  cart.items.values.toList()[index].id!,
                  cart.items.values.toList()[index].title!,
                  cart.items.values.toList()[index].quantity!,
                  cart.items.values.toList()[index].price!);
            },
          ))
        ],
      ),
    );
  }
}
