import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/home/search/search_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchCtl extends BaseCtl<SearchRepo> {
  TextEditingController searchCtl = TextEditingController();
  FocusNode searchFocus = FocusNode();
  RxBool isSearchUser = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    searchFocus.addListener(onFocusChange);
  }

  void onFocusChange() {
    isSearchUser.value = true;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchFocus.removeListener(onFocusChange);
    searchCtl.dispose();
  }
}