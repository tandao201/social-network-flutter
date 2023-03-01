import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/home/create_post/create_post_ctl.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/loading.dart';

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
                  const Text('Bài viết', style: BaseTextStyle(
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
                      Get.to(() => createDone(), transition: Transition.rightToLeftWithFade);
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
                    child: GridView.count(
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
                              print('Tiếp tục: ${controller.descriptionCtl.text}');
                              controller.createPost();
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
}