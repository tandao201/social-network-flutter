import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/models/responses/list_group_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/responses/list_user_response.dart';
import '../../models/responses/post_responses/create_post_response.dart';
import '../../models/responses/post_responses/newsfeed_response.dart';
import '../../utils/shared/constants.dart';

class CreateGroupRepo extends BaseRepo {
  Future<GroupEntity?> createGroup({required Map<String, dynamic> params}) async {
    GroupEntity? groupEntity;
    try {
      Response response = await request(
        url: Constants.createGroup,
        method: Method.POST,
        params: params
      );
      groupEntity = GroupEntity.fromJson(response.data["data"]);
    } catch (e) {
      print('Request failed: $e}');
    }
    return groupEntity;
  }

}