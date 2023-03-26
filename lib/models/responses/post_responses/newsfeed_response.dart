import 'create_post_response.dart';

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
  List<Post>? newsfeeds;
  int? total;

  NewsFeedResponseData({this.newsfeeds, this.total});

  NewsFeedResponseData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      newsfeeds = <Post>[];
      json['data'].forEach((v) {
        newsfeeds!.add(Post.fromJson(v));
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

