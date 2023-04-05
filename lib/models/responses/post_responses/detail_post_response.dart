import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';

import 'create_post_response.dart';

class DetailPostResponse {
  String? errorCode;
  List<Post>? data;

  DetailPostResponse({this.errorCode, this.data});

  DetailPostResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    if (json['data'] != null) {
      data = <Post>[];
      for ( var item in json['data']) {
        data?.add(Post.fromJson(item));
      }
    }
  }
}
