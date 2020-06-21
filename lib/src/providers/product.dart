import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/helpers/product.dart';
import 'package:butchertesta1916/src/models/product.dart';

class ProductProvider with ChangeNotifier{
  ProductServices _productServices = ProductServices();
  List<ProductModel> products = [];
  List<ProductModel> productsByCategory = [];
  List<ProductModel> productsByRestaurant = [];
  List<ProductModel> productsSearched = [];
  ProductModel productsById;

  ProductProvider.inizialize(){
    print("===== providers\product.dart inizialize prima 1===========");
    _loadProducts();
    print("===== providers\product.dart inizialize dopo 2===========");
  }

  _loadProducts ()async{
    print("===== providers\product.dart LoadProducts prima 3===========");
    products = await _productServices.getProducts();
    print("===== providers\product.dart LoadProducts dopo  4===========");
    notifyListeners();
    print("===== providers\product.dart inizialize prima 5===========");
  }

  Future loadProductsById ({String id})async{
    productsById = await _productServices.getProductsById(id: id);
    notifyListeners();
  }
  Future loadProductsByCategory ({String categoryName})async{
    productsByCategory = await _productServices.getProductsOfCategory(category: categoryName);
    notifyListeners();
  }

  Future loadProductsByRestaurant({int restaurantId})async{
    productsByRestaurant = await _productServices.getProductsByRestaurant(id: restaurantId);
    notifyListeners();
  }

  Future search({String productName})async{
    productsSearched = await _productServices.searchProducts(productName: productName);
    notifyListeners();
  }
}