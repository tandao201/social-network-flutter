import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../base/base_ctl.dart';
import '../../models/commons/common_response.dart';
import '../../models/responses/auth_responses/login_response.dart';
import '../../models/responses/post_responses/create_post_response.dart';
import '../../models/responses/post_responses/detail_post_response.dart';
import '../../utils/shared/colors.dart';
import '../../utils/shared/constants.dart';
import '../home/account/account_repo.dart';

class ListAllPostsCtl extends BaseCtl {
  ScrollController scrollCtl = ScrollController();
  late AutoScrollController autoController;

  int postId = 0;
  int postIndex = 0;
  UserInfo currentUser = UserInfo();
  RxList<Post> posts = <Post>[].obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    autoController = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(Get.context!).padding.bottom),
        axis: Axis.vertical
    );
    if (getArguments('type') == 'all') {
      postIndex = getArguments('postIndex');
      currentUser = getArguments('currentUser');
      posts.value = getArguments("posts");
      await scrollToIndex(postIndex);
    }
    else  {
      postId = getArguments('postId');
      getDetailPost();
    }
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

  Future getDetailPost() async {
    isLoading.value = true;
    try {
      DetailPostResponse? detailPostResponse = await api.getDetailPost(postId);
      if (detailPostResponse == null) {
        debugPrint('Response null');
        return ;
      }
      if (detailPostResponse.errorCode!.isEmpty) {
        posts.value = detailPostResponse.data ?? [];
        currentUser = detailPostResponse.data?[0].user ?? UserInfo();
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(detailPostResponse.errorCode!)
        );
      }
    } catch (e) {
      print('Ex: ${e.toString()}');
      showSnackBar(
          Get.context!,
          AppColor.red,
          ErrorCode.getMessageByError("Đã có lỗi. Xin thử lại")
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future scrollToIndex(int index) async {
    print('Scrolling to index: $index');
    await autoController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
  }


}