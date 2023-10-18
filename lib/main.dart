import 'dart:io';

import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:chat_app_flutter/base/global_ctl.dart';
import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:chat_app_flutter/models/commons/health_entity.dart';
import 'package:chat_app_flutter/routes/pages.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:chat_app_flutter/service/auth_service.dart';
import 'package:chat_app_flutter/service/notification_service.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

String initialRoute = RouteNames.login;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Notification Message data: ${message.data}');
}

Future findRoute () async {
  var isLogin = HelperFunctions.getBool(HelperFunctions.isLoginKey);
  if (isLogin) {
    String username = HelperFunctions.getString(HelperFunctions.userNameKey);
    String password = HelperFunctions.getString(HelperFunctions.passwordKey);
    AuthService().loginWithUserNameandPassword(username, password);
    if (Get.find<GlobalController>().userInfo.value.healthEntity != null) {
      initialRoute = RouteNames.home;
    } else {
      initialRoute = RouteNames.addHealthInfo;
    }
  }
}

Future initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HelperFunctions.init();
  Get.put(GlobalController());
  Get.put(BaseRepo());
  await findRoute();
  final notificationService = Get.put(NotificationService());
  notificationService.requestAndInitNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
}

void main() async {
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget)=>
          GetMaterialApp(
            builder: (context, widget){
              ScreenUtil.init(context);
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!
              );
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('vi', 'VN'),
              Locale('en', 'US'),
            ],
            debugShowCheckedModeBanner: false,
            // builder: EasyLoading.init(),
            initialRoute: initialRoute,
            locale: const Locale("vi"),
            theme: ThemeData(
                primaryColor: AppColor.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                brightness: Brightness.light,
                fontFamily: "BeVietnamPro"
            ),
            getPages: Pages.pages(),
          ),
    );
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}