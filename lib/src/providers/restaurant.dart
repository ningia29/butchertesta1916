import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/helpers/restaurant.dart';
import 'package:butchertesta1916/src/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier{
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];

  RestaurantModel restaurant;

  RestaurantProvider.inizialize(){
    _loadRestaurants();
  }

  _loadRestaurants()async{
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({int restaurantID})async{
    restaurant = await _restaurantServices.getRestaurantById(id: restaurantID);
    notifyListeners();
  }

  Future search({String name}) async {
    searchedRestaurants = await _restaurantServices.searchRestaurant(restaurantName: name);
    notifyListeners();
  }

}