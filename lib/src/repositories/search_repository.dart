import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/search/search_categories_response.dart';
import 'package:hand_bill/src/data/response/search/search_companies_response.dart';
import 'package:hand_bill/src/data/response/search/search_product_response.dart';

import '../data/model/Search_data.dart';

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

  Future<SearchCompaniesResponse> getSearchCompanies(String search) async {
    Map<String, String> queryParams =
        ({"secret": APIData.secretKey, "search": '$search'});

    late SearchCompaniesResponse companyResponse;
    try {
      Response response =
          await dio.get(APIData.searchMarkets, queryParameters: queryParams);
      log("getSearchCompanies: ${jsonEncode(response.data)}");

      companyResponse = SearchCompaniesResponse.fromJson(response.data);
      if (companyResponse.status!) {
        return companyResponse;
      } else {
        return companyResponse;
      }
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return companyResponse;
  }

  Future<SearchCategoriesResponse> getAllCategories() async{
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

  Future<SearchCategoriesResponse> getAllSubCategories(int id) async{

    Map<String, String> queryParams =
    ({ "id": '$id'});

    late SearchCategoriesResponse searchCategoriesResponse;
    try {
      Response response =
      await dio.get(APIData.searchSubCategories,queryParameters: queryParams);
      log("getSearchSubCategories: ${jsonEncode(response.data)}");

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

}
