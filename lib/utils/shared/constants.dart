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
  static const String healthPredictionApi = "https://healthservice.priaid.ch";
  static const String healthLoginApi = "https://sandbox-authservice.priaid.ch";
  static String healthApiToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InRhbi4yNi4xMGEyQGdtYWlsLmNvbSIsInJvbGUiOiJVc2VyIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvc2lkIjoiMTA2NDEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3ZlcnNpb24iOiIxMDkiLCJodHRwOi8vZXhhbXBsZS5vcmcvY2xhaW1zL2xpbWl0IjoiMTAwIiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9tZW1iZXJzaGlwIjoiQmFzaWMiLCJodHRwOi8vZXhhbXBsZS5vcmcvY2xhaW1zL2xhbmd1YWdlIjoiZW4tZ2IiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL2V4cGlyYXRpb24iOiIyMDk5LTEyLTMxIiwiaHR0cDovL2V4YW1wbGUub3JnL2NsYWltcy9tZW1iZXJzaGlwc3RhcnQiOiIyMDIzLTExLTI2IiwiaXNzIjoiaHR0cHM6Ly9hdXRoc2VydmljZS5wcmlhaWQuY2giLCJhdWQiOiJodHRwczovL2hlYWx0aHNlcnZpY2UucHJpYWlkLmNoIiwiZXhwIjoxNzA1MTIxNDk3LCJuYmYiOjE3MDUxMTQyOTd9.KzuMH5Rqpq8oYCOUac5UMQxQy76XBvKL9XhrVQd3nWg";
  static const String healthUsername = "tan.26.10a2@gmail.com";
  static const String healthPassword = "Ae74Ydz8E9SrDf6a5";

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

  static const String listGroup = "/group/list";
  static const String myListGroup = "/group/my-list";
  static const String groupDetail = "/group/get";
  static const String groupMember = "/group/list-member";
  static const String groupNewsfeed = "/group/new-feed";
  static const String createPostGroup = "/group/create-post";
  static const String joinGroup = "/group/join";
  static const String outGroup = "/group/out";
  static const String createGroup = "/group/create";

  static const String loginHealthApi = "/login";
  static const String symptomSearch = "/symptoms";
  static String issueInfo(int issueId) {
   return "/issues/$issueId/info";
  }
  static String diseasePrediction(Map<String, dynamic> params) {
    return "/diagnosis"
    "?symptoms=${params["symptoms"]}"
    "&gender=${params["gender"]}"
    "&year_of_birth=${params["year_of_birth"]}"
    "&token=$healthApiToken"
    "&language=en-gb";
  }

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