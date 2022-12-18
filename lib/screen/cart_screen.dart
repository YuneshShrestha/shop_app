import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart' as carts;
import '../provider/orders.dart';
import '../widget/cart_item.dart' as cart_item;

class CartScreen extends StatelessWidget {
  static const route = '/cart_screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<carts.Cart>(context);
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
                        'Rs. ${cart.findTotal}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),

          // Product List
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (cxt, index) {
              return cart_item.CartItem(
                // cart.items.keys.toList()[index],
                cart.items.values.toList()[index].id,
                cart.items.values.toList()[index].title,
                cart.items.values.toList()[index].quantity,
                cart.items.values.toList()[index].price,
              );
            },
          ))
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final carts.Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;

  Future<void> addCart() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<Orders>(context, listen: false)
        .addOrder(widget.cart.items.values.toList(), widget.cart.findTotal);
    setState(() {
      isLoading = false;
    });
    widget.cart.clearItem();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.cart.findTotal <= 0
            ? null
            : () => addCart().catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Adding Order Failed $error")));
                }),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text("Order Now".toUpperCase()));
  }
}
