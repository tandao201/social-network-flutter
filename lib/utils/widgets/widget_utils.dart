import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_flutter/utils/extensions/string_extension.dart';
import 'package:chat_app_flutter/utils/shared/enums.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/responses/post_responses/create_post_response.dart';
import '../shared/assets.dart';
import '../shared/colors.dart';

class WidgetUtils {
  AppBar appBar({
    String? title,
    Function? onClickLeading,
    Color? backgroundColor,
  }) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColor.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 15,
          color: AppColor.black,
        ),
        onPressed: () => onClickLeading!(),
      ),
      title: title != null ? Text(title) : Container(),
    );
  }

  TextFormField textFormFieldLogin({
    Icon? leadingIcon,
    String? hintText,
    TextEditingController? controller,
    FocusNode? focusNode,
    double? borderRadius,
    Function(String value)? onTextChange,
    Function(String value)? onFieldSubmitted,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: (value) {
        onTextChange?.call(value);
      },
      onFieldSubmitted: (value) {
        onFieldSubmitted?.call(value);
      },
      obscureText: obscureText,
      decoration: InputDecoration(
          prefixIcon: leadingIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13.5, horizontal: 15),
          hintText: hintText ?? "",
          hintStyle: ThemeTextStyle.hintText14,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
              borderSide: BorderSide(
                width: 0.5,
                color: AppColor.black.withOpacity(0.1),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
              borderSide: BorderSide(
                width: 0.5,
                color: AppColor.black.withOpacity(0.1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
              borderSide: BorderSide(
                width: 0.5,
                color: AppColor.black.withOpacity(0.1),
              )),
          fillColor: AppColor.lightGrey,
          filled: true,
          isDense: true),
    );
  }

  TextFormField editTextChangeProfile({
    String? hintText,
    TextEditingController? controller,
    FocusNode? focusNode,
    double? borderRadius,
    Function(String value)? onTextChange,
    bool obscureText = false,
    bool enabled = true,
    TextInputType textInputType = TextInputType.text,
    int? maxLines = 1,
  }) {
    return TextFormField(
      maxLines: maxLines,
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      onChanged: (value) {
        onTextChange?.call(value);
      },
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: hintText ?? "",
          hintStyle: ThemeTextStyle.hintText14,
          border: InputBorder.none,
          isDense: true),
    );
  }

  TextFormField editTextComment({
    String? hintText,
    TextEditingController? controller,
    double? borderRadius,
    Function? onTextChange,
    bool obscureText = false,
    bool enabled = true,
    TextInputType textInputType = TextInputType.text,
    int? maxLines = 1,
  }) {
    return TextFormField(
      maxLines: maxLines,
      enabled: enabled,
      controller: controller,
      onChanged: (value) {
        onTextChange?.call(value);
      },
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: hintText ?? "",
          hintStyle: ThemeTextStyle.hintText14,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: AppColor.black,
              width: 1
            )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                  color: AppColor.black,
                  width: 1
              )
          ),
          isDense: true),
    );
  }

  CachedNetworkImage cacheImage({
    String imgUrl = "",
    double height = 56,
    double width = 56,
    BoxFit fit = BoxFit.fill,
    bool isAvatar = true,
  }) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      height: height,
      width: width,
      placeholder: (context, url) => ClipRRect(borderRadius: BorderRadius.circular(isAvatar ? 60 : 0),child: loadingImage(width: height, height: width),),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColor.lightGrey1,
          borderRadius: BorderRadius.circular(isAvatar ? 60 : 0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isAvatar ? 60 : 0) ,
          child: Image.asset(Assets.defaultImage, fit: BoxFit.fill,),
        ),
      ),
      fit: fit,
    );
  }

  Widget loadingImage({
    required double width,
    required double height,
  }) {
    return Shimmer.fromColors(
      baseColor: AppColor.black,
      highlightColor: AppColor.grey,
      child: Container(
        color: AppColor.grey,
        width: width,
        height: height,
      ),
    );
  }

  Widget avatar({
    bool isShowBorder = false,
    double width = 56,
    double height = 56,
    String imgUrl = "",
  }) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (isShowBorder)
          Container(
          decoration: BoxDecoration(
            gradient: AppColor.gradientReaded ,
            borderRadius: BorderRadius.circular(60),
          ),
          width: width+11,
          height: height+11,
        ),
        Container(
          decoration: isShowBorder
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  width: 5,
                  color: AppColor.white,
                ),
                color: AppColor.grey,
              )
            : null,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: cacheImage(
                imgUrl: imgUrl,
                width: width,
                height: height
            ),
          ),
        ),
      ],
    );
  }

  Widget imageFile({
    File? file,
    double borderRadius = 0,
    double width = 36,
    double height = 36,
    BoxFit fit = BoxFit.fill,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: file != null
        ? Image.file(file, width: width, height: height,fit: fit,)
        : Image.asset(Assets.defaultImage, fit: fit,),
    );
  }
  
  Future showDialogCustom({
    String title = "Thông báo",
    String content = "Nội dung",
    String textAction = "Chọn",
    String textCancel = "Hủy",
    Function? onClickAction,
    Function? onClickCancel,
  }) async {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          backgroundColor: AppColor.lightGrey1,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 13),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(content),
              const SizedBox(height: 18),
              divider(),
              SizedBox(
                // width: MediaQuery.of(context).size.width,
                height: 40,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    if (onClickAction != null) {
                      onClickAction();
                    }
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      textAction,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppColor.blueTag,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              divider(),
              SizedBox(
                // width: MediaQuery.of(context).size.width,
                height: 40,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(13.0),
                    bottomRight: Radius.circular(13.0),
                  ),
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    if (onClickCancel != null) {
                      onClickCancel();
                    }
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      textCancel,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  void showSnackBar(context, color, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 14),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {},
          textColor: Colors.white,
        ),
      ),
    );
  }

  Widget divider({double height = 1}) {
    return Divider(
      color: AppColor.lightGrey,
      height: 1,
    );
  }

  Widget noData({String type = "nội dung"}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.emptyState, fit: BoxFit.fill,),
          Text('Chưa có $type nào.', style: ThemeTextStyle.heading15,)
        ],
      ),
    );
  }

  Widget itemNewsFeed({
    required BuildContext context,
    required Post newsfeed,
    required Function onClickComment,
    Function? onRequestFriend,
    Function? onClickProfile,
    Function? onClickLike,
    bool isShowFollow = true,
    double width = 375,
  }) {
    Rx<bool> isShowHeart = false.obs;
    Rx<bool> isLike = (newsfeed.likeStatus == LikeStatus.like.index).obs;
    Rx<int> likeAmount = (newsfeed.amountLike ?? 0).obs;
    Rx<double> scale = 1.0.obs;

    void clickLike() {
      onClickLike!();
      scale.value = 1.05;
      Future.delayed(const Duration(milliseconds: 200), () {
        scale.value = 1.0;
      });
      if (isLike.value) {
        likeAmount.value--;
      } else {
        likeAmount.value++;
      }
      isLike.value = !isLike.value;
    }
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  onClickProfile!();
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: cacheImage(
                          imgUrl: newsfeed.user?.avatar ?? "",
                          height: 32.w,
                          width: 32.w
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(newsfeed.user?.username ?? "Người dùng" , style: ThemeTextStyle.heading13,),
                        const SizedBox(height: 1,),
                        Text('Hà Nội, Việt Nam' , style: ThemeTextStyle.body11,),
                      ],
                    )
                  ],
                ),
              ),
              Visibility(
                visible: false,
                child: InkWell(
                  onTap: () {
                    if (onRequestFriend != null) {
                      onRequestFriend();
                    }
                  },
                  child: const Text('Theo dõi', style: ThemeTextStyle.heading13Blue,),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            isShowHeart.value = true;
            Future.delayed(const Duration(milliseconds: 1000), () {
              isShowHeart.value = false;
            });
            if (!isLike.value) {
              clickLike();
            }
          },
          child: Stack(
            children: [
              cacheImage(
                  imgUrl: newsfeed.image ?? "",
                  height: width,
                  width: width,
                  isAvatar: false
              ),
              Visibility(
                visible: isShowHeart.value,
                child: const Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: Icon(Icons.favorite_rounded, size: 120, color: AppColor.white,),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            onClickComment();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            color: AppColor.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              clickLike();
                            },
                            child: AnimatedScale(
                              scale: scale.value,
                              duration: const Duration(microseconds: 50),
                              child: !isLike.value
                                  ? SvgPicture.asset(Assets.like)
                                  : const Icon(Icons.favorite_rounded, color: AppColor.red,size: 28,) ,
                            ),
                          ),
                          const SizedBox(width: 17,),
                          SvgPicture.asset(Assets.comment)
                        ],
                      ),
                      Container(),
                      SvgPicture.asset(Assets.saveNewsFeed)
                    ],
                  ),
                ),
                Text('${likeAmount.value} lượt thích', style: ThemeTextStyle.heading13,),
                const SizedBox(height: 5,),
                Visibility(
                  visible: true,
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: newsfeed.user?.username ?? "Người dùng", style: ThemeTextStyle.heading13),
                          TextSpan(text: '  ${newsfeed.content}', style: ThemeTextStyle.body13),
                        ]
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Text('${newsfeed.amountComment} bình luận', style: ThemeTextStyle.body12.copyWith(color: AppColor.grey),),
                Text('${newsfeed.createdTime}'.timeAgo(), style: BaseTextStyle(fontSize: 12, color: AppColor.grey),),
                const SizedBox(height: 8,),
              ],
            ),
          ),
        )
      ],
    ));
  }

}
