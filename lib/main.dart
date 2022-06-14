import 'package:flutter/material.dart';
import 'package:shop_app/screen/product_detail_screen.dart';
import 'package:shop_app/screen/product_overview_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductOverviewScreen(),
      routes: {
        ProductDetailScreen.route: (context) => const ProductDetailScreen()
      },
      theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.orange)),
      debugShowCheckedModeBanner: false,
    );
  }
}
