import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/products.dart';
import './screen/product_detail_screen.dart';
import './screen/product_overview_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => Products(),
      child: MaterialApp(
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.route: (context) => const ProductDetailScreen()
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
