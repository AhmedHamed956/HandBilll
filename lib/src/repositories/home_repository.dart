import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/home/top_banner_response.dart';
import 'package:hand_bill/src/data/response/home/top_company_respons.dart';
import 'package:hand_bill/src/data/response/home/top_products_response.dart';

import 'package:http/http.dart' as http;

class HomeRepository {
  String tag = "HomeRepository";
  Dio _dio = Dio();

  Future<TopBannerResponse> geySliderData() async {
    var queryParameters = {"secret": APIData.secretKey};
    TopBannerResponse? sliderResponse;
    try {
    Response response =
          await _dio.get(APIData.getSliders, queryParameters: queryParameters);
       // log("geySliderData: ${jsonEncode(response.data)}");
      sliderResponse = TopBannerResponse.fromJson(response.data);
      return sliderResponse;
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return sliderResponse!;
  }

  Future<TopCompanyResponse> getTopCompaniesData() async {
    var queryParameters = {"secret": APIData.secretKey};
    TopCompanyResponse? topCompanyResponse;
    print('omnia');
    print('dataaomniaaaaa');
    print('dataa');

    try {
      Response response =
      await _dio.get(APIData.getTopCompanies, queryParameters: queryParameters);
      log("getTopCompaniesData: ${jsonEncode(response.data)}");
      topCompanyResponse = TopCompanyResponse.fromJson(response.data);
      return topCompanyResponse;
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return topCompanyResponse!;
  }

  Future<TopProductsResponse> getPopularData() async {
    var queryParameters = {
      "secret": APIData.secretKey,
      "trending": "week",
      "limit": "6"
    };
    TopProductsResponse? topProductsResponse;
    try {
      Response response =
      await _dio.get(APIData.getPopular, queryParameters: queryParameters);
      // log("getPopularData: ${jsonEncode(response.data)}");
      topProductsResponse = TopProductsResponse.fromJson(response.data);
      return topProductsResponse;
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return topProductsResponse!;
  }
}
