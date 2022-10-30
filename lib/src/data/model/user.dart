import 'package:hand_bill/src/data/model/local/chat_user.dart';
import 'package:hand_bill/src/data/model/local/images.dart';

class User {
  int? _id;
  String? _isVerified;
  String? _deviceToken;
  String? _active;
  String? _apiToken;
  String? _address;
  String? _country;
  String? _email;
  String? _name;
  String? _phone;
  String? _password;
  String? _confirmpassword;

  SaveImageModel? _image;

  int? get id => _id;

  String? get isVerified => _isVerified;

  String? get deviceToken => _deviceToken;

  String? get active => _active;

  String? get apiToken => _apiToken;

  String? get address => _address;

  String? get country => _country;

  String? get email => _email;

  String? get name => _name;

  String? get phone => _phone;

  String? get password => _password;
  String? get confirmpassword => _confirmpassword;

  SaveImageModel? get image => _image;

  User(
      {int? id,
      String? isVerified,
      String? deviceToken,
      String? active,
      String? apiToken,
      String? address,
      String? country,
      String? email,
      String? username,
      String? phone,
      SaveImageModel? image,
      String? name}) {
    _id = id;
    _isVerified = isVerified;
    _deviceToken = deviceToken;
    _active = active;
    _apiToken = apiToken;
    _address = address;
    _country = country;
    _email = email;
    _name = name;
    _phone = phone;
    _image = image;
  }

  User.fromJson(dynamic json) {
    _id = json["id"];
    _isVerified = json["is_verified"];
    _deviceToken = json["device_token"];
    _active = json["active"];
    _apiToken = json["api_token"];
    _address = json["address"];
    _country = json["country"];
    _email = json["email"];
    _name = json["name"];
    _phone = json["phone"];
    _image =
        json["image"] != null ? SaveImageModel.fromJson(json["image"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["is_verified"] = _isVerified;
    map["device_token"] = _deviceToken;
    map["active"] = _active;
    map["api_token"] = _apiToken;
    map["address"] = _address;
    map["email"] = _email;
    map["name"] = name;
    map["country"] = _country;
    map["phone"] = _phone;
    if (_image != null) {
      map["image"] = _image?.toJson();
    }
    return map;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["email"] = _email;
    map["name"] = _name;
    map["thumb"] = image;
    map["country"] = _country;
    map["device_token"] = _deviceToken;
    return map;
  }

  set phone(String? value) {
    _phone = value;
  }

  set country(String? value) {
    _country = value;
  }

  set password(String? value) {
    _password = value;
  }

  set confirmpassword(String? value) {
    _confirmpassword = value;
  }

  set name(String? value) {
    _name = value;
  }

  set email(String? value) {
    _email = value;
  }

  set deviceToken(String? value) {
    _deviceToken = value;
  }

  bool profileCompleted() {
    return address != null &&
        address != '' &&
        phone != null &&
        phone != '' &&
        image != null &&
        image != ImageModel();
  }
}
