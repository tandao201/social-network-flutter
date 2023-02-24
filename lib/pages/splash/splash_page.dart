import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/splash/splash_ctl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/shared/assets.dart';

class SplashPage extends BaseView<SplashCtl> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      body: controller.isLoading.value
        ? const CupertinoActivityIndicator()
        : Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(
                Assets.icLogo,
                fit: BoxFit.fill,
                width: 65,
                height: 65,
              ),
            ),
          ),
    );
  }

}