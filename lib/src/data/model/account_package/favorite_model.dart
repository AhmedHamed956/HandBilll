import 'package:hand_bill/src/data/model/product.dart';

class FavoriteModel {
  int? _id;
  String? _userId;
  String? _productId;
  late Product _product;

  int? get id => _id;

  String? get userId => _userId;

  String? get productId => _productId;

  Product get product => _product;

  FavoriteModel(
      {int? id, String? userId, String? productId, required Product product}) {
    _id = id;
    _userId = userId;
    _productId = productId;
    _product = product;
  }

  FavoriteModel.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _productId = json["product_id"];
    _product =
        (json["product"] != null ? Product.fromJson(json["product"]) : null)!;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["product_id"] = _productId;

    map["product"] = _product.toJson();
    return map;
  }
}
