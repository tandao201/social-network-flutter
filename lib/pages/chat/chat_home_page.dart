import 'package:chat_app_flutter/base/global_ctl.dart';
import 'package:chat_app_flutter/helper/utilities.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_ctl.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:chat_app_flutter/utils/widgets/loading.dart';
import 'package:chat_app_flutter/utils/widgets/widget_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/auth_service.dart';
import '../../service/database_service.dart';
import '../../utils/themes/text_style.dart';
import '../../utils/widgets/group_tile.dart';
import '../../utils/widgets/widgets.dart';

class ChatHomePage extends StatefulWidget with WidgetUtils {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  State<ChatHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<ChatHomePage> with WidgetUtils, Utilities {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  Future getSubDes(var database, String groupId) async {
    var doc = await database.groupCollection.doc(groupId).get();
    String recentMessage = doc['recentMessage'];
    String name = doc['recentMessageSender'];
    String receiverId = "image";
    List<String>? members = [];
    for (var member in doc['members']) {
      members.add(member);
    }
    for (var member in members) {
      if (!member.contains(userName)) {
        receiverId = member;
        break;
      }
    }
    return [name, recentMessage, receiverId];
  }

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    var globalCtl = Get.find<GlobalController>();

    setState(() {
      email = globalCtl.userInfo.value.email!;
      userName = globalCtl.userInfo.value.username!;
    });
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            width: double.infinity,
            height: AppBar().preferredSize.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        final feedCtl = Get.find<NewsFeedCtl>();
                        feedCtl.animateToIndex(0);
                      },
                    ),
                    const SizedBox(width: 12,),
                    Text(userName, style: ThemeTextStyle.heading18,),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.search_rounded),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.toNamed(RouteNames.searchChat);
                  },
                ),
              ],
            ),
          ),
          divider(),
          Expanded(
            child: groupList(),
          )
        ],
      ),
    );
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['groups'].length - index - 1;
                  var database = DatabaseService();
                  String groupId = getId(snapshot.data['groups'][reverseIndex]);
                  return FutureBuilder(
                    future: getSubDes(database, groupId),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        var list = snap.data! as List<String>;
                        print('Ten chat: ${list[2]}');
                        String recentSender = list[0] == userName ? "Bạn" : userName;
                        return GroupTile(
                          groupId: groupId,
                          groupName: getName(list[2]),
                          userName: '$recentSender: ${list[1]}',
                          avatarImg: '',
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return const Loading();
        }
      },
    );
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              // popUpDialog(context);
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Bạn chưa có tin nhắn nào",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}