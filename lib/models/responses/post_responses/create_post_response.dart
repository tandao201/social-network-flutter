class CreatePostResponse {
  String? errorCode;
  CreatePostData? data;

  CreatePostResponse({this.errorCode, this.data});

  CreatePostResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    data = json['data'] != null ? CreatePostData.fromJson(json['data']) : null;
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

class CreatePostData {
  int? id;
  int? userId;
  String? content;
  String? image;
  String? createdTime;
  String? updatedTime;

  CreatePostData(
      {this.id,
        this.userId,
        this.content,
        this.image,
        this.createdTime,
        this.updatedTime});

  CreatePostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    image = json['image'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['content'] = content;
    data['image'] = image;
    data['created_time'] = createdTime;
    data['updated_time'] = updatedTime;
    return data;
  }
}
