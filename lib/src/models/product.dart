import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const DESCRIPTION = "description";
  static const PRICE = "price";
  static const CATEGORY = "category";
  static const TYPE = "type";
  static const UNIT = "unit";

  String _id;
  String _name;
  String _image;
  String _description;
  String _category;
  String _type;
  String _unit;
  int _price;

//  getters

  String get id => _id;
  String get name => _name;
  String get image => _image;
  String get description => _description;
  String get category => _category;
  String get type => _type;
  String get unit => _unit;
  int get price => _price;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data[ID];
    _name = snapshot.data[NAME];
    _image = snapshot.data[IMAGE];
    _description = snapshot.data[DESCRIPTION];
    _category = snapshot.data[CATEGORY];
    _price = snapshot.data[PRICE];
    _type = snapshot.data[TYPE];
    _unit = snapshot.data[UNIT];
  }

}