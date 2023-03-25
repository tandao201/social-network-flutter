import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/models/commons/spotify_music_response.dart';
import 'package:chat_app_flutter/pages/home/create_post/create_post_ctl.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/widgets/loading.dart';
import '../../../utils/widgets/widget_utils.dart';

class CreatePostPage extends BaseView<CreatePostCtl> {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: controller.isLoading.value || controller.selectedImage.value.path.isEmpty
          ? const Center(
              child: Loading(),
            )
          : Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    onPressed: () => Get.back(),
                  ),
                  Text(controller.type.value == "post" ? 'Bài viết' : 'Story', style: const BaseTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),),
                  InkWell(
                    child: const Text('Tiếp tục', style: BaseTextStyle(
                      color: AppColor.blueTag,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                    ),),
                    onTap: () {
                      if (controller.type.value == "post") {
                        Get.to(() => createDone(), transition: Transition.rightToLeftWithFade);
                      } else {
                        Get.to(() => selectMusic(), transition: Transition.rightToLeftWithFade);
                      }
                    },
                  )
                ],
              ),
            ),
            divider(),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  imageFile(
                    file: controller.selectedImage.value,
                    height: Constants.heightScreen/3,
                    width: Constants.widthScreen,
                    fit: BoxFit.cover
                  ),
                  const SizedBox(height: 2,),
                  Expanded(
                    child: Stack(
                      children: [
                        GridView.count(
                          physics: const BouncingScrollPhysics(),
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          shrinkWrap: true,
                          children: List.generate(controller.imageFiles.length, (index) {
                            return InkWell(
                              onTap: () {
                                controller.selectedImage.value = controller.imageFiles[index];
                              },
                              child: imageFile(
                                  file: controller.imageFiles[index],
                                  height: Constants.heightScreen/5,
                                  width: Constants.widthScreen/3
                              ),
                            );
                          }),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColor.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)
                              )
                            ),
                            child: Row(
                              children: [
                                controller.onlyStory.value
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        controller.changeType("post");
                                      },
                                      child: Text('Bài viết', style: ThemeTextStyle.body14.copyWith(
                                          color: controller.type.value == "post" ? AppColor.white : AppColor.white.withOpacity(0.7),
                                          fontWeight: controller.type.value == "post" ? FontWeight.bold : FontWeight.normal
                                      ),),
                                    ),
                                const SizedBox(width: 12,),
                                InkWell(
                                  onTap: () {
                                    controller.changeType("story");
                                  },
                                  child: Text('Story', style: ThemeTextStyle.body14.copyWith(
                                      color: controller.type.value == "story" ? AppColor.white : AppColor.white.withOpacity(0.7),
                                      fontWeight: controller.type.value == "story" ? FontWeight.bold : FontWeight.normal
                                  ),),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget createDone() {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => controller.hideKeyboard(),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            onPressed: () => Get.back(),
                          ),
                          const Text('Bài viết', style: BaseTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),),
                          InkWell(
                            child: const Text('Đăng', style: BaseTextStyle(
                                color: AppColor.blueTag,
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                            ),),
                            onTap: () {
                              if (controller.type.value == "post") {
                                controller.createPost();
                              } else {
                                controller.createStory();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 64),
                          child: editTextChangeProfile(
                              hintText: 'Viết mô tả...',
                              textInputType: TextInputType.multiline,
                              maxLines: null,
                              controller: controller.descriptionCtl
                          ),
                        ),
                        imageFile(
                            file: controller.selectedImage.value,
                            height: Constants.heightScreen/2,
                            width: Constants.widthScreen,
                            fit: BoxFit.fill
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => Visibility(
            visible: controller.isLoading.value,
            child: const Center(
              child: Loading(),
            ),
          ),)
        ],
      ),
    );
  }

  Widget selectMusic() {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          controller.stopAudio();
                          Get.back();
                        },
                      ),
                      const Text('Story', style: BaseTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),),
                      InkWell(
                        child: const Text('Đăng', style: BaseTextStyle(
                            color: AppColor.blueTag,
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                        ),),
                        onTap: () {
                          print('Tiếp tục: ${controller.descriptionCtl.text}');
                          // controller.createPost();
                        },
                      )
                    ],
                  ),
                ),
                divider(),
                Expanded(
                  child: Stack(
                    children: [
                      imageFile(
                          file: controller.selectedImage.value,
                          height: Constants.heightScreen,
                          width: Constants.widthScreen,
                          fit: BoxFit.fill
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            controller.selectMusic();
                          },
                          icon: const Icon(Icons.music_note_rounded, color: AppColor.white,),
                        ),
                      ),
                      Obx(() => Visibility(
                        visible: controller.currentMusic.value.previewUrl != null,
                        child: Positioned(
                          top: 10,
                          left: 10,
                          child: musicItem(music: controller.currentMusic.value),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Obx(() => Visibility(
            visible: controller.isLoading.value,
            child: const Center(
              child: Loading(),
            ),
          ),)
        ],
      ),
    );
  }

  Widget musicItem({required Items music}) {
    return Container(
      height: 35.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColor.white.withOpacity(0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomLeft: Radius.circular(6),
            ),
            child: cacheImage(
              imgUrl: music.album?.images?[0].url ?? "",
              width: 35.w,
              height: 35.w,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(music.name ?? "Bài hát", style: ThemeTextStyle.heading12.copyWith(color: AppColor.white),),
                Text(music.artists?[0].name ?? "Ẩn danh" , style: ThemeTextStyle.body11.copyWith(color: AppColor.white),),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SearchMusicDialog extends StatelessWidget with WidgetUtils {
  final CreatePostCtl controller;

  const SearchMusicDialog({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Obx(() => Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: AppBar().preferredSize.height-6,
            color: AppColor.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: textFormFieldLogin(
                      borderRadius: 10,
                      leadingIcon: const Icon(Icons.search_rounded),
                      hintText: "Tìm kiếm bài hát...",
                      controller: controller.searchCtl,
                      onFieldSubmitted: (value) {
                        controller.searchingMusic(value);
                      }
                  ),
                ),
              ],
            ),
          ),
          divider(),
          Expanded(
            child: controller.isSearchingMusic.value
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.musicsSearch.length,
                    itemBuilder: (context, index) {
                      var music = controller.musicsSearch[index];
                      return InkWell(
                        onTap: () {
                          controller.onClickMusicItem(music);
                        },
                        child: itemMusicSearch(music),
                      );
                    },
                  ),
          )
        ],
      )),
    );
  }

  Widget itemMusicSearch(Items music) {
    return ListTile(
      leading: cacheImage(
        isAvatar: false,
        height: 40.w,
        width: 40.w,
        imgUrl: music.album?.images?[0].url ?? "",
      ),
      title: Text(music.name ?? "Bài hát", style: ThemeTextStyle.heading13,),
      subtitle: Text(music.artists?[0].name ?? "Ẩn danh", style: ThemeTextStyle.body11,),
      trailing: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          controller.playMusic(music.previewUrl!);
        },
        icon: const Icon(Icons.play_circle_outline_rounded),
      ),
    );
  }


}