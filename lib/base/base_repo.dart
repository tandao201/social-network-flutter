import 'dart:io';
import 'package:chat_app_flutter/models/commons/upload_image_response.dart';

import '../api_service/api_dio_intercepter.dart';
import 'package:dio/dio.dart';

import '../utils/shared/constants.dart';

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
}