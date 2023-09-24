import 'package:chat_app_flutter/models/commons/common_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/create_comment_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/list_comment_response.dart';
import 'package:flutter/cupertino.dart';

import '../../base/base_repo.dart';
import 'package:dio/dio.dart';

import '../../utils/shared/constants.dart';

class CommentPostRepo extends BaseRepo {
  Future listComment({required Map<String, dynamic> bodyData}) async {
    ListCommentResponse? listCommentResponse;
    try {
      Response response = await request(
          url: Constants.listComment,
          method: Method.GET,
          params: bodyData
      );
      listCommentResponse = ListCommentResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return listCommentResponse;
  }

  Future createComment({required Map<String, dynamic> bodyData}) async {
    CreateCommentResponse? createCommentResponse;
    try {
      Response response = await request(
          url: Constants.createComment,
          method: Method.POST,
          params: bodyData
      );
      createCommentResponse = CreateCommentResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return createCommentResponse;
  }

  Future deleteComment({required Map<String, dynamic> bodyData}) async {
    CommonResponse? commonResponse;
    try {
      Response response = await request(
          url: Constants.deleteComment,
          method: Method.GET,
          params: bodyData
      );
      commonResponse = CommonResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return commonResponse;
  }

  Future<CommonResponse?> likeComment(int commentId) async {
    CommonResponse? commonResponse;
    Map<String, dynamic> bodyData = {
      'comment_id': commentId,
    };
    try {
      Response response = await request(
          url: Constants.likeComment,
          method: Method.GET,
          params: bodyData
      );
      commonResponse = CommonResponse.fromJson(response.data);
    } catch (e) {
      print('Request failed: $e}');
    }
    return commonResponse;
  }
}