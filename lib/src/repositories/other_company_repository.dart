import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/services/shipping_response.dart';

class OtherCompanyRepository {
  String tag = "OtherCompanyRepository";
  Dio _dio = Dio();

  Future<CompanyResponse> getShippingCompanies(
      {
      // required int page,
      required String subNature}) async {
    Map<String, String> queryParams = ({
      "secret": APIData.secretKey,
      // "page": page.toString(),
      // "paginate": "6",
      // "nature_activity": "shipping",
      // "category_id": subNature
    });
    late CompanyResponse companyResponse;
    try {
      Response response = await _dio.get(
          APIData.getShippingCompanies + subNature,
          queryParameters: queryParams);
      print("getShippingCompanies: ${response.data.toString()}");
      companyResponse = CompanyResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return companyResponse;
  }

  Future<CompanyResponse> getCustomsCompanies({required int page}) async {
    Map<String, String> queryParams = ({
      "secret": APIData.secretKey,
      "page": page.toString(),
      "paginate": "6",
      "nature_activity": "customs_clearance"
    });

    late CompanyResponse companyResponse;
    try {
      Response response = await _dio.get(APIData.getCustomsCompanies,
          queryParameters: queryParams);
      companyResponse = CompanyResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return companyResponse;
  }
}
