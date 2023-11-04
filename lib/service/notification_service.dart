import 'dart:convert';
import 'dart:math';
import 'package:chat_app_flutter/pages/home/home_ctl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:chat_app_flutter/utils/shared/utilities.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../base/global_ctl.dart';
import '../pages/chat/chat_page.dart';
import '../utils/widgets/widgets.dart';

class NotificationService extends GetxService with Utilities {
  FirebaseMessaging? _messaging;
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isFlutterLocalNotificationsInitialized = false;

  FirebaseMessaging? get messaging {
    _messaging ??= FirebaseMessaging.instance;
    return _messaging;
  }

  Future requestAndInitNotification() async {
    initFCM();
    registerNotification();
    getTokenFCM();
  }

  Future<void> initFCM() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_noti');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onSelectNotification,
        onDidReceiveNotificationResponse: onSelectNotification
    );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;

    // FirebaseMessaging.onBackgroundMessage();
    FirebaseMessaging.onMessage.listen(_firebaseMessaging);
    FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingOpenedApp);

    ///  Get any messages which caused the application to open from a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleInitialNotification(initialMessage);
    }

    NotificationAppLaunchDetails? localNotificationLaunch = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (localNotificationLaunch != null) {
      if ((localNotificationLaunch.notificationResponse?.payload ?? "").isNotEmpty) {
        handleClickNotification(jsonDecode(localNotificationLaunch.notificationResponse?.payload ?? ""));
      }
    }
  }

  /// when app on foreground
  Future _firebaseMessaging(RemoteMessage message) async {
    debugPrint("On message data: ${message.data}");
    showFlutterNotification(message);
  }
  Future _firebaseMessagingOpenedApp(RemoteMessage message) async {
    /// when in background click notification
    debugPrint("Opened message data: ${message.data}");
    handleClickNotification(message.data);
  }

  void getTokenFCM() async {
    debugPrint("Token FCM: ${await messaging?.getToken()}");
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetail,
        payload: jsonEncode(message.data),
      );
    }
  }

  void scheduleNotification() async {
    flutterLocalNotificationsPlugin.zonedSchedule(
        Random().nextInt(10000),
        "Hãy uống nước thôi nào!",
        "Sau khi hoàn thành hãy chọn lượng nước tương ứng để xác nhận và ghi nhớ đã uống nhé!",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 30)),
        notificationDetail,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: jsonEncode({
          "type": "navigate",
          "to": RouteNames.home,
          "data": 3
        })
    );
  }

  NotificationDetails get notificationDetail => NotificationDetails(
    android: AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      // TODO add a proper drawable resource to android, for now using
      //      one that already exists in example app.
      icon: '@mipmap/ic_noti',
      importance: Importance.max,
      priority: Priority.high,
    ),
  );

  static void onSelectNotification(NotificationResponse response) {
    /*Do whatever you want to do on notification click. In this case, I'll show an alert dialog*/
    debugPrint('CLick notification payload: ${response.payload}');
    handleClickNotification(jsonDecode(response.payload!));
  }

  void handleInitialNotification(RemoteMessage initialMessage) {
    print('Initial message: ${initialMessage.data}');
    handleClickNotification(initialMessage.data);
  }

  static void handleClickNotification(Map<String, dynamic> data) {
    dynamic type = data['type'];
    print('Type: $type');
    switch (type) {
      case "message":
        final globalCtl = Get.find<GlobalController>();
        nextScreen(
            Get.context,
            ChatPage(
              groupId: data['groupId'],
              avatarImg: data['avatarImg'],
              groupName: data['title'],
              userName: globalCtl.userInfo.value.username!,
              colorPage: Colors.pink,
            ));
        break;
      case "navigate":
        if (data["to"] == RouteNames.home) {
          int index = data['data'];
          if (Get.isRegistered<HomeCtl>() && Get.find<HomeCtl>().pageController.position.hasContentDimensions) {
            Get.find<HomeCtl>().clickBottomNavItem(index);
          } else {
            Get.find<GlobalController>().specificIndexTabHome = index;
          }
          Utilities.backToPage(routeUrl: RouteNames.home);
        }
        break;
      case "1":
        /// request follow notification
        Get.toNamed(RouteNames.listUser, arguments: {
          'index': 2
        });
        break;
      case "2":
        /// comment notification
        print('Comment action');
        Get.toNamed(RouteNames.allPosts, arguments: {
          'type': 'single',
          'postId': int.parse(data['target_id'])
        });
        break;
      case "3":
        /// like notification
        print('Like action');
        Get.toNamed(RouteNames.allPosts, arguments: {
          'type': 'single',
          'postId': int.parse(data['target_id'])
        });
        break;
      case "4":
        /// accept notification
        break;
    }
  }
}