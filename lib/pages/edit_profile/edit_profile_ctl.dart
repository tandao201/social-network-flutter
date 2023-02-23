import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/edit_profile/edit_profile_repo.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/shared/constants.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'edit_profile_page.dart';

class EditProfileCtl extends BaseCtl<EditProfileRepo> {
  TextEditingController nameCtl = TextEditingController();
  TextEditingController userNameCtl = TextEditingController();
  TextEditingController bioCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController genderCtl = TextEditingController();

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

    userNameCtl.text = username.value;
    nameCtl.text = name.value;
    bioCtl.text = bio.value;
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
    print('Change profile................');
    username.value = userNameCtl.text;
    name.value = nameCtl.text;
    bio.value = bioCtl.text;
    Get.back();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ctlDispose();
  }
}