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
    );
  }
}
