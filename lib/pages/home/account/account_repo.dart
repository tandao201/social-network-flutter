import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/commons/common_response.dart';
import '../../../utils/shared/constants.dart';

class AccountRepo extends BaseRepo {
  Future getUserDetail({required Map<String, dynamic> bodyData}) async {
  CommonResponse<UserInfo>? commonResponse;
  try {
    Response response = await request(
        url: Constants.userDetail,
        method: Method.GET,
        params: bodyData
    );
    commonResponse = CommonResponse.fromJson(response.data);
  } catch (e) {
    debugPrint('Request failed: $e}');
  }
  return commonResponse;
}
}