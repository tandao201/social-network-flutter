
import 'dart:io';

import 'package:chat_app_flutter/base/global_ctl.dart';
import 'package:chat_app_flutter/helper/utilities.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:chat_app_flutter/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:math';
import '../../pages/chat/chat_page.dart';
import '../shared/colors.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final String avatarImg;
  const GroupTile(
      {Key? key,
        required this.groupId,
        required this.groupName,
        required this.userName,
        required this.avatarImg,
      })
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> with Utilities {
  var rng = Random();
  String userName = "";
  Color colorPage = Colors.blueAccent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var ctl = Get.find<GlobalController>();
    userName = ctl.userInfo.value.username!;
    colorPage = AppColor.colors[rng.nextInt(AppColor.colors.length)];
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatPage(
              groupId: widget.groupId,
              groupName: widget.groupName,
              userName: userName,
              colorPage: colorPage,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: colorPage,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.groupId == 'new' ? getName(widget.groupName) : widget.groupName,
            style: ThemeTextStyle.heading15
          ),
          subtitle: Text(
            widget.groupId == 'new' ? "" :widget.userName,
            style: const TextStyle(fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}