import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';

class ListUserResponse {
  String? errorCode;
  ListData? data;

  ListUserResponse({this.errorCode, this.data});

  ListUserResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    data = json['data'] != null ? ListData.fromJson(json['data']) : null;
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

class ListData {
  List<UserInfo>? data;
  int? total;

  ListData({this.data, this.total});

  ListData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserInfo>[];
      json['data'].forEach((v) {
        data!.add(UserInfo.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}