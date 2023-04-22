# Social network app

This repo is a boilerplate to create flutter application easily. It is based on **GetX**. More info about [GetX](https://pub.dev/packages/get) here. [dio](https://pub.dev/packages/dio), [intl_utils](https://pub.dev/packages/intl_utils) and [shimmer](https://pub.dev/packages/shimmer)

## Getting Started

1. Install [Flutter SDK](https://flutter.dev/docs/get-started/install).
2. Install plugins in Android Studio
    * [Dart Data Class](https://plugins.jetbrains.com/plugin/12429-dart-data-class)
    * [GetX](https://plugins.jetbrains.com/plugin/15919-getx)
3. Clone the repo.
4. Run `flutter pub get`
5. Run app.

## File structure

chat_app_flutter
├───assets
│   ├───fonts
│   │   ├───others
│   │   └───roboto_font
│   ├───icons
│   ├───images
│   └───svgs
└───lib
├───api_service
├───base
├───helper
├───models
│   ├───commons
│   ├───requests
│   └───responses
│       ├───auth_responses
│       ├───post_responses
│       └───somes
├───pages
│   ├───auth
│   │   ├───change_password
│   │   ├───login
│   │   └───register
│   ├───chat
│   │   └───search_chat
│   ├───comment_post
│   ├───edit_profile
│   ├───home
│   │   ├───account
│   │   ├───create_post
│   │   ├───newsfeeds
│   │   ├───notification
│   │   └───search
│   ├───list_all_posts
│   ├───list_user
│   ├───splash
│   ├───story_view
│   └───user_profile
├───routes
├───service
└───utils
├───extensions
├───shared
├───themes
└───widgets

## How to use
- A screen UI and its controller should be created in the 'pages' folder
- Each page should be created 'bindings' to add dependencies of screen such as controller or repository

### Example: Splash screen

** View: **
```java=
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
```

** Controller **
```java=
class SplashCtl extends BaseCtl {

  @override
  void onInit() async {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 1000),(){
      if (globalController!.isLogin.value) {
        toPagePopUtil(routeUrl: RouteNames.home);
      } else {
        toPagePopUtil(routeUrl: RouteNames.login);
      }
    });

  }
}
```

** Bindings **
```java=
class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashCtl());
  }

}
```

** Repository **
```java=
class SplashRepo extends BaseRepo {

  Future getList({required String url}) async {
    ListUserResponse? listUserResponse;

    try {
      Response response = await request(
          url: url,
          method: Method.GET,
      );
      listUserResponse = ListUserResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return listUserResponse;
  }
}
```

### Others

#### Dialog
```java=
showDialogCustom(
      content: "Bạn chắc chắn muốn đăng xuất?",
      onClickAction: () {
        logout();
      }
    );
```

#### SnackBar
```java=
showSnackBar(
  Get.context!,
  AppColor.red,
  ErrorCode.getMessageByError(listUserResponse.errorCode!)
);
```