import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/auth.dart';
import '../provider/cart.dart';
import '../provider/product.dart';
import '../screen/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // here i kept listen false so that build method will not run again but it caused error so i fixed it
    var product = Provider.of<Product>(context);
    var cart = Provider.of<Cart>(context);
    final authData = Provider.of<Auth>(context);
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProductDetailScreen.route,
          arguments: product.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: GridTile(
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
          footer: GridTileBar(
              backgroundColor: Colors.black87,
              leading: Consumer<Product>(
                builder: (context, value, child) {
                  return IconButton(
                    onPressed: () {
                      product.toggleFavrouite(authData.token!, authData.userId!);
                    },
                    icon: product.isFavourite
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_outline),
                    color: Colors.orange,
                  );
                },
              ),
              title: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Added to Cart'),
                    duration: const Duration(seconds: 3),
                    action: SnackBarAction(
                      label: 'DISMISS',
                      onPressed: () {
                        cart.removeSingleProduct(product.id);
                      },
                    ),
                  ));
                },
                icon: const Icon(Icons.shopping_cart),
                color: Theme.of(context).colorScheme.secondary,
              )),
        ),
      ),
    );
  }
}
