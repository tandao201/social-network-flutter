import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:chat_app_flutter/base/global_ctl.dart';
import 'package:chat_app_flutter/utils/shared/utilities.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:get/get.dart';

class BaseCtl<T extends BaseRepo> extends GetxController with Utilities, WidgetUtils {
  T get api => Get.find<T>();
  GlobalController? globalController;
  RxBool isLoading = false.obs;
  RxBool isLoadMore = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    globalController = Get.find<GlobalController>();
  }
}

// Future login() async {
//   Map<String, String> bodyData = {
//     'email': usernameCtl.text.trim(),
//     'password': passwordCtl.text.trim(),
//   };
//   try {
//     LoginResponse? loginResponse = await api.login(bodyData: bodyData);
//     if (loginResponse == null) {
//       debugPrint('Response null');
//       btnController.stop();
//       return ;
//     }
//     if (loginResponse.errorCode!.isEmpty) {
//       authService.loginWithUserNameandPassword(
//           usernameCtl.text.trim(),
//           passwordCtl.text.trim()
//       );
//       showSnackBar(
//           Get.context!,
//           AppColor.green,
//           "Đăng nhập thành công."
//       );
//       saveInfoLogin(loginResponse);
//       toPagePopUtil(routeUrl: RouteNames.home);
//     } else {
//       showSnackBar(
//           Get.context!,
//           AppColor.red,
//           ErrorCode.getMessageByError(loginResponse.errorCode!)
//       );
//     }
//
//     btnController.stop();
//   } catch (e) {
//     btnController.stop();
//   }
// }