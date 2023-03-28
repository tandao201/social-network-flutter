import 'dart:io';

import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/pages/edit_profile/edit_profile_repo.dart';
import 'package:chat_app_flutter/service/database_service.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../models/commons/upload_image_response.dart';
import '../../models/responses/auth_responses/edit_profile_response.dart';
import 'edit_profile_page.dart';

class EditProfileCtl extends BaseCtl<EditProfileRepo> {
  TextEditingController nameCtl = TextEditingController();
  TextEditingController userNameCtl = TextEditingController();
  TextEditingController bioCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController genderCtl = TextEditingController();
  DatabaseService databaseService = DatabaseService();

  Rx<String> username = "".obs;
  Rx<String> name = "".obs;
  Rx<String> bio = "".obs;

  List genders = [
    'Nam',
    'Nữ',
    'Khác'
  ];
  int indexGender = 0;
  Rx<String> avatarUrl = "".obs;
  Rx<String> avatarUrlMain = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initData();
  }

  Future initData() async {
    genderCtl.text = "Nam";
    username = Get.arguments['username'];
    name = Get.arguments['name'];
    bio = Get.arguments['bio'];
    avatarUrlMain = Get.arguments['avatar'];
    avatarUrl.value = avatarUrlMain.value;

    userNameCtl.text = username.value;
    nameCtl.text = name.value;
    bioCtl.text = bio.value;
    phoneCtl.text = globalController!.userInfo.value.mobile ?? "";
  }

  void ctlDispose() {
    nameCtl.dispose();
    userNameCtl.dispose();
    bioCtl.dispose();
    emailCtl.dispose();
    phoneCtl.dispose();
    genderCtl.dispose();
  }

  void selectGender() {
    showBarModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return SelectGenderUI(controller: this,);
      }
    );
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

  Future changeProfile() async {
    isLoading.value = true;
    print('Change profile................');
    Map<String, dynamic> bodyData = {
      // "email": globalController?.userInfo.value.email,
      "username": userNameCtl.text.trim(),
      "mobile": phoneCtl.text.trim(),
      'bio': bioCtl.text.trim()
    };

    if (avatarUrlMain.value != avatarUrl.value) {
      UploadImageResponse? uploadImage = await api.sendImageStore(imageFile: File(avatarUrl.value));
      if (uploadImage == null ) {
        debugPrint('Response null');
        isLoading.value = false;
        showSnackBar(Get.context! , AppColor.red, 'Đã có lỗi xảy ra.');
        return ;
      }
      bodyData['avatar'] = uploadImage.data!.url!;
      databaseService.updateProfileImg(FirebaseAuth.instance.currentUser!.uid, uploadImage.data!.url!);
    }

    try {
      EditProfileResponse? editProfileResponse = await api.editProfile(bodyData: bodyData);
      if (editProfileResponse == null) {
        debugPrint('Response null');
        isLoading.value = false;
        showSnackBar(Get.context! , AppColor.red, 'Đã có lỗi xảy ra.');
        return ;
      }
      if (editProfileResponse.errorCode!.isEmpty) {
        showSnackBar(
            Get.context!,
            AppColor.green,
            "Chỉnh sửa thành công."
        );
        username.value = userNameCtl.text.trim();
        name.value = nameCtl.text.trim();
        bio.value = bioCtl.text.trim();
        avatarUrl.value = editProfileResponse.data!.avatar!;
        avatarUrlMain.value = editProfileResponse.data!.avatar!;
        globalController?.saveUser(editProfileResponse.data!);
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(editProfileResponse.errorCode!)
        );
      }
      isLoading.value = false;
      Get.back();
    } catch (e) {
      isLoading.value = false;
      print('Exception');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ctlDispose();
  }
}