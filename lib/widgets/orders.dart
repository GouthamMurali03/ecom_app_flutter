import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../providers/order.dart' show OrderItem;

class OrderWidget extends StatefulWidget {
  final OrderItem orderitem;

  OrderWidget({this.orderitem});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderitem.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                .format(widget.orderitem.datetime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: min(widget.orderitem.products.length * 20.0 + 10, 100),
              // child: ListView.builder(itemBuilder: (ctx, i)=> Row(children: [
              //   Text('${widget.orderitem.products}')
              // ],),
              // itemCount: widget.orderitem.products.length,),
              child: ListView(
                children: widget.orderitem.products.map(
                  (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${e.quantity} X \$${e.price}',
                          style: TextStyle(color: Colors.green.shade600),
                        )
                      ]),
                ).toList(),
              ),
            )
        ],
      ),
    );
  }
}
