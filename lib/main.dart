import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/auth.dart';
import './screen/auth_screen.dart';
import './screen/edit_product_screen.dart';
import './provider/cart.dart';
import './provider/orders.dart';
import './provider/products.dart';
import './screen/cart_screen.dart';
import './screen/order_screen.dart';
import './screen/user_products_screen.dart';

import './screen/product_detail_screen.dart';
import './screen/product_overview_screen.dart';
import './screen/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (context, auth, periviousProducts) => Products(
            auth.token ?? "",
            auth.userId ?? "",
            periviousProducts == null ? [] : periviousProducts.items,
          ),
          create: (context) => Products('', '', []),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders('', [], ''),
          update: (context, auth, previousOrders) => Orders(
            auth.token!,
            previousOrders!.orders,
            auth.userId!,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          // print("Main Screen: ${auth.isAuth}");
          return MaterialApp(
            home: auth.isAuth
                ? const ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, authSnapShot) {
                      var hello = auth.tryAutoLogin().then((result) {
                        return result;
                      });
                      // print("auto:" + hello.toString());

                      return authSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    }),
            routes: {
              ProductOverviewScreen.route: (context) =>
                  const ProductOverviewScreen(),
              ProductDetailScreen.route: (context) =>
                  const ProductDetailScreen(),
              CartScreen.route: (context) => const CartScreen(),
              OrderScreen.route: (context) => const OrderScreen(),
              UserProductsScreen.route: (context) => const UserProductsScreen(),
              EditProductScreen.route: (context) => const EditProductScreen()
            },
            theme: ThemeData(
                fontFamily: 'Lato',
                colorScheme:
                    ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                        .copyWith(secondary: Colors.orange)),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
