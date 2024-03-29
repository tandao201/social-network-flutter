import 'dart:convert';
import 'dart:io';
import 'package:chat_app_flutter/models/commons/upload_image_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/create_post_response.dart';
import 'package:flutter/cupertino.dart';

import '../api_service/api_dio_intercepter.dart';
import 'package:dio/dio.dart';

import '../models/commons/common_response.dart';
import '../models/responses/post_responses/detail_post_response.dart';
import '../utils/shared/constants.dart';
import '../utils/shared/enums.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class BaseRepo {
  var dio = AppApi.dio;
  Future<dynamic> request({
    required String url,
    required Method method,
    var params,
    Map<String, dynamic>? headers,
  }) async {
    Response? response;
    if (headers != null) {
      dio?.options.headers = headers;
    }

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
    } on DioException catch (e){
      return e.response;
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }

  Future<dynamic> requestSpecificUrl({
    required String url,
    required Method method,
    var params,
    Map<String, dynamic>? headers,
  }) async {
    Response? response;
    Dio dioSpecific = Dio(
      BaseOptions(
        headers: headers,
        connectTimeout: const Duration(seconds: 60), // 60 seconds
        receiveTimeout: const Duration(seconds: 60)
      )
    )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("│ 🚀️ApiInterceptor-options--START🚀️");
          debugPrint("│ ${method.name}: $url");
          debugPrint("│ Headers: $headers");
          debugPrint("│ Params: $params");
          debugPrint("│ 🚀️ApiInterceptor-options--END🚀️");
          handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint("│ ☘️ApiInterceptor-response--START☘️");
          debugPrint("│ ${method.name}: $url");
          debugPrint("│ Status code: ${response.statusCode}");
          debugPrint("│ Status message: ${response.statusMessage}");
          debugPrint('│ Data response: ${jsonEncode(response.data)}');
          debugPrint("│ ☘️ApiInterceptor-response--END☘️");
          handler.next(response);
        },
        onError: (error, handler) {
          debugPrint("│ ☘ERROR--START");
          debugPrint("│ ${method.name}: $url");
          debugPrint("│ Status message: ${error.message}");
          debugPrint("│ ☘ERROR-START--END");
          handler.next(error);
        }
      )
    );

    try {
      if (method == Method.POST) {
        response = await dioSpecific.post(url, data: params);
      } else if (method == Method.PUT) {
        response = await dioSpecific.put(url, data: params);
      } else if (method == Method.DELETE) {
        response = await dioSpecific.delete(url);
      } else if (method == Method.PATCH) {
        response = await dioSpecific.patch(url);
      } else {
        response = await dioSpecific.get(
          url,
          queryParameters: params,
        );
      }
      return response;
    } on SocketException catch(e) {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format!");
    } on DioException catch (e){
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

  Future<CommonResponse?> requestFriend(String userId, {int? status}) async {
    CommonResponse? commonResponse;
    Map<String, dynamic> bodyData = {
      'user_id': userId,
      'status': status ?? FriendStatus.request.index
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

  Future<CommonResponse?> cancelFriend(String userId) async {
    Map<String, dynamic> bodyData = {
      'user_id': userId,
      'status': FriendStatus.delete.index
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

  Future<DetailPostResponse?> getDetailPost(int postId) async {
    DetailPostResponse? detailPostResponse;
    Map<String, dynamic> bodyData = {
      'post_id': postId,
    };
    try {
      Response response = await request(
          url: Constants.detailPost,
          method: Method.GET,
          params: bodyData
      );
      detailPostResponse = DetailPostResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: $e}');
    }
    return detailPostResponse;
  }

  Future<CommonResponse?> joinGroup(int groupId) async {
    CommonResponse? commonResponse;
    Map<String, dynamic> bodyData = {
      'group_id': groupId,
    };
    try {
      Response response = await request(
          url: Constants.joinGroup,
          method: Method.POST,
          params: bodyData
      );
      commonResponse = CommonResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: $e}');
    }
    return commonResponse;
  }

  Future<CommonResponse?> outGroup(int groupId) async {
    CommonResponse? commonResponse;
    Map<String, dynamic> bodyData = {
      'group_id': groupId,
    };
    try {
      Response response = await request(
          url: Constants.outGroup,
          method: Method.POST,
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