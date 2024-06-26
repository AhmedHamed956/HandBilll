import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hand_bill/src/common/api_data.dart';
import 'package:hand_bill/src/data/model/user.dart';
import 'package:hand_bill/src/data/response/auth/edit_profile_response_.dart';
import 'package:hand_bill/src/data/response/auth/common_response.dart';
import 'package:hand_bill/src/data/response/auth/profile_response.dart';

class ProfileRepository {
  var tag = "ProfileRepository";
  var dio = Dio();

  // Future<ProfileResponse?> fetchData() async {
  //   Map<String, String> queryParams;

  //   queryParams = ({
  //     "secret": APIData.secretKey,
  //   });

  //   ProfileResponse? profileResponse;
  //   Response response;
  //   try {
  //     response =
  //         await dio.get(APIData.getProfile, queryParameters: queryParams);

  //     log("${jsonEncode(response.data)}");

  //     profileResponse = ProfileResponse.fromJson(response.data);
  //     if (profileResponse.status!) {
  //       return profileResponse;
  //     } else {
  //       return profileResponse;
  //     }
  //   } catch (error, stackTrace) {
  //     print("$tag error : $error , stackTrace:  $stackTrace");
  //   }
  //   return profileResponse;
  // }

//  Future<ProfileResponse?> fetchData() async {
//     Response response = await dio.get(APIData.getProfile);
//     ProfileResponse? profileResponse;
//     try {
//       profileResponse = ProfileResponse.fromJson(response.data);
//       log("fetchUserData: ${jsonEncode(profileResponse)}");
//     } catch (error, stackTrace) {
//       print("$tag error $error  stackTrace $stackTrace");
//     }
//     return profileResponse;
//   }

  Future<ProfileResponse?> fetchUserData({required User user}) async {
    Response response = await dio.get('${APIData.editProfile}${user.id}');

    ProfileResponse? profileResponse;
    try {
      profileResponse = ProfileResponse.fromJson(response.data);
      log("fetchUserData: ${jsonEncode(profileResponse)}");
    } catch (error, stackTrace) {
      print("$tag error $error  stackTrace $stackTrace");
    }
    return profileResponse;
  }

  Future<EditProfileResponse?> editProfile({required User user, File? image}) async {
    dio.options.headers["Authorization"] = "Bearer " + user.apiToken.toString();
    dio.options.headers["Accept"] = "application/json";
    FormData formData;
    if (image == null) {
      formData = FormData.fromMap({
        // "secret": APIData.secretKey,
        "name": user.name,
        "phone": user.phone.toString(),
        "address": user.address.toString()
      });
    } else {
      String fileName = image.path.split('/').last;
      formData = FormData.fromMap({
        "name": user.name,
        "phone": user.phone.toString(),
        "address": user.address.toString(),
        "image": await MultipartFile.fromFile(image.path, filename: fileName),
      });
    }

    Response response;

    EditProfileResponse? editProfileResponse;

    try {
      response = await dio.post(APIData.editProfile, data: formData);
      log("editProfile:${jsonEncode(response.data)}");
      editProfileResponse = EditProfileResponse.fromJson(response.data);
    } catch (error, stackTrace) {
      print("$tag error $error  stackTrace $stackTrace");
    }
    return editProfileResponse;
  }

  Future<CommonResponse?> changePassword(
      { required User user,
        required String currentPass,
        required String newPass}) async {
    FormData formData;

    formData = FormData.fromMap({
      "secret": APIData.secretKey,
      "current_password": currentPass,
      "new_password": newPass
    });
    dio.options.headers["Authorization"] = "Bearer " + user.apiToken.toString();
    dio.options.headers["Accept"] = "application/json";
    Response response;

    CommonResponse? forgetPasswordResponse;

    try {
      response = await dio.post(APIData.changePassword, data: formData);
      log("${jsonEncode(response.data)}");
      forgetPasswordResponse = CommonResponse.fromJson(response.data);
      print(
          "$tag  apiToken : ${user.apiToken} , name : ${user.name} , email : ${user.email}, phone : ${user.phone}, address :${user.address}");
    } catch (error, stackTrace) {
      print("$tag error $error  stackTrace $stackTrace");
    }
    return forgetPasswordResponse;
  }
}
