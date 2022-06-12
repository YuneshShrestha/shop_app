import 'package:flutter/material.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/widget/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> productsList = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2,
              crossAxisCount: 2,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0),
          itemCount: productsList.length,
          itemBuilder: (BuildContext context, int i) {
            return ProductItem(
              id: productsList[i].id,
              description: productsList[i].description,
              imageUrl: productsList[i].imageUrl,
              price: productsList[i].price,
              title: productsList[i].title,
            );
          }),
    );
  }
}
