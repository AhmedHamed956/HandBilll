import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/home/featured_product_response.dart';
import 'package:hand_bill/src/data/response/market/company_categories_response.dart';
import 'package:hand_bill/src/data/response/market/company_details_response.dart';
import 'package:hand_bill/src/data/response/market/company_product_response.dart';

class CompanyRepository {
  String tag = "CompanyRepository";
  var dio = Dio();

  Future<CompanyDetailsResponse> getCompanyDetail(
      {required String companyId}) async {
    Map<String, String> queryParams =
    ({ "company_id": companyId});

    late CompanyDetailsResponse companyDetailsResponse;
    try {
      Response response = await dio.get(APIData.getCompanyDetails,
          queryParameters: queryParams);
      companyDetailsResponse = CompanyDetailsResponse.fromJson(response.data);
      log("\ncompanyDetails: ${jsonEncode(response.data)}");
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return companyDetailsResponse;
  }

  Future<FeaturedProductsResponse> getFeaturedProductOfCompany(
      {required String id}) async {
    Map<String, String> queryParams =
        ({"secret": APIData.secretKey, "company_id": id});

    late FeaturedProductsResponse featuredProductsResponse;
    // try {
    Response response = await dio.get(APIData.getFeaturedProductOfCompany,
        queryParameters: queryParams);
    featuredProductsResponse = FeaturedProductsResponse.fromJson(response.data);
    // } catch (error, stackTrace) {
    //   print("$tag error : $error , stackTrace:  $stackTrace");
    // }
    return featuredProductsResponse;
  }

  Future<CompanyProductsResponse> getCompanyProducts(
      {required String companyId, required int page}) async {
    Map<String, String> queryParams = ({
      "secret": APIData.secretKey,
      "company_id": companyId,
      'paginate': '8',
      'page': '$page'
    });
    late CompanyProductsResponse companyProductsResponse;
    // try {
    Response response =
        await dio.get(APIData.getCompanyProducts, queryParameters: queryParams);
    companyProductsResponse = CompanyProductsResponse.fromJson(response.data);
    // } catch (error, stackTrace) {
    //   print("$tag error : $error , stackTrace:  $stackTrace");
    // }
    return companyProductsResponse;
  }

  Future<CompanyCategoriesResponse> getCompanyCategories(
      {required String companyId}) async {
    Map<String, String> queryParams = ({'company_id': companyId});

    late CompanyCategoriesResponse companyCategoriesResponse;
    // try {
    Response response = await dio.get(APIData.getCompanyCategories,
        queryParameters: queryParams);
    companyCategoriesResponse =
        CompanyCategoriesResponse.fromJson(response.data);
    if (companyCategoriesResponse.status!) {
      return companyCategoriesResponse;
    } else {
      return companyCategoriesResponse;
    }
    // } catch (error, stackTrace) {
    //   print("$tag error : $error , stackTrace:  $stackTrace");
    // }
    // return companyCategoriesResponse;
  }
}
