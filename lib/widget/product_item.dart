import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  const ProductItem(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: GridTile(
        child: Image.network(imageUrl!, fit: BoxFit.cover),
        footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              title!,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.secondary,
            )),
      ),
    );
  }
}
