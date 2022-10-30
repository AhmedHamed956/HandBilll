import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/product/product_details_response.dart';
import 'package:hand_bill/src/data/response/product/products_response.dart';

class ProductsRepository {
  String tag = "ProductsRepository";
  Dio _dio = Dio();
  User? user;
  Future<ProductDetailsResponse> getProductDetail({required int id}) async {
    Map<String, String> queryParameters = {"secret": APIData.secretKey};
    late ProductDetailsResponse productDetailResponse;
    // try {
      Response response = await _dio.get('${APIData.productDetails}/$id',
          queryParameters: queryParameters);
      productDetailResponse = ProductDetailsResponse.fromJson(response.data);
      log("\ngetProductDetail$id: ${jsonEncode(response.data)}");
    // } catch (error, stackTrace) {
    //   print("$tag =>  error : $error , stackTrace : $stackTrace");
    // }
    return productDetailResponse;
  }

  Future<ProductsResponse> getProductsBySubCategory(
      {required String subcategoryId, required int page}) async {
    Map<String, String> queryParams = ({
      "secret": APIData.secretKey,
      'paginate': '12',
      'page': '$page',
      'sub_sub_category_id': subcategoryId,
    });
    late ProductsResponse productsResponse;
    Response response;
    // try {
      response = await _dio.get(APIData.productBySubCategory,
          queryParameters: queryParams);
      log("\ngetProductsBySubCategory: ${jsonEncode(response.data)}");
      productsResponse = ProductsResponse.fromJson(response.data);
      if (productsResponse.status!) {
        return productsResponse;
      } else {
        return productsResponse;
      }
    // } catch (error, stackTrace) {
    //   print("$tag error : $error , stackTrace:  $stackTrace");
    // }
    // return productsResponse;
  }
}
