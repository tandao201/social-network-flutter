import 'dart:convert';
import 'dart:io';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:chat_app_flutter/utils/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../helper/helper_function.dart';
import '../models/responses/auth_responses/login_response.dart';
import '../utils/shared/colors.dart';

class AppApi {
  static Dio? _dio;
  static Dio? get dio {
    if (_dio == null) {
      _dio = Dio();
      dio?.interceptors.addAll([
        AppInterceptor()
      ]);
      (dio?.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
            client.badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
            return client;
          };
    }
    return _dio;
  }
}

class AppInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
    String data = HelperFunctions.getString(HelperFunctions.loginKey);
    if (data.isNotEmpty) {
      LoginData loginData = LoginData.fromJson(jsonDecode(data));
      options.headers['Authorization'] = "Bearer ${loginData.token}";
    }
    options.baseUrl = Constants.baseUrl;
    options.headers['Content-Type'] = "application/json";
    options.headers['Accept'] = "application/json";
    debugPrint("🚀️ApiInterceptor-options--START🚀️");
    debugPrint("${options.method}: ${options.baseUrl}${options.path}");
    debugPrint("Headers: ${options.headers}");
    debugPrint("Query parameters: ${options.queryParameters}");
    debugPrint("Body: ${options.data}");
    debugPrint("🛩️ApiInterceptor-options--END🛩️");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
    debugPrint("☘️ApiInterceptor-response--START☘️");
    debugPrint("${response.requestOptions.method}: ${response.requestOptions.baseUrl}${response.requestOptions.path}");
    debugPrint("Status code: ${response.statusCode}");
    debugPrint("Status message: ${response.statusMessage}");
    // debugPrint("Headers: ${response.headers}");
    debugPrint('Data response: ${jsonEncode(response.data)}');
    debugPrint("☘️ApiInterceptor-response--END☘️");
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
    debugPrint("🔥ApiInterceptor-err--START🔥");
    debugPrint("${err.requestOptions.method}: ${err.requestOptions.baseUrl}${err.requestOptions.path}");
    debugPrint("Error response: ${err.response}");
    debugPrint("Error message: ${err.message}");
    debugPrint("🔥ApiInterceptor-err--END🔥");
  }
}