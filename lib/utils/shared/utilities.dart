import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/widgets/widgets.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../routes/route_names.dart';

class Utilities {

  Future toPage({required String routeUrl, Map<String, dynamic>? arguments}) async {
    Get.toNamed(routeUrl, arguments: arguments);
  }

  Future toPagePopUtil({required String routeUrl, Map<String, dynamic>? arguments}) async {
    Get.offAndToNamed(routeUrl, arguments: arguments);
  }

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future requestPermission({Function? toDo}) async {
    PermissionStatus request;
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt <= 32) {
      request = await Permission.storage.request();
    }  else {
      request = await Permission.photos.request();
    }

    if (request.isGranted) {
      toDo!();
    } else {
      showSnackbar(
          Get.context!,
          AppColor.grey,
          'Yêu cầu bị từ chối.',
          const Duration(seconds: 3)
      );
    }
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getId(String res) {
    if (res.isEmpty) return "";
    return res.substring(0, res.indexOf("_"));
  }

  String getCurrentUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<String?> getCurrentDeviceToken() {
    return FirebaseMessaging.instance.getToken();
  }

  bool isHasArguments(String key) {
    return Get.arguments[key] != null;
  }

  dynamic getArguments(String key) {
    return Get.arguments[key] ?? dynamic;
  }

  void toProfilePage({required int userId}) {
    toPage(routeUrl: RouteNames.userProfile, arguments: {
      'userId': userId
    });
  }

  void pushNotification({
    String title = "Thông báo",
    String body = "Nội dung",
    required String deviceToken,
    String groupId = "",
    String avatarImg = "",
  }) async {
    Map<String, dynamic> payload = {
      "to": deviceToken,
      "notification": {
        "android_channel_id": "high_importance_channel",
        "title": title,
        "body": body,
        "mutable_content": true,
        "sound": "Tri-tone",
        "priority": "high",
      },
      "data": {
        "title": title,
        "body": body,
        "type": 'message',
        'groupId': groupId,
        'avatarImg': avatarImg
      },
    };
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAl4i9bjg:APA91bGZpD8lHwlCdc9t25pG34mLPnz4li9BqzLSJrKe6PVLbhQBVUWCZb6GjJNmWK2Wb2YHjwCj8ilgXARPR6umlzhnMP90nYftpnBmcXUs7DDx08w3bHX2ftFczlDF6p6ctthbNI10',
    };
    final dio = Dio();
    try {
      print('Pushing notification..........');
      Response response = await dio.post('https://fcm.googleapis.com/fcm/send', data: payload, options: Options(headers: headers));
      if (response.statusCode == 200) {
        print('Push notification successful!');
      }
    } catch (e) {
      print('Push notificaiton ex: ${e.toString()}');
    }
  }

  String formatDatetimeMiniSecondToHour(String time) {
    var today = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    String formatPattern = 'EEE, HH:mm';
    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      formatPattern = 'HH:mm';
    }
    String dayOfWeek = DateFormat(formatPattern, 'vi').format(date);
    return dayOfWeek;
  }

  String getFriendStatus(int status) {
    switch (status) {
      case 1:
        return "Đang yêu cầu";
      case 2:
        return "Đang theo dõi ▼";
      case 3:
        return "Từ chối";
      case 4:
        return "Theo dõi";
      case 5:
        return "Theo dõi";
      case 6:
        return "Theo dõi";
      default:
        return "Không xác định";
    }
  }

  String getFriendStatusListUser(int status) {
    switch (status) {
      case 1:
        return "Đang yêu cầu";
      case 2:
        return "Đang theo dõi";
      case 3:
        return "Từ chối";
      case 4:
        return "Theo dõi";
      case 5:
        return "Theo dõi";
      case 6:
        return "Hủy";
      default:
        return "Không xác định";
    }
  }

}