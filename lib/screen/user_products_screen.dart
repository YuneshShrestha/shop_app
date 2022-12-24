import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screen/edit_product_screen.dart';
import 'package:shop_app/widget/main_drawer.dart';
import '../provider/products.dart';
import '../widget/user_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const route = "/user_products_screen";
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsListener = Provider.of<Products>(context);
    Future<void> getRefreshedProducts() async {
      await productsListener.fetchAndSetProducts(true);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.route);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const MainDrawer(),
      body: FutureBuilder(
        future: getRefreshedProducts(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: getRefreshedProducts,
                child: ListView.builder(
                    itemCount: productsListener.items.length,
                    itemBuilder: (ctx, index) => Column(
                          children: [
                            UserItem(
                              id: productsListener.items[index].id,
                              title: productsListener.items[index].title,
                              imageUrl: productsListener.items[index].imageUrl,
                            ),
                            const Divider(),
                          ],
                        )),
              ),
      ),
    );
  }
}
