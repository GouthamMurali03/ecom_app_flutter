import 'package:flutter/material.dart';
import '../providers/order.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartListener = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  // Spacer takes all the space between its previous widgets and the next widget leaving just enough space for the successive widgets to be placed
                  Chip(
                    label: Text(
                      '\$${cartListener.totalPrice}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline1
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<OrdersProvider>(context).addOrder(
                          cartListener.cartItems.values,
                          cartListener.totalPrice);

                      cartListener.clearCart();
                    },
                    child: Text('ORDER NOW'),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // List view builder cannot be directly used under a column. Use it under an expanded widget
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => CartItem(
                cartListener.cartItems.values.toList()[i].cartItemId,
                cartListener.cartItems.keys.toList()[i],
                cartListener.cartItems.values.toList()[i].title,
                cartListener.cartItems.values.toList()[i].price,
                cartListener.cartItems.values.toList()[i].quantity),
// We also need the productId, which is the unique value we use for deleting items in cart. productId is the key in our map.
//We acces it by using cartListener.cartItems.keys.toList(). We rae converting it to a list so we can go through every key based on its index.
// Very important:  Here, The actual cartItems is a map with key and values.
// In item builder, we are passing the respective values for every item based on its index.
// So In the map, we are taking all values, converting it to a list and then going thorugh every value
// based on its index using cartListener.cartItems.values.toList()[i].
            itemCount: cartListener.itemCount,
          ))
        ],
      ),
    );
  }
}
