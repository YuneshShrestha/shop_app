import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/screen/cart_screen.dart';
import './provider/products.dart';
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
      ],
      child: MaterialApp(
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.route: (context) => const ProductDetailScreen(),
          CartScreen.route: (context) => const CartScreen()
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
