import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/product_item.dart';
import '../provider/products.dart';

class ProductsGrid extends StatelessWidget {
  bool? showFavs;
  ProductsGrid({
    this.showFavs,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context, listen: false);
    final products =
        showFavs == true ? productData.showFavs : productData.items;
    return GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 2,
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int i) {
          return ChangeNotifierProvider.value(
            value: products[i],
            child: const ProductItem(),
          );
        });
  }
}
