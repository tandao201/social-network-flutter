class NewsFeedResponse {
  String? errorCode;
  NewsFeedResponseData? data;

  NewsFeedResponse({this.errorCode, this.data});

  NewsFeedResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    data = json['data'] != null ? NewsFeedResponseData.fromJson(json['data']) : null;
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

class NewsFeedResponseData {
  List<Newsfeed>? newsfeeds;
  int? total;

  NewsFeedResponseData({this.newsfeeds, this.total});

  NewsFeedResponseData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      newsfeeds = <Newsfeed>[];
      json['data'].forEach((v) {
        newsfeeds!.add(Newsfeed.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (newsfeeds != null) {
      data['data'] = newsfeeds!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class Newsfeed {
  int? id;
  int? userId;
  String? content;
  String? createdTime;
  String? image;

  Newsfeed({this.id, this.userId, this.content, this.createdTime});

  Newsfeed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    createdTime = json['created_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['content'] = content;
    data['created_time'] = createdTime;
    return data;
  }
}
