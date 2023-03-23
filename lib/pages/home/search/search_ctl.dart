import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/pages/home/search/search_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/responses/post_responses/create_post_response.dart';

class SearchCtl extends BaseCtl<SearchRepo> with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  TextEditingController searchCtl = TextEditingController();
  FocusNode searchFocus = FocusNode();

  RxBool isSearchUser = false.obs;
  Rx<int> currentTab = 0.obs;
  RxList<Post> postsSearch = <Post>[].obs;
  RxList<UserInfo> usersSearch = <UserInfo>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 500)
    );
  }

  Future initData() async {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
    });
  }

  Future animateToPage(int index) async {
    hideKeyboard();
    currentTab.value = index;
    print('Change index: $index');
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchCtl.dispose();
  }
}