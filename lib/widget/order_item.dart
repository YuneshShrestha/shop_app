import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/orders.dart' as ord;

class OrderItem extends StatelessWidget {
  final ord.OrderItem item;
  const OrderItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            title: Text("Rs. ${item.amt}"),
            subtitle: Text(DateFormat("yyyy-MM-dd hh:mm a")
                .format(item.dateTime)),
            children: item.products.map((order) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Text(
                    "${order.quantity} X",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text("Rs. ${order.price}"),
                ],
              );
            }).toList(),
          );
  }
}
