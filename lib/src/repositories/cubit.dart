import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../common/api_data.dart';
import '../data/response/home/serviceCategory_reponse.dart';

class ServiceRepository {
  Dio _dio = Dio();

  // Future<void> getWalletAmount() async {
  //  var queryParameters = {"secret": APIData.secretKey};
  //   //   CategoriesResponse? categoriesResponse;
  //   //   Response response;
  //   //   try {
  //   //     response = await _dio.get(APIData.getCategories,
  //   //         queryParameters: queryParameters);
  //   //     categoriesResponse = CategoriesResponse.fromJson(response.data);
  //   //     log("getCategoriesData: ${jsonEncode(response.data)}");
  //   //     if (categoriesResponse.status!) {
  //   //       return categoriesResponse;
  //   //     } else {
  //   //       return categoriesResponse;
  //   //     }
  //   //   } catch (error, stackTrace) {
  //   //     print("$tag error : $error , stackTrace:  $stackTrace");
  //   //   }
  //   //   return categoriesResponse!;
  //   // }

  // }

  String tag = "ServiceRepository";

  Future<ServiceResponse> getServicesData() async {
    var queryParameters = {"secret": APIData.secretKey};
    ServiceResponse? serviceResponse;
    Response response;
    try {
      response = await _dio.get(APIData.getCompanyCategories,
          queryParameters: queryParameters);
      serviceResponse = ServiceResponse.fromJson(response.data);
      log("dtaaaaaaaaaaaaa: ${jsonEncode(response.data)}");
      if (serviceResponse.status!) {
        return serviceResponse;
      } else {
        return serviceResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return serviceResponse!;
  }
}
