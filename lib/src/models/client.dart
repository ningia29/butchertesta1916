import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const LAST_NAME = "lastName";
  static const ADDRESS = "address";
  static const CAP = "cap";
  static const TELEPHONE = "telephone";
  static const CITY = "city";

  String _id;
  String _image;
  String _name;
  String _lastName;
  String _address;
  String _cap;
  String _telephone;
  String _city;

//  getters
  String get id        => _id;
  String get image     => _image;
  String get name      => _name;
  String get lastName  => _lastName;
  String get address   => _address;
  String get cap       => _cap;
  String get telephone => _telephone;
  String get city      => _city;

  ClientModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id        = snapshot.data[ID];
    _image     = snapshot.data[IMAGE];
    _name      = snapshot.data[NAME];
    _lastName  = snapshot.data[LAST_NAME];
    _address   = snapshot.data[ADDRESS];
    _cap       = snapshot.data[CAP];
    _telephone = snapshot.data[TELEPHONE];
    _city      = snapshot.data[CITY];
  }

}