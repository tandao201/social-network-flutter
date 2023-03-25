import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/story_view/story_view_repo.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

// audio: https://p.scdn.co/mp3-preview/6ff25287b4b077010aacc6324022ef727187a0f5?cid=3b1b5d4a77e644c2929b10626bb85e4d

class StoryViewCtl extends BaseCtl<StoryViewRepo> {
  PageController pageController = PageController();
  final storyCtl = StoryController();
  final AudioPlayer audioPlayer = AudioPlayer();

  List<StoryItem> storyItems = [
    StoryItem.text(
        title: 'Story 1',
        backgroundColor: AppColor.blueTag,
        duration: const Duration(seconds: 10)
    ),
    StoryItem.pageImage(
        url: 'https://cdn.luatminhkhue.vn/lmk/article/Roll-Safe-meme.jpg',
        controller: StoryController(),
        duration: const Duration(seconds: 10)
    )
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future playMusic(String url) async {
    stopMusic();
    var duration = await audioPlayer.setUrl(url);
    audioPlayer.play();
  }

  void stopMusic() {
    if (audioPlayer.playing) audioPlayer.stop();
  }
}