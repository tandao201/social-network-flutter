import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:chat_app_flutter/models/responses/list_group_response.dart';
import 'package:dio/dio.dart';

import '../../../utils/shared/constants.dart';

class ListGroupRepo extends BaseRepo {
  Future<List<GroupEntity>?> getMyGroups() async {
    ListGroupResponse? listGroupResponse;
    try {
      Response response = await request(
          url: Constants.myListGroup,
          method: Method.GET,
      );
      listGroupResponse = ListGroupResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: $e}');
    }
    return listGroupResponse?.data?.data;
  }

  Future<List<GroupEntity>?> getGroups() async {
    ListGroupResponse? listGroupResponse;
    try {
      Response response = await request(
        url: Constants.listGroup,
        method: Method.GET,
      );
      listGroupResponse = ListGroupResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: $e}');
    }
    return listGroupResponse?.data?.data;
  }
}