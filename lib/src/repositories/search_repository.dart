import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/search/search_categories_response.dart';
import 'package:hand_bill/src/data/response/search/search_companies_response.dart';
import 'package:hand_bill/src/data/response/search/search_product_response.dart';

import '../data/model/Search_data.dart';
import '../data/response/home/serviceCategory_reponse.dart';
import '../data/response/search/Search_sub_sub.dart';
import '../data/response/search/search_sub_categorie.dart';

class SearchRepository {
  String tag = "SearchRepository";
  var dio = Dio();

  Future<SearchProductResponse> getSearchProducts(String search) async {
    Map<String, String> queryParams = ({
      // "secret": APIData.secretKey,
      "search": '$search',
    });

    late SearchProductResponse searchResponse;
    Response response;
    try {
      response =
          await dio.get(APIData.searchProduct, queryParameters: queryParams);
      log("sss: ${jsonEncode(response.data)}");
      print(response.data);
      searchResponse = SearchProductResponse.fromJson(response.data);
       print(searchResponse.data);
      if (searchResponse.status!) {
        return searchResponse;
      } else {
        return searchResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return searchResponse;
  }


  Future<SearchCompaniesResponse> getSearchCompanies(String search) async {
    Map<String, String> queryParams =
        ({ "search": '$search'});

    late SearchCompaniesResponse companyResponse;
    try {
      Response response =
          await dio.get(APIData.searchCompanies, queryParameters: queryParams);
      log("getSearchCompanies: ${jsonEncode(response.data)}");

      companyResponse = SearchCompaniesResponse.fromJson(response.data);
      print(companyResponse.data!.first.name);
      if (companyResponse.data != null) {
        return companyResponse;
      } else {
        return companyResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return companyResponse;
  }
  Future<SearchCompaniesResponse> getServiceCompanies(int search) async {
    Map<String, dynamic> queryParams =
    ({ "category_id": '$search'});

    late SearchCompaniesResponse companyResponse;
    try {
      Response response =
      await dio.get(APIData.searchCompanies, queryParameters: queryParams);
      log("getSearchCompanies: ${jsonEncode(response.data)}");

      companyResponse = SearchCompaniesResponse.fromJson(response.data);
      print(companyResponse.data!.first.name);
      if (companyResponse.data != null) {
        return companyResponse;
      } else {
        return companyResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return companyResponse;
  }

  Future<ServiceResponse> getCategoryCompanies() async {
    var queryParameters = {"secret": APIData.secretKey};
     ServiceResponse? serviceResponse;
    Response response;

    try {
       response =
      await dio.get(APIData.getCompanyCategories,queryParameters: queryParameters);

      serviceResponse = ServiceResponse.fromJson(response.data);
       log("getSearchCompanies:[ ${jsonEncode(response.data)}]");
       // print(serviceResponse.data!.first.name);
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


  Future<SearchCategoriesResponse>  getAllCategories() async{
   late SearchCategoriesResponse searchCategoriesResponse;
    try {
      Response response =
      await dio.get(APIData.searchCategories,);
      log("getSearchCategories: ${jsonEncode(response.data)}");

      searchCategoriesResponse = SearchCategoriesResponse.fromJson(response.data);
      if (searchCategoriesResponse.status!) {
        return searchCategoriesResponse;
      } else {
        return searchCategoriesResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return searchCategoriesResponse;
  }

  Future<SearchSubCategoriesResponse> getAllSubCategories(int id) async{

    Map<String, String> queryParams =
    ({ "id": '$id'});

    late SearchSubCategoriesResponse searchCategoriesResponse;
    try {
      Response response =
      await dio.get(APIData.searchSubCategories,queryParameters: queryParams);
      log("getSearchSubSubCategories: ${jsonEncode(response.data)}");

      searchCategoriesResponse = SearchSubCategoriesResponse.fromJson(response.data);
      if (searchCategoriesResponse.status!) {
        return searchCategoriesResponse;
      } else {
        return searchCategoriesResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return searchCategoriesResponse;
  }

  Future<SearchSubSubCategoriesResponse> getSubSubCategories(int id) async{

    Map<String, String> queryParams =
    ({ "id": '$id'});

    late SearchSubSubCategoriesResponse searchSubSubCategoriesResponse;
    try {
      Response response =
      await dio.get(APIData.searchSubSubCategories,queryParameters: queryParams);
      log("getSearchSubCategories: ${jsonEncode(response.data)}");

      searchSubSubCategoriesResponse = SearchSubSubCategoriesResponse.fromJson(response.data);
      if (searchSubSubCategoriesResponse.status!) {
        return searchSubSubCategoriesResponse;
      } else {
        return searchSubSubCategoriesResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return searchSubSubCategoriesResponse;
  }

  Future<SearchProductResponse> getSearchProduct(int id) async {
    Map<String, String> queryParams = ({
      // "secret": APIData.secretKey,
      "sub_sub_category_id": '$id',
    });

    late SearchProductResponse searchResponse;
    Response response;
    try {
      response =
      await dio.get(APIData.searchProduct, queryParameters: queryParams);
      log("getSearchProducts: ${jsonEncode(response.data)}");
      searchResponse = SearchProductResponse.fromJson(response.data);
      if (searchResponse.status!) {
        return searchResponse;
      } else {
        return searchResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return searchResponse;
  }

}
