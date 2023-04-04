import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/create_post_response.dart';

class StoriesResponse {
  String? errorCode;
  List<StoriesData>? data;

  StoriesResponse({this.errorCode, this.data});

  StoriesResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    if (json['data'] != null) {
      data = <StoriesData>[];
      json['data'].forEach((v) {
        data!.add(StoriesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_code'] = errorCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoriesData {
  int? userId;
  String? username;
  String? avatar;
  List<StoryItems>? listStory;

  StoriesData({
    this.userId,
    this.listStory,
    this.username,
    this.avatar
  });

  StoriesData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    avatar = json['avatar'];
    if (json['list_story'] != null) {
      listStory = <StoryItems>[];
      json['list_story'].forEach((v) {
        listStory!.add(StoryItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['avatar'] = avatar;
    if (listStory != null) {
      data['list_story'] = listStory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoryItems {
  int? id;
  String? image;
  String? music;
  String? createdTime;
  int? amountView;
  List<UserInfo>? userView;

  StoryItems(
      {this.id,
        this.image,
        this.music,
        this.createdTime,
        this.amountView,
        this.userView});

  StoryItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    music = json['music'];
    createdTime = json['crated_time'];
    amountView = json['amount_view'];
    if (json['user_view'] != null) {
      userView = <UserInfo>[];
      json['user_view'].forEach((v) {
        userView!.add(UserInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['music'] = music;
    data['crated_time'] = createdTime;
    data['amount_view'] = amountView;
    if (userView != null) {
      data['user_view'] = userView!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

