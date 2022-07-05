import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const route = '/product_detail_screen';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final product =
        Provider.of<Products>(context, listen: false).getProductById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                "Rs ${product.price}",
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              width: double.infinity,
              child: Text(
                product.description!,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
