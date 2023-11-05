import 'package:chat_app_flutter/pages/auth/login/login_page.dart';
import 'package:chat_app_flutter/pages/chat/search_chat/search_chat_bindings.dart';
import 'package:chat_app_flutter/pages/chat/search_chat/search_chat_page.dart';
import 'package:chat_app_flutter/pages/edit_profile/edit_profile_bindings.dart';
import 'package:chat_app_flutter/pages/edit_profile/edit_profile_page.dart';
import 'package:chat_app_flutter/pages/group_detail/group_detail_page.dart';
import 'package:chat_app_flutter/pages/health_info_result/health_info_result_page.dart';
import 'package:chat_app_flutter/pages/home/create_post/create_post_bindings.dart';
import 'package:chat_app_flutter/pages/home/create_post/create_post_page.dart';
import 'package:chat_app_flutter/pages/home/groups/list_group_page.dart';
import 'package:chat_app_flutter/pages/home/home_bindings.dart';
import 'package:chat_app_flutter/pages/home/home_page.dart';
import 'package:chat_app_flutter/pages/home/notification/notification_page.dart';
import 'package:chat_app_flutter/pages/home/search/search_page.dart';
import 'package:chat_app_flutter/pages/list_user/list_user_page.dart';
import 'package:chat_app_flutter/pages/splash/splash_bindings.dart';
import 'package:chat_app_flutter/pages/splash/splash_page.dart';
import 'package:chat_app_flutter/pages/story_view/story_bindings.dart';
import 'package:chat_app_flutter/pages/story_view/story_view_page.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:get/get.dart';

import '../pages/auth/login/login_bindings.dart';
import '../pages/comment_post/comment_post_bindings.dart';
import '../pages/comment_post/comment_post_page.dart';
import '../pages/group_detail/group_detail_bindings.dart';
import '../pages/health_info_cal/health_info_bindings.dart';
import '../pages/health_info_cal/health_info_page.dart';
import '../pages/health_info_result/health_info_result_bindings.dart';
import '../pages/home/groups/list_group_bindings.dart';
import '../pages/home/health_prediction/health_prediction_bindings.dart';
import '../pages/home/health_prediction/health_prediction_page.dart';
import '../pages/home/notification/notification_bindings.dart';
import '../pages/home/search/search_bindings.dart';
import '../pages/list_all_posts/list_all_post_page.dart';
import '../pages/list_all_posts/list_all_posts_bindings.dart';
import '../pages/list_user/list_user_bindings.dart';
import '../pages/user_profile/user_profile_bindings.dart';
import '../pages/user_profile/user_profile_page.dart';

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

      GetPage(
          name: RouteNames.commentPost,
          page: () => const CommentPostPage(),
          binding: CommentPostBindings(),
          transition: Transition.rightToLeft
      ),
      GetPage(
          name: RouteNames.story,
          page: () => const StoryViewPage(),
          binding: StoryViewBindings(),
          transition: Transition.zoom
      ),
      GetPage(
          name: RouteNames.createPost,
          page: () => const CreatePostPage(),
          binding: CreatePostBindings(),
          transition: Transition.downToUp
      ),
      GetPage(
          name: RouteNames.searchChat,
          page: () => const SearchChatPage(),
          binding: SearchChatBindings(),
          transition: Transition.downToUp
      ),
      GetPage(
          name: RouteNames.allPosts,
          page: () => const ListAllPostsPage(),
          binding: ListAllPostsBindings(),
          transition: Transition.downToUp
      ),
      GetPage(
          name: RouteNames.userProfile,
          page: () => const UserProfilePage(),
          binding: UserProfileBindings(),
          transition: Transition.downToUp
      ),
      GetPage(
          name: RouteNames.listUser,
          page: () => const ListUserPage(),
          binding: ListUserBindings(),
          transition: Transition.downToUp
      ),
      GetPage(
          name: RouteNames.addHealthInfo,
          page: () => const HealthInfoPage(),
          binding: HealthInfoBindings(),
          transition: Transition.rightToLeft
      ),
      GetPage(
          name: RouteNames.addHealthInfoResult,
          page: () => const HealthInfoResultPage(),
          binding: HealthInfoResultBindings(),
          transition: Transition.rightToLeft
      ),
      GetPage(
          name: RouteNames.notification,
          page: () => const NotificationPage(),
          binding: NotificationBindings(),
          transition: Transition.rightToLeft
      ),
      GetPage(
          name: RouteNames.healthPrediction,
          page: () => const HealthPredictionPage(),
          binding: HealthPredictionBindings(),
          transition: Transition.rightToLeft
      ),
      GetPage(
          name: RouteNames.listGroup,
          page: () => const ListGroupPage(),
          binding: ListGroupBindings(),
          transition: Transition.rightToLeft
      ),
      GetPage(
          name: RouteNames.searchApp,
          page: () => const SearchPage(),
          binding: SearchBindings(),
          transition: Transition.rightToLeft
      ),
      GetPage(
          name: RouteNames.groupDetail,
          page: () => const GroupDetailPage(),
          binding: GroupDetailBindings(),
          transition: Transition.rightToLeft
      ),
    ];
  }
}