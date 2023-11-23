import 'dart:io';

import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/commons/upload_image_response.dart';
import '../../routes/route_names.dart';
import '../../utils/shared/colors.dart';
import '../../utils/widgets/loading.dart';
import 'create_group_repo.dart';

class CreateGroupCtl extends BaseCtl<CreateGroupRepo> {
  TextEditingController nameCtl = TextEditingController();
  TextEditingController bioCtl = TextEditingController();
  TextEditingController topicCtl = TextEditingController();

  Rx<String> name = "".obs;
  Rx<String> bio = "".obs;
  Rx<String> topic = "".obs;
  Rx<String> avatarUrl = "".obs;
  Rx<String> avatarUrlMain = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  Future pickImage({ImageSource source = ImageSource.gallery}) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    try {
      avatarUrl.value = image.path;
    } catch (e) {
      print('Fail to pick image!');
    }
  }

  Future createGroup() async {
    Get.to(() => const Loading(), opaque: false);
    Map<String, dynamic> bodyData = {
      "name": nameCtl.text.trim(),
      "topic": topicCtl.text.trim(),
      'description': bioCtl.text.trim()
    };

    if (avatarUrlMain.value != avatarUrl.value) {
      UploadImageResponse? uploadImage = await api.sendImageStore(imageFile: File(avatarUrl.value));
      if (uploadImage == null ) {
        debugPrint('Response null');
        isLoading.value = false;
        showSnackBar(Get.context! , AppColor.red, 'Đã có lỗi xảy ra.');
        return ;
      }
      bodyData['banner'] = uploadImage.data!.url!;
    }

    try {
      var response = await api.createGroup(params: bodyData);
      Get.back();
      if (response != null) {
        toPagePopUtil(routeUrl: RouteNames.groupDetail, arguments: {
          "id": response.id
        });
      }

    } catch (e) {
      debugPrint('Ex: ${e.toString()}');
    } finally {

    }
  }
}