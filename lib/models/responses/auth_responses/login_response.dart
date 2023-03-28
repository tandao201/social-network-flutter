import '../post_responses/create_post_response.dart';

class LoginResponse {
  String? errorCode;
  LoginData? data;

  LoginResponse({this.errorCode, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
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

class LoginData {
  String? token;
  UserInfo? userInfo;
  int? expiredToken;

  LoginData({this.token, this.userInfo, this.expiredToken});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userInfo = json['user_info'] != null
        ? UserInfo.fromJson(json['user_info'])
        : null;
    expiredToken = json['expiredToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    data['expiredToken'] = expiredToken;
    return data;
  }
}

class UserInfo {
  int? id;
  String? email;
  String? username;
  String? mobile;
  String? avatar;
  String? bio;
  int? status;
  String? createdTime;
  String? updatedTime;
  List<Post>? posts;
  int? friend;
  int? listFollow;
  int? listFollowing;

  UserInfo(
      {this.id,
        this.email,
        this.username,
        this.mobile,
        this.avatar,
        this.status,
        this.createdTime,
        this.updatedTime,
        this.posts,
        this.friend,
        this.listFollow,
        this.listFollowing,
        this.bio
      });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    mobile = json['mobile'];
    avatar = json['avatar'];
    status = json['status'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    if (json['posts'] != null) {
      posts = <Post>[];
      json['posts'].forEach((v) {
        posts!.add(Post.fromJson(v));
      });
    }
    friend = json['friend'];
    listFollow = json['listFollow'];
    listFollowing = json['listFollowing'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    data['mobile'] = mobile;
    data['avatar'] = avatar;
    data['status'] = status;
    data['created_time'] = createdTime;
    data['updated_time'] = updatedTime;
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    data['friend'] = friend;
    data['listFollow'] = listFollow;
    data['listFollowing'] = listFollowing;
    data['bio'] = bio;
    return data;
  }
}