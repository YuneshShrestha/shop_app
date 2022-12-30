import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth.dart';
import '../screen/user_products_screen.dart';
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
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.route),
            leading: const Icon(Icons.edit),
            title: const Text("Manage Products"),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              // pop closes the drawer
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logOut();
            },
            leading: const Icon(Icons.logout),
            title: const Text("Log Out"),
          ),
        ],
      ),
    );
  }
}
