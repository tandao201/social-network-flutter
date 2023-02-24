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