import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:butchertesta1916/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  String collection = "users";
  Firestore _firestore = Firestore.instance;

  void createUser(Map<String, dynamic> values){
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  void updateUserData(Map<String, dynamic> values){
    _firestore.collection(collection).document(values['id']).updateData(values);
  }

  void addToCart({String userId, Map cartItem}){

    print("the user id is: $userId");
    print("cart items are: ${cartItem.toString()}");

    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayUnion([cartItem])
    });
  }

  void removeFromCart({String userId, Map cartItem}){
    _firestore.collection(collection).document(userId).updateData({
      "cart": FieldValue.arrayRemove([cartItem])
    });
  }

  Future<UserModel> getUserById(String id) => _firestore.collection(collection).document(id).get().then((doc){
      return UserModel.fromSnapshot(doc);
  });
}