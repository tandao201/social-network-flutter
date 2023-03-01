import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/pages/story_view/story_view_repo.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryViewCtl extends BaseCtl<StoryViewRepo> {
  final storyCtl = StoryController();

  List<StoryItem> storyItems = [
    StoryItem.text(
        title: 'Story 1',
        backgroundColor: AppColor.blueTag,
        duration: const Duration(seconds: 5)
    ),
    StoryItem.pageImage(
        url: 'https://cdn.luatminhkhue.vn/lmk/article/Roll-Safe-meme.jpg',
        controller: StoryController(),
        duration: const Duration(seconds: 5)
    )
  ];
}