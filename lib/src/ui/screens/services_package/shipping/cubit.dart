import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_bill/src/data/model/category/sub.dart';
import 'package:hand_bill/src/data/model/category/sub_sub.dart';

import 'package:hand_bill/src/ui/screens/services_package/shipping/states.dart';

import '../../../../common/api_data.dart';
import '../../../../data/model/services/companies.dart';

class ShippingBloc extends Cubit<InterState> {
  ShippingBloc() : super(CubitIntialStates());
  static ShippingBloc get(context) => BlocProvider.of(context);

  String tag = "ShippingBloc";

  Dio _dio = Dio();
  Future<void> getdata() async {}

  // CompanyModel? companyModel;

  // void getCategory({required subNature}) async {
  //   Map<String, String> queryParams = ({
  //     "secret": APIData.secretKey,
  //     // "page": page.toString(),
  //     // "paginate": "6",
  //     // "nature_activity": "shipping",
  //     // "category_id": subNature
  //   });
  //   late CompanyResponse companyResponse;
  //   emit(ShopIntresLoadingState());
  //   try {
  //     Response response = await _dio.get(
  //         APIData.getShippingCompanies + subNature,
  //         queryParameters: queryParams);
  //     print("getShippingCompanies: ${response.data.toString()}");
  //     companyResponse = CompanyResponse.fromJson(response.data);
  //     emit(ShopIntresSuccessStates());
  //   } catch (error, stackTrace) {
  //     print("$tag error : $error , stackTrace:  $stackTrace");
  //     emit(ShopIntresErrorStates(error.toString()));
  //   }
  //   return companyResponse;
  // }

  CompanyModel? companyModel;
  Future<void> getCategory({required subNature}) async {
    Map<String, String> queryParams = ({
      "secret": APIData.secretKey,
      // "page": page.toString(),
      // "paginate": "6",
      // "nature_activity": "shipping",
      //  "category_id": subNature
    });
    _dio
        .get(APIData.getShippingCompanies + subNature)
        .then((value) {
      companyModel = CompanyModel.fromJson(value.data);
      emit(ShopIntresSuccessStates());
    }).catchError((error) {
      emit(ShopIntresErrorStates(error.toString()));
    });
    // DioHelper.getdata(url: gift, token: token).then((value) {
    //   giftModel = GiftModel.fromJson(value.data);
    //   print(value.data);
    //   emit(GetGiftSuccessStates());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(GetGiftErrorStates());
    // });
  }

  SubCategoryModel? subCategoryModel;
  Future<void> getSubCategories({required id}) async {
    print(id.toString());
    Map<String, dynamic> queryParams = ({
      // "secret": APIData.secretKey,
      "id": id,
      'language':'ar'
      // "page": page.toString(),
      // "paginate": "6",
      // "nature_activity": "shipping",
      // "category_id": subNature
    });
    _dio.get(APIData.getSubCategory, queryParameters: queryParams).then((value) {
      subCategoryModel = SubCategoryModel.fromJson(value.data);
      print(value.data);
      emit(GetSubCatSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetSubCatErrorStates(error.toString()));
    });
    // DioHelper.getdata(url: gift, token: token).then((value) {
    //   giftModel = GiftModel.fromJson(value.data);
    //   print(value.data);
    //   emit(GetGiftSuccessStates());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(GetGiftErrorStates());
    // });
  }

  SubSubCategoryModel? subsubCategoryModel;
  Future<void> getSubsubCategories({required id}) async {
    print(id);
    print('sdsdsdsd');
    Map<String, dynamic> queryParams = ({
      // "secret": APIData.secretKey,
      "id": id,
      'language':'ar'
      // "page": page.toString(),
      // "paginate": "6",
      // "nature_activity": "shipping",
      // "category_id": subNature
    });
    _dio.post(APIData.getSubsubCategory, data: queryParams).then((value) {
      subsubCategoryModel = SubSubCategoryModel.fromJson(value.data);
      print(value.data);
      emit(GetSubSubCatSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetSubSubCatErrorStates(error.toString()));
    });
    // DioHelper.getdata(url: gift, token: token).then((value) {
    //   giftModel = GiftModel.fromJson(value.data);
    //   print(value.data);
    //   emit(GetGiftSuccessStates());
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(GetGiftErrorStates());
    // });
  }
}
