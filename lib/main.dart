import 'package:chat_app_flutter/base/global_ctl.dart';
import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:chat_app_flutter/routes/pages.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

String initialRoute = RouteNames.home;
Future findRoute () async {
  var isLogin = HelperFunctions.getBool(HelperFunctions.isLoginKey);
  if (isLogin) initialRoute = RouteNames.home;
}

Future initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HelperFunctions.init();
  await findRoute();
  Get.put(GlobalController());
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