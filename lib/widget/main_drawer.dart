import 'package:flutter/material.dart';
import 'package:shop_app/screen/user_products_screen.dart';
import '../screen/order_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("Hello User!!!"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
          ),
          const Divider(),
          ListTile(
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(OrderScreen.route),
            leading: const Icon(Icons.list),
            title: const Text("Orders"),
          ),
          const Divider(),
          ListTile(
            onTap: ()=> Navigator.of(context).pushReplacementNamed(UserProductsScreen.route),
            leading: const Icon(Icons.edit),
            title: const Text("Manage Products"),

          ),
        ],
      ),
    );
  }
}
