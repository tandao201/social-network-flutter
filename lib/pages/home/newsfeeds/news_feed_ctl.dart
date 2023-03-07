import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../models/commons/user.dart';

class NewsFeedCtl extends BaseCtl<NewsFeedRepo> {
  PageController pageController = PageController();
  RxList<User> listStory = [
    User(
        name: 'Tan',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSays4neq3I-N262WtjmR7PwKEvtbX0yp4eClmWCDLI&s',
        stories: [1,2.3]
    ),
    User(
        name: 'Khanh',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSays4neq3I-N262WtjmR7PwKEvtbX0yp4eClmWCDLI&s',
        stories: [1,2,3]
    ),
    User(
        name: 'Manh',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSays4neq3I-N262WtjmR7PwKEvtbX0yp4eClmWCDLI&s',
        stories: [1]
    ),
    User(
        name: 'Trinh',
        imageUrl: 'https://indochinapost.com/wp-content/uploads/chuyen-phat-nhanh-tnt-di-anh.jpg',
        stories: []
    ),
    User(
        name: 'Khanh',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSays4neq3I-N262WtjmR7PwKEvtbX0yp4eClmWCDLI&s',
        stories: [1,2.3]
    ),
    User(
        name: 'Khanh',
        imageUrl: 'https://cdn.pixabay.com/photo/2020/04/30/14/03/mountains-and-hills-5112952__480.jpg',
        stories: [1,2,3]
    ),
    User(
        name: 'Manh',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSays4neq3I-N262WtjmR7PwKEvtbX0yp4eClmWCDLI&s',
        stories: [1]
    ),
  ].obs;

  RxList<String> newsFeeds = <String>[
    'https://i.ibb.co/jz9g5Gf/P-20230223-161322.jpg',
    'https://i.ibb.co/FqmyYfz/316273937-6379883785360930-7684004965072663389-n.jpg',
    'https://i.ibb.co/DbMDGFv/5923902.jpg'
  ].obs;

  Rx<bool> isCommentInFeed = false.obs;
  TextEditingController commentCtl = TextEditingController();
  FocusNode commentFocus = FocusNode();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


  }

  Future initData() async {
    print('Refresh.........');
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
}