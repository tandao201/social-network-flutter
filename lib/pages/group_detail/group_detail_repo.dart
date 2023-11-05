import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/models/responses/list_group_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/responses/list_user_response.dart';
import '../../models/responses/post_responses/create_post_response.dart';
import '../../models/responses/post_responses/newsfeed_response.dart';
import '../../utils/shared/constants.dart';

class GroupDetailRepo extends BaseRepo {
  Future<GroupEntity?> getGroupInfo({required Map<String, dynamic> params}) async {
    GroupEntity? groupEntity;
    try {
      Response response = await request(
        url: Constants.groupDetail,
        method: Method.GET,
        params: params
      );
      groupEntity = GroupEntity.fromJson(response.data["data"]);
    } catch (e) {
      print('Request failed: $e}');
    }
    return groupEntity;
  }

  Future<List<UserInfo>?> getGroupMember({required Map<String, dynamic> params}) async {
    ListUserResponse? listUserResponse;

    try {
      Response response = await request(
        url: Constants.groupMember,
        method: Method.GET,
        params: params
      );
      listUserResponse = ListUserResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return listUserResponse?.data?.data;
  }

  Future<List<Post>?> getNewsFeed({required Map<String, dynamic> bodyData}) async {
    NewsFeedResponse? newsFeedResponse;
    try {
      Response response = await request(
          url: Constants.groupNewsfeed,
          method: Method.GET,
          params: bodyData
      );
      newsFeedResponse = NewsFeedResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return newsFeedResponse?.data?.newsfeeds;
  }
}