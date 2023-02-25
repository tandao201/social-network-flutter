import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/home/search/search_ctl.dart';
import 'package:chat_app_flutter/utils/shared/assets.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/shared/constants.dart';

class SearchPage extends BaseView<SearchCtl> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: AppBar().preferredSize.height-6,
              color: AppColor.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 3),
                      width: controller.isSearchUser.value ? Constants.widthScreen : Constants.widthScreen - 40.w,
                      child: textFormFieldLogin(
                        borderRadius: 10,
                        leadingIcon: const Icon(Icons.search_rounded),
                        hintText: "Tìm kiếm...",
                        controller: controller.searchCtl,
                        focusNode: controller.searchFocus,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.isSearchUser.value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: GestureDetector(
                        onTap: () {
                          controller.isSearchUser.value = false;
                        },
                        child: const Text('Hủy', style: ThemeTextStyle.body15,),
                      ),
                    ),
                  )
                ],
              ),
            ),
            divider(),
            Expanded(
              child: controller.isLoading.value
                  ? Container()
                  : AnimatedCrossFade(
                      firstChild: suggestPost(),
                      secondChild: searchUser(),
                      crossFadeState: !controller.isSearchUser.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 700)
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget searchUser() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.red,
          )
        ],
      ),
    );
  }

  Widget suggestPost() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.blue,
          )
        ],
      ),
    );
  }

}