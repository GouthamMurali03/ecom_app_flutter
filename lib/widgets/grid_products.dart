import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';
import './product_item.dart';

class GridProducts extends StatelessWidget {
  final bool showFavs;

  GridProducts(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productsList = Provider.of<ProductsProviders>(context);
    final productData = showFavs ? productsList.favouriteItems : productsList.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: productData.length,
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              // Here we are using provider.value instead of provider because we are recycling a single widget. And we are not dependent on the context.
              value: productData[index],
              child: ProductItem(),
            ));
  }
}
