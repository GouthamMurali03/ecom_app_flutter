import 'package:flutter/material.dart';
import '../providers/cart.dart';
import './/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final singleproduct = Provider.of<Product>(context, listen: false);
    final cartlistener = Provider.of<Cart>(context, listen: false);
    // We are using the COnsumer in th Icon widget. So this Provider is not used so we are making the listener off
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: singleproduct.id);
          },
          child: Image.network(
            singleproduct.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            singleproduct.title,
            textAlign: TextAlign.center,
          ),
          // _ in builder in the consumer refers to the child. SInce wqe don't have any use for child
          // functionlity, we use _
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              onPressed: () {
                product.toggleFavourite();
              },
              icon: product.isFavourite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              color: Theme.of(context).accentColor,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              cartlistener.addItem(
                  singleproduct.id, singleproduct.price, singleproduct.title);
            },
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
