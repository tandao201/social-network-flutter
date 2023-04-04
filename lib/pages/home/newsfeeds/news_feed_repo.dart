import 'package:chat_app_flutter/models/responses/post_responses/newsfeed_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import '../../../base/base_repo.dart';
import '../../../models/responses/post_responses/stories_response.dart';
import '../../../utils/shared/constants.dart';

class NewsFeedRepo extends BaseRepo {
  Future getNewsFeed({required Map<String, dynamic> bodyData}) async {
    NewsFeedResponse? newsFeedResponse;
    try {
      Response response = await request(
          url: Constants.newsfeed,
          method: Method.GET,
          params: bodyData
      );
      newsFeedResponse = NewsFeedResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return newsFeedResponse;
  }

  Future getStories() async {
    StoriesResponse? storiesResponse;
    try {
      Response response = await request(
          url: Constants.listStories,
          method: Method.GET,
      );
      storiesResponse = StoriesResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return storiesResponse;
  }
}