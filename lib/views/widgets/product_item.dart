import 'package:flutter/material.dart';
import 'package:homepick_print/data/models/product.dart';
import 'package:homepick_print/providers/home_page_provider.dart';
import 'package:homepick_print/styles/theme_colors.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    this.productIndex,
  });

  final int productIndex;

  @override
  Widget build(BuildContext context) {
    var homePageProvider = context.watch<HomePageProvider>();
    var product = homePageProvider.products[productIndex];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ThemeColors.themeBlack,
            width: 4.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
              onChanged: (value) => homePageProvider.updateProduct(Product(name: value), productIndex),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: TextField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) => homePageProvider.updateProduct(Product(qty: value.isNotEmpty ? int.parse(value) : 0), productIndex),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: TextField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) => homePageProvider.updateProduct(Product(price: value.isNotEmpty ? double.parse(value) : 0.0), productIndex),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Text(
              (product.price * product.qty.toDouble()).toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
