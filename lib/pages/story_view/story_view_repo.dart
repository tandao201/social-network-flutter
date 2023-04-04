import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../models/commons/common_response.dart';
import '../../utils/shared/constants.dart';

class StoryViewRepo extends BaseRepo {
  Future seenStory({required Map<String, dynamic> bodyData}) async {
    CommonResponse? commonResponse;
    try {
      Response response = await request(
          url: Constants.seenStory,
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