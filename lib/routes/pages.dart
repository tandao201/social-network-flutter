import 'package:chat_app_flutter/pages/auth/login/login_page.dart';
import 'package:chat_app_flutter/pages/edit_profile/edit_profile_bindings.dart';
import 'package:chat_app_flutter/pages/edit_profile/edit_profile_page.dart';
import 'package:chat_app_flutter/pages/home/home_bindings.dart';
import 'package:chat_app_flutter/pages/home/home_page.dart';
import 'package:chat_app_flutter/pages/splash/splash_bindings.dart';
import 'package:chat_app_flutter/pages/splash/splash_page.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:get/get.dart';

import '../pages/auth/login/login_bindings.dart';

class Pages {
  static List<GetPage> pages() {
    return [
      GetPage(
        name: RouteNames.splash,
        page: () => const SplashPage(),
        binding: SplashBindings(),
        transition: Transition.rightToLeft
      ),

      GetPage(
          name: RouteNames.login,
          page: () => const LoginPage(),
          binding: LoginBindings(),
          transition: Transition.rightToLeft
      ),

      GetPage(
          name: RouteNames.home,
          page: () => const HomePage(),
          binding: HomeBindings(),
          transition: Transition.rightToLeft
      ),
      GetPage(
          name: RouteNames.editProfile,
          page: () => const EditProfilePage(),
          binding: EditProfileBindings(),
          transition: Transition.downToUp
      ),
    ];
  }
}