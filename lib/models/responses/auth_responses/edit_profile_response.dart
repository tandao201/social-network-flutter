import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';

class EditProfileResponse {
  String? errorCode;
  UserInfo? data;

  EditProfileResponse({this.errorCode, this.data});

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    data = json['data'] != null ? UserInfo.fromJson(json['data']) : null;
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
