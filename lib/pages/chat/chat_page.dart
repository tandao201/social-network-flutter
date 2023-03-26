
import 'package:chat_app_flutter/helper/utilities.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/global_ctl.dart';
import '../../models/commons/user.dart';
import '../../service/database_service.dart';
import '../../utils/widgets/message_tile.dart';

class ChatPage extends StatefulWidget {
  String groupId;
  String avatarImg;
  final String groupName;
  final String userName;
  final Color colorPage;
  ChatPage(
      {Key? key,
        required this.groupId,
        required this.avatarImg,
        required this.groupName,
        required this.userName,
        required this.colorPage
      })
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with Utilities, WidgetUtils {
  late ScrollController scrollController;

  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";
  bool firstScroll = false;
  late UserFirebase userFb;
  @override
  void initState() {
    if (widget.groupId != 'new') {
      getChatandAdmin();
    }
    scrollController = ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToEnd();
    });
  }

  void scrollToEnd() {
    print('Scrolling to end...............');
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut
      );
    }
  }

  getChatandAdmin() {
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColor.black,
              ),
              onPressed: () => Get.back(),
            ),
            const SizedBox(width: 12,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.colorPage,
                borderRadius: BorderRadius.circular(40)
              ),
              height: 35.w,
              width: 35.w,
              child: widget.avatarImg.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: cacheImage(
                          isAvatar: true,
                          imgUrl: widget.avatarImg
                      ),
                    )
                  : Text(
                      getName(widget.groupName).substring(0,1).toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                    ),
            ),
            const SizedBox(width: 10,),
            Text(widget.groupName, style: ThemeTextStyle.heading18,)
          ],
        ),
        backgroundColor: AppColor.white,
      ),
      body: GestureDetector(
        onTap: () => hideKeyboard(),
        child: Column(
          children: <Widget>[
            // chat messages here
            Expanded(
              child: chatMessages(),
            ),
            Container(
              margin: const EdgeInsets.all(4),
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[500],
                ),
                child: Row(children: [
                  Expanded(
                      child: TextFormField(
                        controller: messageController,
                        style: const TextStyle(color: Colors.white),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: "Gửi tin nhắn...",
                          hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                          border: InputBorder.none,
                        ),
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () async {
                      userFb = await DatabaseService().searchUserByUsername(widget.groupName);
                      if (widget.groupId == 'new') {
                        String uid = getCurrentUid();
                        var listCreate = await DatabaseService(uid: uid).createGroup(
                            widget.userName,
                            uid,
                            userFb.name!,
                            userFb.uid!
                        ) as List<dynamic>;

                        setState(() {
                          widget.groupId = listCreate[2];
                          getChatandAdmin();
                        });
                        sendMessage();
                      } else {
                        sendMessage();
                      }
                      hideKeyboard();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: AppColor.messageColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          )),
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const CupertinoActivityIndicator();
        }
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data.docs.length-1-index;
                  return MessageTile(
                      message: snapshot.data.docs[reverseIndex]['message'],
                      sender: snapshot.data.docs[reverseIndex]['sender'],
                      sentByMe: widget.userName ==
                          snapshot.data.docs[reverseIndex]['sender'],
                      colorPage: widget.colorPage,
                      timeSend: snapshot.data.docs[reverseIndex]['time'].toString(),
                      avatarImg: widget.avatarImg
                  );
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    scrollToEnd();
    String message = messageController.text.trim();
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });
      final globalCtl = Get.find<GlobalController>();
      pushNotification(
        title: globalCtl.userInfo.value.username ?? "",
        body: message,
        deviceToken: userFb.deviceToken ?? "",
        groupId: widget.groupId,
        avatarImg: globalCtl.userInfo.value.avatar ?? ""
      );
    }
  }
}