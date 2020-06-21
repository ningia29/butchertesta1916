import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:butchertesta1916/src/models/order.dart';
import 'package:butchertesta1916/src/models/user.dart';

class OrderServices {
  String collection = "orders";
  Firestore _firestore = Firestore.instance;

  void createOrder({String userId, String id, String description, List cart, int totalPrice, String status}) {
    _firestore.collection(collection).document(id).setData({
      "userId": userId,
      "id": id,
      "description": description,
      "cart": cart,
      "total": totalPrice,
      "status": status,
      "createdAt": DateTime.now().millisecondsSinceEpoch
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async =>
      _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .getDocuments()
          .then((result) {
        List<OrderModel> orders = [];
        for(DocumentSnapshot order in result.documents){
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });
}

