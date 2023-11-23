import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_names.dart';
import 'items/group_item.dart';
import 'list_group_ctl.dart';

class ListGroupPage extends BaseView<ListGroupCtl> {
  const ListGroupPage({super.key});

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          centerTitle: false,
          title: "Nhóm",
          isShowLeading: false,
          actions: [
            GestureDetector(
              onTap: () {
                controller.toPage(routeUrl: RouteNames.createGroup);
              },
              child: const Icon(
                Icons.add,
                size: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16,)
          ]
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.initData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMyGroups(),
                const SizedBox(height: 32,),
                _buildGroups(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyGroups() {
    if (controller.isLoading.value) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Nhóm của tôi", style: ThemeTextStyle.heading16,),
        ),
        const SizedBox(height: 8,),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.myGroups.length,
          itemBuilder: (context, index) {
            var item = controller.myGroups[index];
            return GroupItem(
              groupEntity: item,
              onPressed: () => controller.onPressed(groupId: item.id ?? -1),
            );
          },
        )

      ],
    );
  }

  Widget _buildGroups() {
    if (controller.isLoading.value) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16,),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Nhóm gợi ý", style: ThemeTextStyle.heading16,),
        ),
        const SizedBox(height: 8,),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.groups.length,
          itemBuilder: (context, index) {
            var item = controller.groups[index];
            return GroupItem(
              groupEntity: item,
              onPressed: () => controller.onPressed(groupId: item.id ?? -1),
              onPressedJoin: () {
                controller.joinGroup(item.id ?? -1, index);
              },
            );
          },
        )
      ],
    );
  }

}