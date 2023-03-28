import 'dart:io';
import 'package:chat_app_flutter/models/commons/upload_image_response.dart';

import '../api_service/api_dio_intercepter.dart';
import 'package:dio/dio.dart';

import '../models/commons/common_response.dart';
import '../utils/shared/constants.dart';
import '../utils/shared/enums.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class BaseRepo {
  final dio = AppApi.dio;
  Future<dynamic> request({
    required String url,
    required Method method,
    var params,
  }) async {
    Response? response;

    try {
      if (method == Method.POST) {
        response = await dio!.post(url, data: params);
      } else if (method == Method.PUT) {
        response = await dio!.put(url, data: params);
      } else if (method == Method.DELETE) {
        response = await dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await dio!.patch(url);
      } else {
        response = await dio!.get(
          url,
          queryParameters: params,
        );
      }
      return response;
    } on SocketException catch(e) {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format!");
    } on DioError catch (e){
      return e.response;
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  Future sendImageStore({required File imageFile}) async {
    UploadImageResponse? uploadImageResponse;
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path)
    });
    try {
      Response response = await request(
          url: '${Constants.imageUploadUrl}?key=${Constants.keyImageUpload}',
          method: Method.POST,
          params: formData
      );
      uploadImageResponse = UploadImageResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: $e}');
    }
    return uploadImageResponse;
  }

  Future<CommonResponse?> requestFriend(String userId) async {
    CommonResponse? commonResponse;
    Map<String, dynamic> bodyData = {
      'user_id': userId,
      'status': FriendStatus.request.index
    };
    try {
      Response response = await request(
          url: Constants.requestFriend,
          method: Method.GET,
          params: bodyData
      );
      commonResponse = CommonResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: $e}');
    }
    return commonResponse;
  }

  Future<CommonResponse?> receiveFriend(String userId) async {
    Map<String, dynamic> bodyData = {
      'user_id': userId,
      'status': FriendStatus.accept.index
    };
    CommonResponse? commonResponse;
    try {
      Response response = await request(
          url: Constants.receiveFriend,
          method: Method.GET,
          params: bodyData
      );
      commonResponse = CommonResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: $e}');
    }
    return commonResponse;
  }

  Future<CommonResponse?> likePost(String postId) async {
    CommonResponse? commonResponse;
    Map<String, dynamic> bodyData = {
      'post_id': postId,
    };
    try {
      Response response = await request(
          url: Constants.likePostUrl,
          method: Method.GET,
          params: bodyData
      );
      commonResponse = CommonResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: $e}');
    }
    return commonResponse;
  }
}
// import 'package:dio/dio.dart';
// Future changePass({required Map<String, dynamic> bodyData}) async {
//   CommonResponse? commonResponse;
//   try {
//     Response response = await request(
//         url: Constants.changePassword,
//         method: Method.POST,
//         params: bodyData
//     );
//     commonResponse = CommonResponse.fromJson(response.data);
//   } catch (e) {
//     debugPrint('Request failed: $e}');
//   }
//   return commonResponse;
// }