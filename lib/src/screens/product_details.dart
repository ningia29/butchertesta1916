import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/helpers/screen_navigation.dart';
import 'package:butchertesta1916/src/models/product.dart';
import 'package:butchertesta1916/src/providers/app.dart';
import 'package:butchertesta1916/src/screens/cart.dart';
import 'package:butchertesta1916/src/widgets/custom_text.dart';
import 'package:butchertesta1916/src/widgets/loading.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart';
import '../helpers/style.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 100;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(icon: Icon(Icons.close), onPressed: (){Navigator.pop(context);}),
      ),
      backgroundColor: white,
      body: SafeArea(
//        child: app.isLoading ? Loading() : Column(
        child: app.isLoading ? Loading() : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(widget.product.image),
            ),
            SizedBox(height: 15,),

            CustomText(text: widget.product.name,size: 26,weight: FontWeight.bold),
            CustomText(text: "\€${widget.product.price / 100}",size: 20,weight: FontWeight.w400),
            SizedBox(height: 10,),

            CustomText(text: "Description",size: 18,weight: FontWeight.w400),

            Padding(
              padding: const EdgeInsets.all(8.0),
//              child: Text(widget.product.description , textAlign: TextAlign.center, style: TextStyle(color: grey, fontWeight: FontWeight.w300),),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.remove,size: 36,), onPressed: (){
                    if(quantity != 100){
                      setState(() {
                        quantity -= 100;
                      });
                    }
                  }),
                ),

                GestureDetector(
                  onTap: ()async{
                    app.changeLoading();
                    bool value = await user.addToCart(product: widget.product, quantity: quantity);
                    if(value){
                      _key.currentState.showSnackBar(
                          SnackBar(content: Text("Added to cart!"))
                      );
                      user.reloadUserModel();
                      app.changeLoading();
                      return;
                    }else{
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: app.isLoading ? Loading() : Padding(
                      padding: const EdgeInsets.fromLTRB(28,12,28,12),
                      child: CustomText(text: "Add ${quantity / 1000} Kg To Cart",color: white,size: 22,weight: FontWeight.w300,),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(icon: Icon(Icons.add,size: 36,color: red,), onPressed: (){
                    setState(() {
                      quantity += 100;
                    });
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}