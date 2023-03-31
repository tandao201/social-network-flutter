import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/utils/shared/enums.dart';

import '../responses/post_responses/create_post_response.dart';

class CommonListResponse<T> {
  String? errorCode;
  List<T>? data;

  CommonListResponse({this.errorCode, this.data});

  CommonListResponse.fromJson(Map<String, dynamic> json, int type) {
    errorCode = json['error_code'];
    if (json['data'] != null) {
      data = <T>[];
      json['data'].forEach((v) {
        if (type == SearchType.user.index) {
          data!.add(UserInfo.fromJson(v) as T);
        } else {
          data!.add(Post.fromJson(v) as T);
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_code'] = errorCode;
    data['data'] = this.data;
    return data;
  }
}