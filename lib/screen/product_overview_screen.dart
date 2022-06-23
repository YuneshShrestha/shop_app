import 'package:flutter/material.dart';
import 'package:shop_app/widget/products_grid.dart';

enum FilterOptions { favourites, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool showFavs = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                if (selectedValue == FilterOptions.favourites) {
                  setState(() {
                    showFavs = true;
                  });
                } else {
                  setState(() {
                    showFavs = false;
                  });
                }
              },
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text('Only Favourites'),
                      value: FilterOptions.favourites,
                    ),
                    const PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOptions.all,
                    ),
                  ]),
        ],
      ),
      body: ProductsGrid(showFavs: showFavs),
    );
  }
}
