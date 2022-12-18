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

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(create: (context) => Orders()),
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MaterialApp(
        home: const AuthScreen(),
        routes: {
          ProductOverviewScreen.route: (context) =>
              const ProductOverviewScreen(),
          ProductDetailScreen.route: (context) => const ProductDetailScreen(),
          CartScreen.route: (context) => const CartScreen(),
          OrderScreen.route: (context) => const OrderScreen(),
          UserProductsScreen.route: (context) => const UserProductsScreen(),
          EditProductScreen.route: (context) => const EditProductScreen()
        },
        theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.orange)),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
