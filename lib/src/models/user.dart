import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
//  definizione delle variabili dei nomi del database (non il dato, ma il nome del campo)
  static const ID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";
  static const CLIENT = "client";
  static const ADDRESS = "address";


  String _name;
  String _email;
  String _id;
  String _stripeId;
  int _priceSum = 0;

//  getters
  String get name => _name;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;

//  public variable
  List cart;
  int totalCartPrice;

 UserModel.fromSnapshot(DocumentSnapshot snapshot){
   _name = snapshot.data[NAME];
   _email = snapshot.data[EMAIL];
   _id = snapshot.data[ID];
   _stripeId = snapshot.data[STRIPE_ID] ?? '';
   cart = snapshot.data[CART] ?? [];
   totalCartPrice = getTotalPrice(cart: cart);
 }

 int getTotalPrice({List cart}){
   for(Map cartItem in cart){
     _priceSum += cartItem["price"] * cartItem["quantity"];
   }
//   int total = _priceSum;
   int total = _priceSum;
   return total;
 }
//
// List<CartItemModel> _convertCartItem(List<Map> cart){
//   List<CartItemModel> convertedCart = [];
//   for(Map cartItem in cart){
//     convertedCart.add(CartItemModel.fromMap(cartItem));
//   }
//   return convertedCart;
// }
}