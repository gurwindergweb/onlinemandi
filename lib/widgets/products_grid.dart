import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(10,20,10,15),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            // builder: (c) => products[i],
            value: products[i],
            child: ProductItem(
                // products[i].id,
                // products[i].title,
                // products[i].imageUrl,
                ),
          ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 6 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}