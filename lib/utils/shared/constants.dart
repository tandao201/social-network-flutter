import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  // --------------- Screen size ----------------
  static double widthScreen = MediaQuery.of(Get.context!).size.width;
  static double heightScreen = MediaQuery.of(Get.context!).size.height;

  // ---------------- Api base url and path ---------------

  static const String baseUrl = "https://project-api-4222.onrender.com";
  static const String imageUploadUrl = "https://api.imgbb.com/1/upload";
  static const String keyImageUpload = "f044fa8f4cb65404a2affe6334d7fef5";
  static const String healthPredictionApi = "https://medius-disease-prediction.p.rapidapi.com/api/v2";
  static const Map<String, String> predictionApiHeader = {
    'content-type': 'application/json',
    'Content-Type': 'application/json',
    'X-RapidAPI-Key': 'dde826ed3emsh28e5598c354f300p1e924fjsnfc564c5fede3',
    'X-RapidAPI-Host': 'medius-disease-prediction.p.rapidapi.com'
  };

  static const String login = "/auth/login";
  static const String register = "/auth/register";

  static const String changePassword = "/user/change-password";
  static const String updateInfo = "/user/update-profile";
  static const String userDetail = "/user/get";
  static const String requestFriend = "/user/request-friend";
  static const String receiveFriend = "/user/receive-friend";
  static const String listFollow = "/user/list-follow";
  static const String search = "/user/search";
  static const String userNotification = "/user/list-notification";
  static const String listFollowing = "/user/list_following";
  static const String listFollowers = "/user/list_follower";
  static const String listRequestFollow = "/user/list_request_follow";

  static const String createPost = "/posts/create";
  static const String newsfeed = "/posts/new-feed";
  static const String likePostUrl = "/posts/like";
  static const String detailPost = "/posts/get";

  static const String createStory = "/stories/create";
  static const String listStories = "/stories/list";
  static const String seenStory = "/stories/seen";

  static const String listComment = "/comment/list-comment";
  static const String createComment = "/comment/create";
  static const String deleteComment = "/comment/delete-comment";
  static const String likeComment = "/comment/like";


  static const String symptomSearch = "/symptom-search";
  static const String frequentSymptomSearch = "/frequent-symptoms";
  static const String diseasePrediction = "/disease-prediction";

}

class ErrorCode {
  // ---------- Error code server response --------------
  static const String userNotFound = 'USER_NOT_FOUND';
  static const String passwordInvalid = 'PASSWORD_IS_INVALID';
  static const String emailExist = 'EMAIL_EXISTS';
  static const String usernameExist = 'USERNAME_EXISTS';

  // --------- Error message client ----------
  static const String infoLoginEmpty = 'Nhập tài khoản và mật khẩu.';
  static const String passwordSmall = 'Mật khẩu phải lớn hơn 8 kí tự.';
  static const String rePasswordFalse = 'Mật khẩu không trùng khớp.';
  static const String inputFullInfo = 'Nhập đầy đủ thông tin.';

  static String getMessageByError(String errorCode) {
    switch (errorCode) {
      case userNotFound:
        return "Tài khoản không tồn tại.";
      case passwordInvalid:
        return "Mật khẩu không đúng.";
      case emailExist:
        return "Tài khoản đã tồn tại.";
      case usernameExist:
        return "Username đã tồn tại.";
      default:
        return "Đã có lỗi. Xin thử lại";
    }
  }
}