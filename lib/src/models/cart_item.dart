class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const PRODUCT_UNIT = "productUnit";
  static const QUANTITY = "quantity";
  static const PRICE = "price";

  String _id;
  String _name;
  String _image;
  String _productId;
  String _productUnit;
  int _quantity;
  int _price;

//  getters

  String get id => _id;
  String get name => _name;
  String get image => _image;
  String get productId => _productId;
  String get productUnit => _productUnit;
  int get quantity => _quantity;
  int get price => _price;

  CartItemModel.fromMap(Map data){
    _id        = data[ID];
    _name      = data[NAME];
    _image     = data[IMAGE];
    _productId = data[PRODUCT_ID];
    _productUnit = data[PRODUCT_UNIT];
    _quantity  = data[QUANTITY];
    _price     = data[PRICE];
  }

  Map toMap() => {
    ID         : _id,
    NAME       : _name,
    IMAGE      : _image,
    PRODUCT_ID : _productId,
    PRODUCT_UNIT : _productUnit,
    QUANTITY   : _quantity,
    PRICE      : _price,
  };

}