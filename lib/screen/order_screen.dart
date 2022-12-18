import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart';
import '../widget/main_drawer.dart';
import '../widget/order_item.dart' as widget_order_item;

class OrderScreen extends StatefulWidget {
  static const route = "/order_screen";
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future? _ordersData;
  Future _setOrdersData() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
  }

  @override
  void initState() {
    super.initState();
    _ordersData = _setOrdersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Screen"),
      ),
      drawer: const MainDrawer(),
      body: FutureBuilder(
        future: _ordersData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(child: Text("Error Occured!"));
            } else {
              return Consumer<Orders>(
                  builder: (ctx, orderItems, child) => ListView.builder(
                        itemCount: orderItems.orders.length,
                        itemBuilder: (context, index) {
                          return widget_order_item.OrderItem(
                              orderItems.orders[index]);
                        },
                      ));
            }
          }
        },
      ),
    );
  }
}
