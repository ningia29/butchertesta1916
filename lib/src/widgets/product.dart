import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/helpers/screen_navigation.dart';
import 'package:butchertesta1916/src/helpers/style.dart';
import 'package:butchertesta1916/src/models/product.dart';
import 'package:butchertesta1916/src/providers/product.dart';
import 'package:butchertesta1916/src/providers/restaurant.dart';
import 'package:butchertesta1916/src/screens/restaurant.dart';
import 'package:provider/provider.dart';

import 'custom_text.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;

  const ProductWidget({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
      child: Card(
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5.0,
        child: ListTile(
          title: CustomText(text: product.name),
          subtitle: CustomText(text: "\€${product.price / 100}", weight: FontWeight.bold,),
        ),
      ),
    );
  }
}
