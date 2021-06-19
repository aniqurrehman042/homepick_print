import 'package:flutter/material.dart';
import 'package:homepick_print/styles/theme_colors.dart';

class ProductsHeader extends StatelessWidget {
  const ProductsHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.themeBlack,
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'PRODUCT NAME',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(width: 20.0),

          Expanded(
            child: Text(
              'QTY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(width: 20.0),

          Expanded(
            child: Text(
              'PRICE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(width: 20.0),

          Expanded(
            child: Text(
              'TOTAL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
