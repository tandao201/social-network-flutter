import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Constants {
  // --------------- Screen size ----------------
  static double widthScreen = MediaQuery.of(Get.context!).size.width;
  static double heightScreen = MediaQuery.of(Get.context!).size.height;

  // ---------------- Api base url and path ---------------

  static const String baseUrl = "https://project-api-4222.onrender.com";

  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String updateInfo = "/auth/update";
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