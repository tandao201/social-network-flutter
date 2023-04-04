import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/responses/auth_responses/login_response.dart';
import 'package:chat_app_flutter/pages/story_view/story_view_page.dart';
import 'package:chat_app_flutter/pages/story_view/story_view_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../models/commons/common_response.dart';
import '../../models/responses/post_responses/stories_response.dart';

// audio: https://p.scdn.co/mp3-preview/6ff25287b4b077010aacc6324022ef727187a0f5?cid=3b1b5d4a77e644c2929b10626bb85e4d

class StoryViewCtl extends BaseCtl<StoryViewRepo> {
  PageController pageController = PageController();
  final storyCtl = StoryController();
  final AudioPlayer audioPlayer = AudioPlayer();

  RxInt currentStory = 0.obs;
  List<StoriesData> listStory = <StoriesData>[];
  RxList<List<StoryItem>> storiesItem = <List<StoryItem>>[].obs;
  RxList<UserInfo> usersView = <UserInfo>[].obs;
  RxString currentTime = "".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    RxList<StoriesData> tmp = getArguments("stories") as RxList<StoriesData>;
    for (int i=1 ; i<tmp.length ; i++) {
      listStory.add(tmp[i]);
    }
    isLoading.value = true;
    await initStories();
    isLoading.value = false;
  }

  Future initStories() async {
    for(var story in listStory) {
      if (story.listStory != null) {
        List<StoryItem> storiesTmp = [];
        for (var storyItem in story.listStory!) {
          storiesTmp.add(StoryItem.pageImage(
            url: storyItem.image ?? "",
            controller: StoryController(),
            music: storyItem.music ?? "",
            duration: const Duration(seconds: 15),
            createdTime: storyItem.createdTime ?? "",
            id: storyItem.id ?? -1,
            usersView: storyItem.userView
          ));
          if (currentTime.value.isEmpty) {
            currentTime.value = storyItem.createdTime ?? "";
          }
        }
        storiesItem.add(storiesTmp);
      }
    }
    print('List storiesItem: ${storiesItem.length}');
  }

  Future playMusic(String url) async {
    stopMusic();
    var duration = await audioPlayer.setUrl(url);
    audioPlayer.play();
  }

  void stopMusic() {
    if (audioPlayer.playing) audioPlayer.stop();
  }

  Future seenStory(int storyId) async {
    Map<String, dynamic> bodyData = {
      'story_id': storyId,
    };
    try {
      CommonResponse? loginResponse = await api.seenStory(bodyData: bodyData);
      if (loginResponse == null) {
        debugPrint('Response null');
        return ;
      }
      if (loginResponse.errorCode!.isEmpty) {

      } else {

      }
    } catch (e) {
      print('Ex seen story: ${e.toString()}');
    }
  }

  void showUserView() {
    showBarModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return StoryViewer(controller: this,);
      }
    );
  }
}