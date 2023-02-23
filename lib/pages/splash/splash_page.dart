import 'package:chat_app_flutter/base/base_view.dart';
import 'package:chat_app_flutter/pages/splash/splash_ctl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends BaseView<SplashCtl> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget viewBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main"),
      ),
      body: controller.isLoading.value
        ? const CupertinoActivityIndicator()
        : const Text('Splash'),
    );
  }

}