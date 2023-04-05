import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../models/responses/notification_response.dart';
import '../../../utils/shared/constants.dart';

class NotificationRepo extends BaseRepo {

  Future getNotification() async {
    NotificationAppResponse? notificationResponse;
    try {
      Response response = await request(
          url: Constants.userNotification,
          method: Method.GET,
      );
      notificationResponse = NotificationAppResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return notificationResponse;
  }
}