import 'package:flutter/material.dart';
import '../screens/drawer.dart';
import '../widgets/orders.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: MainDrawer(),
        body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, i) => OrderWidget(
            orderitem: orderData.orders[i],
          ),
        ));
  }
}
