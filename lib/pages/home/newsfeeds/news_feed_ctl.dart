import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/newsfeed_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/stories_response.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/commons/user.dart';
import '../../../models/responses/post_responses/create_post_response.dart';
import '../../../utils/shared/colors.dart';
import '../../../utils/shared/constants.dart';
import '../health_prediction/health_prediction_ctl.dart';

class NewsFeedCtl extends BaseCtl<NewsFeedRepo> {
  PageController pageController = PageController();
  ScrollController scrollCtl = ScrollController();

  RxBool isLoadingStory = false.obs;
  int currentPage = 1;
  int totalItem = 2;
  late UserInfo currentUser;
  RxList<StoriesData> listStory = <StoriesData>[].obs;
  RxList<Post> newsFeeds = <Post>[].obs;
  Rx<bool> isCommentInFeed = false.obs;
  TextEditingController commentCtl = TextEditingController();
  FocusNode commentFocus = FocusNode();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
    scrollCtl.addListener(_scrollListener);
    currentUser = globalController!.userInfo.value;
    insertFirstStory();
  }

  void insertFirstStory() {
    listStory.value = [];
    listStory.add(StoriesData(
      userId: currentUser.id,
      username: currentUser.username,
      avatar: currentUser.avatar
    ));
  }

  Future initData() async {
    HealthPredictionCtl().symptomSearch();
    currentPage = 1;
    totalItem = 2;
    await Future.wait([
      getNewsfeed(),
      getStories()
    ]);
  }

  Future getNewsfeed() async {
    if (!isLoadMore.value) {
      isLoading.value = true;
    }
    Map<String, dynamic> bodyData = {
      'order_by': 'created_time',
    };
    if (currentPage > 1) {
      bodyData['offset'] = currentPage;
    }
    try {
      NewsFeedResponse? newsFeedResponse = await api.getNewsFeed(bodyData: bodyData);
      if (newsFeedResponse == null) {
        debugPrint('Response null');
        return ;
      }
      if (newsFeedResponse.errorCode!.isEmpty) {
        if (!isLoadMore.value) newsFeeds.value = [];
        newsFeeds.addAll(newsFeedResponse.data!.newsfeeds as List<Post>);
        newsFeeds.refresh();
        totalItem = newsFeedResponse.data!.total!;
        isLoading.value = false;
        isLoadMore.value = false;
        print('Total item: ${totalItem} and length: ${newsFeeds.length}');
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(newsFeedResponse.errorCode!)
        );
      }
    } catch (e) {
      isLoading.value = false;
      isLoadMore.value = false;
    }
  }

  Future getStories() async {
    isLoadingStory.value = true;
    try {
      StoriesResponse? storiesResponse = await api.getStories();
      if (storiesResponse == null) {
        debugPrint('Response null');
        return ;
      }
      if (storiesResponse.errorCode!.isEmpty) {
        insertFirstStory();
        listStory.addAll(storiesResponse.data ?? []);
        listStory.refresh();
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(storiesResponse.errorCode!)
        );
      }
    } catch (e) {
      print("Ex call stories: ${e.toString()}");
    } finally {
      isLoadingStory.value = false;
    }
  }

  void animateToIndex(int index) {
    pageController.animateToPage(
      index,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 500)
    );
  }

  void _scrollListener() async {
    if (scrollCtl.position.pixels >= scrollCtl.position.maxScrollExtent-50 ) {
      if (newsFeeds.length < totalItem && !isLoadMore.value && !isLoading.value ) {
        isLoadMore.value = true;
        print('Load more--------------------------');
        currentPage++;
        await getNewsfeed();
        Future.delayed(const Duration(seconds: 4));
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
    scrollCtl.removeListener(_scrollListener);
  }
}