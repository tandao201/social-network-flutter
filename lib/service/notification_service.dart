import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../base/global_ctl.dart';
import '../main.dart';
import '../pages/chat/chat_page.dart';
import '../utils/widgets/widgets.dart';

class NotificationService extends GetxService {
  FirebaseMessaging? _messaging;
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isFlutterLocalNotificationsInitialized = false;

  FirebaseMessaging? get messaging {
    _messaging ??= FirebaseMessaging.instance;
    return _messaging;
  }

  Future requestAndInitNotification() async {
    NotificationSettings settings = await messaging!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted permission');
      initFCM();
      registerNotification();
      getTokenFCM();
    } else {
      print('User declined or has not accepted permission');
    }
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
        NotificationDetails(
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
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

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
      case 1:
        /// do something
        break;
    }
  }
}