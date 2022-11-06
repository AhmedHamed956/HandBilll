import 'package:hand_bill/src/data/model/product.dart';

class SearchProductResponse {
  dynamic? _status;
  List<Product>? _data;
  dynamic? _message;

  dynamic? get status => _status;

  List<Product>? get data => _data;

  dynamic? get message => _message;

  SearchProductResponse({dynamic? success, List<Product>? data, dynamic? message}) {
    _status = success;
    _data = data;
    _message = message;
  }

  SearchProductResponse.fromJson(dynamic json) {
    _status = json["status"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data!.add(Product.fromJson(v));
      });
    }
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_data != null) {
      map["data"] = _data!.map((v) => v.toJson()).toList();
    }
    map["message"] = _message;
    return map;
  }
}
