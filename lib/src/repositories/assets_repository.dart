import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/response/services/assets_response.dart';

class AssetsRepository {
  String tag = "AssetsRepository";
  Dio _dio = Dio();

  Future<AssetsResponse> getAssetsData() async {


    late AssetsResponse assetsResponse;
    try {
      Response response =
          await _dio.get(APIData.getAssetsData);
      assetsResponse = AssetsResponse.fromJson(response.data);
      // log("${jsonEncode(response.data)}");

    } catch (error, stackTrace) {
      print("$tag error : $error , stackTrace:  $stackTrace");
    }
    return assetsResponse;
  }
}
