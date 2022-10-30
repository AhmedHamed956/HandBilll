import 'package:hand_bill/src/data/model/local/images.dart';
import 'package:hand_bill/src/data/model/user.dart';

class HandmadeModel {
  int? _id;
  String? _userId;
  String? _description;
  String? _title;
  String? _price;
  String? _createdAt;
  String? _updatedAt;
  User? _user;
  List<ImageModel>? _images;

  int? get id => _id;
  String? get userId => _userId;
  String? get description => _description;
  String? get title => _title;
  String? get price => _price;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  User? get user => _user;
  List<ImageModel>? get images => _images;

  HandmadeModel({
    int? id,
    String? userId,
    String? description,
    String? title,
    String? price,
    String? createdAt,
    String? updatedAt,
    User? user,
    List<ImageModel>? images}){
    _id = id;
    _userId = userId;
    _description = description;
    _title = title;
    _price = price;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _images = images;
  }

  HandmadeModel.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _description = json["description"];
    _title = json["title"];
    _price = json["price"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    if (json["images"] != null) {
      _images = [];
      json["images"].forEach((v) {
        _images?.add(ImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["description"] = _description;
    map["title"] = _title;
    map["price"] = _price;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    if (_user != null) {
      map["user"] = _user?.toJson();
    }
    if (_images != null) {
      map["images"] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  set price(String ?value) {
    _price = value;
  }

  set title(String ?value) {
    _title = value;
  }

  set description(String? value) {
    _description = value;
  }
}