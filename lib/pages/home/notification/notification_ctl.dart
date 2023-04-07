import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/home/notification/notification_repo.dart';
import 'package:chat_app_flutter/service/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../models/responses/notification_response.dart';
import '../../../utils/shared/colors.dart';
import '../../../utils/shared/constants.dart';

class NotificationCtl extends BaseCtl<NotificationRepo> {

  RxList<NotiData> notifications = <NotiData>[].obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future initData() async {
    await getNotification();
  }

  Future getNotification() async {
    isLoading.value = true;
    try {
      NotificationAppResponse? notificationAppResponse = await api.getNotification();
      if (notificationAppResponse == null) {
        debugPrint('Response null');

        return ;
      }
      if (notificationAppResponse.errorCode!.isEmpty) {
        notifications.value = notificationAppResponse.data ?? [];
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(notificationAppResponse.errorCode!)
        );
      }
    } catch (e) {
      print('Ex: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void clickNotification(int type, int targetId) {
    Map<String, dynamic> data = {
      'type': type.toString(),
      'target_id': targetId.toString()
    };
    NotificationService.handleClickNotification(data);
  }
}