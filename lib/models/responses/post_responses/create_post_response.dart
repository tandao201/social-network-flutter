import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';

class CreatePostResponse {
  String? errorCode;
  Post? data;

  CreatePostResponse({this.errorCode, this.data});

  CreatePostResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    data = json['data'] != null ? Post.fromJson(json['data']) : null;
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

class Post {
  int? id;
  int? userId;
  UserInfo? user;
  String? content;
  String? image;
  String? music;
  String? createdTime;
  String? updatedTime;
  int? amountLike;
  int? amountComment;
  int? likeStatus;

  Post(
      {this.id,
        this.userId,
        this.user,
        this.content,
        this.image,
        this.music,
        this.createdTime,
        this.updatedTime,
        this.amountLike,
        this.amountComment,
        this.likeStatus,
      });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    if (json['user'] != null) {
      user = UserInfo.fromJson(json['user']);
    }
    content = json['content'];
    image = json['image'];
    image = json['music'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    amountLike = json['amount_like'];
    amountComment = json['amount_comment'];
    likeStatus = json['status_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['content'] = content;
    data['image'] = image;
    data['music'] = music;
    data['created_time'] = createdTime;
    data['updated_time'] = updatedTime;
    data['amount_like'] = amountLike;
    data['amount_comment'] = amountComment;
    data['status_like'] = likeStatus;
    return data;
  }
}
