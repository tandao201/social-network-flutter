import 'package:chat_app_flutter/base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/shared/assets.dart';
import '../../utils/shared/colors.dart';
import 'home_ctl.dart';

class HomePage extends BaseView<HomeCtl> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    // TODO: implement viewBuilder
    return Scaffold(
      body: SafeArea(
        child: controller.isLoading.value
          ? Container()
          : PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: controller.listHome,
            ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: controller.pageIndex.value != 0
                ? const Icon(Icons.home_outlined, color: AppColor.black)
                : const Icon(Icons.home_sharp, color: AppColor.black,),
            backgroundColor: AppColor.white,
            label: "",
          ),
          BottomNavigationBarItem(
            icon: controller.pageIndex.value != 1
              ? const Icon(Icons.search_outlined, color: AppColor.black)
              : const Icon(Icons.search_rounded, color: AppColor.black),
            backgroundColor: AppColor.white,
            label: "",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.createPost),
            backgroundColor: AppColor.white,
            label: "",
          ),
          BottomNavigationBarItem(
            icon: controller.pageIndex.value != 3
              ? const Icon(Icons.health_and_safety_outlined, color: AppColor.black)
              : const Icon(Icons.health_and_safety, color: AppColor.black),
            backgroundColor: AppColor.white,
            label: "",
          ),
          BottomNavigationBarItem(
            icon: controller.pageIndex.value != 4
              ? const Icon(Icons.account_circle_outlined, color: AppColor.black)
              : const Icon(Icons.account_circle, color: AppColor.black),
            backgroundColor: AppColor.white,
            label: "",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.pageIndex.value,
        selectedItemColor: AppColor.blueTag,
        unselectedItemColor: AppColor.black,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        elevation: 3,
        iconSize: 28,
        onTap: (index) {
          controller.clickBottomNavItem(index);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}