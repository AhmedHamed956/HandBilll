class SubCategoryModel {
  List<SubCategoryModelData>? data;
  bool? status;
  String? message;

  SubCategoryModel({this.data, this.status, this.message});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubCategoryModelData>[];
      json['data'].forEach((v) {
        data!.add(new SubCategoryModelData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class SubCategoryModelData {
  int? id;
  String? name;

  SubCategoryModelData({this.id, this.name});

  SubCategoryModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
