import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:butchertesta1916/src/models/product.dart';

class ProductServices {
  String collection = "products";
  Firestore _firestore = Firestore.instance;

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection(collection).getDocuments().then((result) {
        List<ProductModel> products = [];
        for(DocumentSnapshot product in result.documents){
          products.add(ProductModel.fromSnapshot(product));
        }
        print("===== helpers / product.dart > GetProducts ${products[1]} ===========");
        return products;
      });

  void likeOrDislikeProduct({String id, List<String> userLikes}){
    _firestore.collection(collection).document(id).updateData({
      "userLikes": userLikes
    });
  }

  Future<ProductModel> getProductsById({String id}) async =>
      _firestore
          .collection(collection)
          .document(id)
          .get()
          .then((doc) {
          return ProductModel.fromSnapshot(doc);
      });

  Future<List<ProductModel>> getProductsByRestaurant({int id}) async =>
      _firestore
          .collection(collection)
          .where("restaurantId", isEqualTo: id)
          .getDocuments()
          .then((result) {
        List<ProductModel> products = [];
        for(DocumentSnapshot product in result.documents){
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> getProductsOfCategory({String category}) async =>
      _firestore
          .collection(collection)
          .where("category", isEqualTo: category)
          .getDocuments()
          .then((result) {
        List<ProductModel> products = [];
        for(DocumentSnapshot product in result.documents){
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });

  Future<List<ProductModel>> searchProducts({String productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    print("============== helpers/product > search: $searchKey ==============");
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<ProductModel> products = [];
      for (DocumentSnapshot product in result.documents) {
        products.add(ProductModel.fromSnapshot(product));
      }
      return products;
    });
  }
}