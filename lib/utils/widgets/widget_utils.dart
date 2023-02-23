import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
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
    String? hintText,
    TextEditingController? controller,
    double? borderRadius,
    Function? onTextChange,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        onTextChange?.call(value);
      },
      obscureText: obscureText,
      decoration: InputDecoration(
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

  CachedNetworkImage cacheImage({
    String imgUrl = "",
    double height = 56,
    double width = 56,
    BoxFit fit = BoxFit.fill,
  }) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      height: height,
      width: width,
      placeholder: (context, url) => ClipRRect(borderRadius: BorderRadius.circular(40),child: loadingImage(width: height, height: width),),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColor.lightGrey1,
          borderRadius: BorderRadius.circular(60)
        ),
        child: Image.asset(Assets.defaultImage, fit: BoxFit.fill,),
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
    double width = 56,
    double height = 56,
    String imgUrl = "",
  }) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: AppColor.gradientReaded ,
            borderRadius: BorderRadius.circular(60),
          ),
          width: width+11,
          height: height+11,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
              width: 5,
              color: AppColor.white,
            ) ,
            color: AppColor.grey,
          ),
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
}
