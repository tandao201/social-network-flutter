import 'package:chat_app_flutter/base/global_ctl.dart';
import 'package:chat_app_flutter/utils/shared/utilities.dart';
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
  late DatabaseService database;
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";
  List<Group> groupsList = [];
  List<String> groupsId = [];

  Future<Group> getSubDes( String groupId) async {
    groupId = getId(groupId);
    var doc = await database.groupCollection.doc(groupId).get();
    String recentMessage = doc['recentMessage'];
    String name = doc['recentMessageSender'];
    String recentMessageTime = doc['recentMessageTime'];
    String receiverId = "";
    List<String>? members = [];
    String img = "";
    for (var member in doc['members']) {
      members.add(member);
      print('Member: $member');
    }
    for (var member in members) {
      if (getName(member) != userName) {
        receiverId = member;
        break;
      }
    }
    String idPartner = '';
    String groupName = '';
    if (receiverId.isEmpty) {
      idPartner = getCurrentUid();
      groupName = userName;
    } else {
      idPartner = getId(receiverId);
      groupName = getName(receiverId);
    }
    img = await database.getUserImg(idPartner);
    return Group(
        groupId: groupId,
        avatarImg: img,
        currentMes: recentMessage,
        currentSender: name,
        groupName: groupName,
        recentMessageTime: recentMessageTime
    );
  }

  @override
  void initState() {
    super.initState();
    gettingUserData();
    _isLoading = true;
    database = DatabaseService(uid: getCurrentUid());
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
    groups?.listen((event) async {
      if (event.data() != null) {
        groupsId = (event.data()['groups'] as List).map((e) => e as String).toList();
        for (var group in groupsId) {
          var tmp = await getSubDes(group);
          groupsList.add(tmp);
        }
        groupsList.sort((a,b) => b.recentMessageTime.compareTo(a.recentMessageTime));
        print('Data event: ${event.data()['groups']}');
        setState(() {
          _isLoading = false;
        });
      }
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
            child: _isLoading
              ? const Loading()
              : groupList(),
          )
        ],
      ),
    );
  }


  groupList() {
    return ListView.builder(
      itemCount: groupsList.length,
      itemBuilder: (context, index) {
        var group = groupsList[index];
        return GroupTile(
          groupId: group.groupId,
          groupName: getName(group.groupName),
          userName: '${group.currentSender == userName ? "Bạn" : group.currentSender}: ${group.currentMes}',
          avatarImg: group.avatarImg,
        );
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

class Group {
  String groupId;
  String groupName;
  String currentMes;
  String currentSender;
  String avatarImg;
  String recentMessageTime;

  Group({
    required this.groupId,
    required this.groupName,
    required this.currentMes,
    required this.currentSender,
    required this.avatarImg,
    required this.recentMessageTime,
  });
}

// print('Groups: ${snapshot.data['groups'][index]}');
// int reverseIndex = snapshot.data['groups'].length - index - 1;
// var database = DatabaseService();
// String groupId = getId(snapshot.data['groups'][reverseIndex]);
// var list = getSubDes(database, groupId);
// print('Ten chat: ${list[3]}');
// String recentSender = list[0] == userName ? "Bạn" : userName;
