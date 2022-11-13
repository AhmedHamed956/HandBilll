import '../../model/Search_data.dart';

class SearchCategoriesResponse {
  List<SearchData>? data;
  bool? status;
  String? message;

  SearchCategoriesResponse({this.data, this.status, this.message});

  SearchCategoriesResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SearchData>[];
      json['data'].forEach((v) {
        data!.add(new SearchData.fromJson(v));
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

