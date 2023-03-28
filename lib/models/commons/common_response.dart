import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';

class CommonResponse<T> {
  String? errorCode;
  T? data;

  CommonResponse({this.errorCode, this.data});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    switch (T) {
      case UserInfo:
        data = UserInfo.fromJson(json['data']) as T?;
        break;
      default:
        data = json['data'] ?? "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_code'] = errorCode;
    data['data'] = this.data;
    return data;
  }
}
