import 'dart:convert';
import 'dart:io';
import 'package:chat_app_flutter/api_service/api_urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppApi {
  static Dio? _dio;
  static Dio? get dio {
    if (_dio == null) {
      _dio = Dio();
      dio?.interceptors.addAll([
        AppInterceptor()
      ]);
      // (_dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      //     (HttpClient dioClient) {
      //   dioClient.badCertificateCallback =
      //   ((X509Certificate cert, String host, int port) => true);
      //   return dioClient;
      // };
    }
    return _dio;
  }
}

class AppInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
    options.baseUrl = ApiUrls.baseUrl;
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
    debugPrint("${response.headers}");
    debugPrint(jsonEncode(response.data));
    debugPrint("Status message: ${response.statusMessage}");
    debugPrint("☘️ApiInterceptor-response--END☘️");
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
    debugPrint("🔥ApiInterceptor-err--START🔥");
    debugPrint("${err.requestOptions.method}: ${err.requestOptions.baseUrl}${err.requestOptions.path}");
    debugPrint("${err.response}");
    debugPrint("${err.message}");
    debugPrint("🔥ApiInterceptor-err--END🔥");
  }
}