import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/chat/search_chat/search_chat_ctl.dart';
import 'package:chat_app_flutter/utils/widgets/group_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/shared/colors.dart';
import '../../../utils/widgets/loading.dart';

class SearchChatPage extends BaseView<SearchChatCtl> {
  const SearchChatPage({Key? key}) : super(key: key);

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
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () => Get.back(),
                  ),
                  Expanded(
                    child: textFormFieldLogin(
                      borderRadius: 10,
                      leadingIcon: const Icon(Icons.search_rounded),
                      hintText: "Tìm kiếm...",
                      controller: controller.searchCtl,
                      onFieldSubmitted: (value) {
                        controller.searchByKey();
                      }
                    ),
                  ),
                ],
              ),
            ),
            divider(),
            Expanded(
              child: controller.isLoading.value
                  ? const Loading()
                  : searchContent(),
            )
          ],
        ),
      ),
    );
  }

  Widget searchContent() {
    return ListView.builder(
      itemCount: controller.listUser.length,
      itemBuilder: (context, index) {
        var userInfo = controller.users[index];
        return GroupTile(
            groupId: "new",
            groupName: userInfo.name ?? "Người dùng",
            userName: "",
            avatarImg: userInfo.imageUrl ?? ""
        );
      },
    );
  }

}