class ListCommentResponse {
  String? errorCode;
  Data? data;

  ListCommentResponse({this.errorCode, this.data});

  ListCommentResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  List<Comment>? data;
  int? total;

  Data({this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Comment>[];
      json['data'].forEach((v) {
        data!.add(Comment.fromJson(v));
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

class Comment {
  int? id;
  int? userId;
  int? postId;
  String? content;
  int? status;
  int? likeAmount;
  int? likeStatus;
  String? createdTime;
  String? updatedTime;
  UserComment? userComment;

  Comment(
      {this.id,
        this.userId,
        this.postId,
        this.content,
        this.status,
        this.likeAmount,
        this.likeStatus,
        this.createdTime,
        this.updatedTime,
        this.userComment});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    content = json['content'];
    status = json['status'];
    likeAmount = json['amount_like'];
    likeStatus = json['status_like'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    userComment = json['user_comment'] != null
        ? UserComment.fromJson(json['user_comment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['post_id'] = postId;
    data['content'] = content;
    data['status'] = status;
    data['amount_like'] = likeAmount;
    data['status_like'] = likeStatus;
    data['created_time'] = createdTime;
    data['updated_time'] = updatedTime;
    if (userComment != null) {
      data['user_comment'] = userComment!.toJson();
    }
    return data;
  }
}

class UserComment {
  int? id;
  String? avatar;
  String? username;

  UserComment({this.id, this.avatar, this.username});

  UserComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['username'] = username;
    return data;
  }
}
