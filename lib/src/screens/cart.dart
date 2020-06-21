import 'package:butchertesta1916/src/helpers/product.dart';
import 'package:butchertesta1916/src/helpers/screen_navigation.dart';
import 'package:butchertesta1916/src/models/product.dart';
import 'package:butchertesta1916/src/providers/product.dart';
import 'package:butchertesta1916/src/screens/order_complete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/helpers/order.dart';
import 'package:butchertesta1916/src/helpers/style.dart';
import 'package:butchertesta1916/src/providers/app.dart';
import 'package:butchertesta1916/src/providers/user.dart';
import 'package:butchertesta1916/src/widgets/custom_text.dart';
import 'package:butchertesta1916/src/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    try {
      UserProvider.initialize();
      print(
          "============== cart.dart > ${user.userModel.cart.length} ============");
    } catch (e) {}
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(
          text: "Shopping Cart",
        ),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: app.isLoading
          ? Loading()
          : ListView.builder(
              itemCount: user.userModel.cart.length,
              itemBuilder: (_, index) {
                double quantity = user.userModel.cart[index]["quantity"] / 1000;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5.0,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: CustomText(text: user.userModel.cart[index]["name"]),
                        subtitle: CustomText(text: "Quantità: $quantity ${user.userModel.cart[index]["productUnit"]}",),
                        trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: red,
                            ),
                            onPressed: () async {
                              app.changeLoading();
                              bool value = await user.removeFromCart(
                                  cartItem: user.userModel.cart[index]);
                              if (value) {
                                user.reloadUserModel();
                                print("item deleted from cart");
                                _key.currentState.showSnackBar(SnackBar(
                                    content: Text("Removed from cart!")));
                                app.changeLoading();
                                return;
                              } else {
                                print("item was not removed");
                                app.changeLoading();
                              }
                            }),
                      ),
                    ],
                  ),
                );
              }),
      bottomNavigationBar: Container(
        color: Colors.grey[300],
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Totale:",
                    style: TextStyle(
                        color: black,
                        fontSize: 22,
                        fontWeight: FontWeight.w400)),
                TextSpan(
                    text: " \€ ${user.userModel.totalCartPrice / 100000}",
                    style: TextStyle(
                        color: primary,
                        fontSize: 22,
                        fontWeight: FontWeight.normal)),
              ])),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: primary),
                child: FlatButton(
                    onPressed: () {
                      if (user.userModel.totalCartPrice == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Your cart is empty',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Close",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'You will be charged \€${user.userModel.totalCartPrice / 100} upon delivery!',
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: FlatButton(
                                          onPressed: () async {
                                            changeScreen(context, OrderComplete());
//                                            var uuid = Uuid();
//                                            String id = uuid.v4();
//                                            _orderServices.createOrder(
//                                                userId: user.user.uid,
//                                                id: id,
//                                                description: "some random description",
//                                                status: "complete",
//                                                totalPrice: user.userModel.totalCartPrice,
//                                                cart: user.userModel.cart);
//                                            for (Map cartItem
//                                                in user.userModel.cart) {
//                                              bool value =
//                                                  await user.removeFromCart(
//                                                      cartItem: cartItem);
//                                              if (value) {
//                                                user.reloadUserModel();
//                                                print("item added to cart");
//                                                _key.currentState.showSnackBar(
//                                                    SnackBar(
//                                                        content: Text(
//                                                            "Removed from cart!")));
//                                              } else {
//                                                print("item was not removed");
//                                              }
//                                            }
//                                            _key.currentState.showSnackBar(
//                                                SnackBar(
//                                                    content: Text(
//                                                        "Order created!")));
//                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Accept",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: const Color(0xFF1BC0C5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Abbandona",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: CustomText(
                      text: "Check out",
                      size: 20,
                      color: white,
                      weight: FontWeight.normal,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
