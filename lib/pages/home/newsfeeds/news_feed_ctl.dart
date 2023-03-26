import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/newsfeed_response.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/commons/user.dart';
import '../../../models/responses/post_responses/create_post_response.dart';
import '../../../utils/shared/colors.dart';
import '../../../utils/shared/constants.dart';

class NewsFeedCtl extends BaseCtl<NewsFeedRepo> {
  PageController pageController = PageController();
  ScrollController scrollCtl = ScrollController();
  int currentPage = 1;
  int totalItem = 2;
  late UserInfo currentUser;
  RxList<UserFirebase> listStory = [
    UserFirebase(
        name: 'Tan',
        imageUrl: "",
        stories: [1,2.3]
    ),
    UserFirebase(
        name: 'Khanh',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSays4neq3I-N262WtjmR7PwKEvtbX0yp4eClmWCDLI&s',
        stories: [1,2,3]
    ),
    UserFirebase(
        name: 'Manh',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSays4neq3I-N262WtjmR7PwKEvtbX0yp4eClmWCDLI&s',
        stories: [1]
    ),
    UserFirebase(
        name: 'Trinh',
        imageUrl: 'https://indochinapost.com/wp-content/uploads/chuyen-phat-nhanh-tnt-di-anh.jpg',
        stories: []
    ),
    UserFirebase(
        name: 'Khanh',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSays4neq3I-N262WtjmR7PwKEvtbX0yp4eClmWCDLI&s',
        stories: [1,2.3]
    ),
    UserFirebase(
        name: 'Khanh',
        imageUrl: 'https://cdn.pixabay.com/photo/2020/04/30/14/03/mountains-and-hills-5112952__480.jpg',
        stories: [1,2,3]
    ),
    UserFirebase(
        name: 'Manh',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSays4neq3I-N262WtjmR7PwKEvtbX0yp4eClmWCDLI&s',
        stories: [1]
    ),
  ].obs;

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
    listStory[0].imageUrl = currentUser.avatar ?? "";
    listStory[0].name = currentUser.username ?? "";
  }

  Future initData() async {
    currentPage = 1;
    totalItem = 2;
    getNewsfeed();
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

  Future commentInFeed(BuildContext context) async {
    FocusScope.of(context).requestFocus(commentFocus);
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