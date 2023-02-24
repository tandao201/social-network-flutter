import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class LoginRepo extends BaseRepo {
  Future login({required Map<String, dynamic> bodyData}) async {
    LoginResponse? loginResponse;
    try {
      Response response = await request(
          url: Constants.login,
          method: Method.POST,
          params: bodyData
      );
      loginResponse = LoginResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return loginResponse;
  }
}