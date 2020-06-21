import 'dart:math';

import 'package:butchertesta1916/src/models/user.dart';
import 'package:butchertesta1916/src/screens/order_complete.dart';
import 'package:butchertesta1916/src/screens/product_details.dart';
import 'package:butchertesta1916/src/screens/login.dart';
import 'package:butchertesta1916/src/widgets/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:butchertesta1916/src/helpers/screen_navigation.dart';
import 'package:butchertesta1916/src/helpers/style.dart';
import 'package:butchertesta1916/src/providers/app.dart';
import 'package:butchertesta1916/src/providers/category.dart';
import 'package:butchertesta1916/src/providers/product.dart';
import 'package:butchertesta1916/src/providers/restaurant.dart';
import 'package:butchertesta1916/src/providers/user.dart';
import 'package:butchertesta1916/src/screens/cart.dart';
import 'package:butchertesta1916/src/screens/category.dart';
import 'package:butchertesta1916/src/screens/order.dart';
import 'package:butchertesta1916/src/screens/product_search.dart';
import 'package:butchertesta1916/src/screens/restaurant.dart';
import 'package:butchertesta1916/src/screens/restaurant_search.dart';
import 'package:butchertesta1916/src/widgets/categories.dart';
import 'package:butchertesta1916/src/widgets/custom_text.dart';
import 'package:butchertesta1916/src/widgets/featured_products.dart';
import 'package:butchertesta1916/src/widgets/loading.dart';
import 'package:butchertesta1916/src/widgets/restaurant.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final user = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<UserProvider>(context);
//    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

//    print("============= home > ${productProvider.products[1]} ===========");

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: white),
        elevation: 0.5,
        backgroundColor: primary,
        title: CustomText(
          text: "Macelleria Testa dal 1916",
          color: white,
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () {
                  changeScreen(context, CartScreen());
                },
              ),
//              Positioned(
//                top: 12,
//                right: 12,
//                child: Container(
//                  height: 10,
//                  width: 10,
//                  decoration: BoxDecoration(
//                      color: green, borderRadius: BorderRadius.circular(20.0)),
//                ),
//              ),
            ],
          ),
//          Stack(
//            children: <Widget>[
//              IconButton(
//                icon: Icon(Icons.notifications),
//                onPressed: () {},
//              ),
//              Positioned(
//                top: 12,
//                right: 12,
//                child: Container(
//                  height: 10,
//                  width: 10,
//                  decoration: BoxDecoration(
//                      color: green, borderRadius: BorderRadius.circular(20.0)),
//                ),
//              ),
//            ],
//          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primary),
              accountName: CustomText(
                text: user.userModel?.name ?? "username loading...",
                color: white,
                weight: FontWeight.bold,
                size: 18,
              ),
              accountEmail: CustomText(
                text: user.userModel?.email ?? "email loading...",
                color: white,
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.home),
              title: CustomText(text: "Home"),
            ),
            ListTile(
              onTap: () async {
                await user.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.receipt),
              title: CustomText(text: "Ordini"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_basket),
              title: CustomText(text: "Carrello"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, OrderComplete());
              },
              leading: Icon(Icons.people),
              title: CustomText(text: "Clienti"),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.settings),
              title: CustomText(text: "Settings"),
            ),
            ListTile(
              onTap: () async {
                await authProvider.signOut();
                changeScreenReplacement(context, Login());
              },
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Esci"),
            ),
          ],
        ),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.search,
                            color: red,
                          ),
                          title: TextField(
                            textInputAction: TextInputAction.search,
                            onSubmitted: (pattern) async {
                              app.changeLoading();
                              if (app.search == SearchBy.PRODUCTS) {
                                await productProvider.search(
                                    productName: pattern);
                                changeScreen(context, ProductSearchScreen());
                              } else {
                                changeScreen(context, RestaurantSearchScreen());
                              }
                              app.changeLoading();
                            },
                            decoration: InputDecoration(
                              hintText: "Find product",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(color: black),
//            ============== Elenco delle categorie ==============
                  Container(
                    height: 80,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProvider.categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
//                        app.changeLoading();
                              await productProvider.loadProductsByCategory(
                                  categoryName:
                                      categoryProvider.categories[index].name);
//                        app.changeLoading();
                              changeScreen(
                                  context,
                                  CategoryScreen(
                                    categoryModel:
                                        categoryProvider.categories[index],
                                  ));
                            },
                            child: CategoryWidget(
                              category: categoryProvider.categories[index],
                            ),
                          );
                        }),
                  ),
                  Divider(color: Colors.black),
//            ============== Sezione Elenco prodotti =============
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 1.0, 1.0, 1.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomText(
                          text: "Elenco prodotti",
                          size: 20,
                          color: grey,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: productProvider.products
                        .map((item) => GestureDetector(
                              onTap: () async {
                                changeScreen(
                                    context,
                                    Details(
                                      product: item,
                                    ));
                              },
                              child: ProductWidget(
                                product: item,
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
