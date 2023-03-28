import 'package:chat_app_flutter/models/responses/post_responses/list_comment_response.dart';

class CreateCommentResponse {
  String? errorCode;
  Comment? data;

  CreateCommentResponse({this.errorCode, this.data});

  CreateCommentResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    if (json['data'] != null) {
      data = Comment.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_code'] = errorCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}