import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../models/commons/common_list_response.dart';
import '../../../models/responses/auth_responses/login_response.dart';
import '../../../models/responses/post_responses/create_post_response.dart';
import '../../../utils/shared/constants.dart';
import '../../../utils/shared/enums.dart';

class SearchRepo extends BaseRepo {
  Future searchByKey({required Map<String, dynamic> bodyData}) async {
    int type = bodyData['type'];
    CommonListResponse? commonListResponse;
    if (type == SearchType.user.index) {
      commonListResponse = CommonListResponse<UserInfo>();
    } else {
      commonListResponse = CommonListResponse<Post>();
    }
    try {
      Response response = await request(
          url: Constants.search,
          method: Method.GET,
          params: bodyData
      );
      commonListResponse = CommonListResponse.fromJson(response.data, type);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return commonListResponse;
  }
}