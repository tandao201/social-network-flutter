
import 'package:chat_app_flutter/helper/utilities.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:chat_app_flutter/utils/themes/text_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../service/database_service.dart';
import '../../utils/widgets/message_tile.dart';

class ChatPage extends StatefulWidget {
  String groupId;
  final String groupName;
  final String userName;
  final Color colorPage;
  ChatPage(
      {Key? key,
        required this.groupId,
        required this.groupName,
        required this.userName,
        required this.colorPage
      })
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with Utilities {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  String admin = "";

  @override
  void initState() {
    if (widget.groupId != 'new') {
      getChatandAdmin();
    }
    super.initState();
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
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName, style: ThemeTextStyle.heading18,),
        backgroundColor: AppColor.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: GestureDetector(
        onTap: () => hideKeyboard(),
        child: Stack(
          children: <Widget>[
            // chat messages here
            chatMessages(),
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
                      if (widget.groupId == 'new') {
                        String uid = getCurrentUid();
                        var listCreate = await DatabaseService(uid: uid).createGroup(
                            widget.userName,
                            uid,
                            getName(widget.groupName),
                            getId(widget.groupName)
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
                        color: widget.colorPage,
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
        return snapshot.hasData
            ? ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return MessageTile(
                message: snapshot.data.docs[index]['message'],
                sender: snapshot.data.docs[index]['sender'],
                sentByMe: widget.userName ==
                    snapshot.data.docs[index]['sender'],
                colorPage: widget.colorPage,
            );
          },
        )
            : Container();
      },
    );
  }

  sendMessage() {
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
    }
  }
}