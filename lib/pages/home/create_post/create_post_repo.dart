import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:chat_app_flutter/models/responses/post_responses/create_post_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../utils/shared/constants.dart';

class CreatePostRepo extends BaseRepo {
  Future createPost({required Map<String, dynamic> bodyData}) async {
    CreatePostResponse? createPostResponse;
    try {
      Response response = await request(
          url: Constants.createPost,
          method: Method.POST,
          params: bodyData
      );
      createPostResponse = CreatePostResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return createPostResponse;
  }
}