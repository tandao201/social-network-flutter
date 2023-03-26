import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../base/base_ctl.dart';
import '../../models/commons/common_response.dart';
import '../../models/responses/auth_responses/login_response.dart';
import '../../models/responses/post_responses/create_post_response.dart';
import '../../models/responses/post_responses/newsfeed_response.dart';
import '../../utils/shared/colors.dart';
import '../../utils/shared/constants.dart';
import '../home/account/account_repo.dart';

class ListAllPostsCtl extends BaseCtl {
  ScrollController scrollCtl = ScrollController();
  late AutoScrollController autoController;

  int postIndex = 0;
  late UserInfo currentUser;
  RxList<Post> posts = <Post>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    postIndex = getArguments('postIndex');
    currentUser = getArguments('currentUser');
    posts.value = getArguments("posts");
    autoController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(Get.context!).padding.bottom),
        axis: Axis.vertical
    );
    await scrollToIndex(postIndex);
  }

  Future initData() async {
    isLoading.value = true;
    await getUserDetail();
  }

  Future getUserDetail() async {
    final apiAccount = Get.find<AccountRepo>();
    Map<String, dynamic> bodyData = {
      'user_id': currentUser.id,
    };
    try {
      CommonResponse<UserInfo>? commonResponse = await apiAccount.getUserDetail(bodyData: bodyData);
      if (commonResponse == null) {
        debugPrint('Response null');
        isLoading.value = false;
        return ;
      }
      if (commonResponse.errorCode!.isEmpty) {
        posts.value = commonResponse.data!.posts!;
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(commonResponse.errorCode!)
        );
      }
      isLoading.value = false;
    } catch (e) {
      print('Ex: ${e.toString()}');
      isLoading.value = false;
    }
  }

  Future scrollToIndex(int index) async {
    print('Scrolling to index: $index');
    await autoController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }


}