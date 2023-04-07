import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../models/responses/list_user_response.dart';

class ListUserRepo extends BaseRepo {

  Future getList({required String url}) async {
    ListUserResponse? listUserResponse;

    try {
      Response response = await request(
          url: url,
          method: Method.GET,
      );
      listUserResponse = ListUserResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return listUserResponse;
  }
}