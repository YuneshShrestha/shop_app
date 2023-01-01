import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helper/custom_route.dart';
import '../provider/auth.dart';
import '../screen/user_products_screen.dart';
import '../screen/order_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 18.0,
                  child: Text(
                      authProvider.userMail!.substring(0, 1).toUpperCase(),
                      style: Theme.of(context).textTheme.headline6),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                FittedBox(
                  child: Text(
                    authProvider.userMail!,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
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
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.route);
              // Navigator.of(context).pushReplacement(CustomRoute(builder: (context) =>const OrderScreen(),));
            },
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
