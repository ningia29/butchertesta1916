import 'package:flutter/material.dart';
import 'package:butchertesta1916/src/helpers/category.dart';
import 'package:butchertesta1916/src/models/category.dart';

class CategoryProvider with ChangeNotifier{
  CategoryServices _categoryServices = CategoryServices();
  List<CategoryModel> categories = [];

  CategoryProvider.inizialize(){
    _loadCategories();
  }
  
  _loadCategories ()async{
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }

}