# Social network app

This repo is a boilerplate to create flutter application easily. It is based on **GetX**. More info about [GetX](https://pub.dev/packages/get) here. [dio](https://pub.dev/packages/dio), [intl_utils](https://pub.dev/packages/intl_utils) and [shimmer](https://pub.dev/packages/shimmer)

## Getting Started

1. Install [Flutter SDK v3.3.10](https://docs.flutter.dev/release/archive).
2. Install plugins in Android Studio
    * [Dart Data Class](https://plugins.jetbrains.com/plugin/12429-dart-data-class)
    * [GetX](https://plugins.jetbrains.com/plugin/15919-getx)
3. Clone the repo.
4. Run `flutter pub get`
5. Run app.

## File structure
chat_app_flutter<br/>
├───assets<br/>
│   ├───fonts<br/>
│   │   ├───others<br/>
│   │   └───roboto_font<br/>
│   ├───icons<br/>
│   ├───images<br/>
│   └───svgs<br/>
└───lib<br/>
├───api_service<br/>
├───base<br/>
├───helper<br/>
├───models<br/>
│   ├───commons<br/>
│   ├───requests<br/>
│   └───responses<br/>
│       ├───auth_responses<br/>
│       ├───post_responses<br/>
│       └───somes<br/>
├───pages<br/>
│   ├───auth<br/>
│   │   ├───change_password<br/>
│   │   ├───login<br/>
│   │   └───register<br/>
│   ├───chat<br/>
│   │   └───search_chat<br/>
│   ├───comment_post<br/>
│   ├───edit_profile<br/>
│   ├───home<br/>
│   │   ├───account<br/>
│   │   ├───create_post<br/>
│   │   ├───newsfeeds<br/>
│   │   ├───notification<br/>
│   │   └───search<br/>
│   ├───list_all_posts<br/>
│   ├───list_user<br/>
│   ├───splash<br/>
│   ├───story_view<br/>
│   └───user_profile<br/>
├───routes<br/>
├───service<br/>
└───utils<br/>
├───extensions<br/>
├───shared<br/>
├───themes<br/>
└───widgets
 
## How to use
- A screen UI and its controller should be created in the 'pages' folder
- Each page should be created 'bindings' to add dependencies of screen such as controller or repository

### Example: Splash screen

**View:**
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

**Controller**
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

**Bindings**
```java=
class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashCtl());
  }

}
```

**Repository**
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
