import 'dart:io';

import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/commons/upload_image_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/create_post_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/newsfeed_response.dart';
import 'package:chat_app_flutter/pages/home/create_post/create_post_repo.dart';
import 'package:chat_app_flutter/pages/home/create_post/create_post_page.dart';
import 'package:chat_app_flutter/pages/home/home_page.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_ctl.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:chat_app_flutter/service/music_service.dart';
import 'package:chat_app_flutter/utils/shared/assets.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../../models/commons/spotify_music_response.dart';
import '../../../models/commons/user.dart';
import '../../../utils/shared/constants.dart';

class CreatePostCtl extends BaseCtl<CreatePostRepo> {
  TextEditingController descriptionCtl = TextEditingController();
  TextEditingController searchCtl = TextEditingController();
  final audioPlayer = AudioPlayer();

  late Album albumAll;
  RxList<File> imageFiles = <File>[].obs;
  Rx<File> selectedImage = File("").obs;
  int curPage = 1;
  RxBool onlyStory = false.obs;
  RxString type = "post".obs;
  Rx<Items> currentMusic = Items().obs;
  RxList<Items> musicsSearch = <Items>[].obs;
  RxBool isSearchingMusic = false.obs;


  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    requestPermission(toDo: initData);
    audioPlayer.setLoopMode(LoopMode.one);
    if (Get.arguments['from'] != null) {
      onlyStory.value = true;
      type.value = "story";
    }
  }

  Future initData() async {
    isLoading.value = true;
    print('Initial data.......');
    await findAlbumAllImage();
    getImageByPage();
  }

  Future findAlbumAllImage() async {
    final List<Album> imageAlbums = await PhotoGallery.listAlbums(
      mediumType: MediumType.image,
    );
    albumAll = imageAlbums.where((element) => element.name == "All").toList()[0];
  }

  void getImageByPage() async {
    final MediaPage imagePage = await albumAll.listMedia(
      skip: curPage,
      take: 50,
    );
    List<Medium> allMedia = [
      ...imagePage.items,
    ];
    for(var image in allMedia) {
      imageFiles.add(await image.getFile());
    }
    selectedImage.value = imageFiles[0];
    isLoading.value = false;
  }

  Future createPost() async {
    hideKeyboard();
    isLoading.value = true;
    UploadImageResponse? uploadImage = await api.sendImageStore(imageFile: selectedImage.value);
    if (uploadImage == null ) {
      debugPrint('Response null');
      isLoading.value = false;
      showSnackBar(Get.context! , AppColor.red, 'Đã có lỗi xảy ra.');
      return ;
    }

    Map<String, String> bodyData = {
      'content': descriptionCtl.text.trim(),
      'image' : uploadImage.data!.url!,
    };

    try {
      CreatePostResponse? createPostResponse = await api.createPost(bodyData: bodyData);
      if (createPostResponse == null) {
        debugPrint('Response null');
        showSnackBar(Get.context! , AppColor.red, 'Đã có lỗi xảy ra.');
        return ;
      }
      if (createPostResponse.errorCode!.isEmpty) {
        showSnackBar(
            Get.context!,
            AppColor.green,
            "Đăng tải thành công."
        );
        final newsCtl = Get.find<NewsFeedCtl>();
        var newsfeed = Post(
          userId: createPostResponse.data?.userId,
          content: createPostResponse.data?.content,
          createdTime: createPostResponse.data?.createdTime,
          // image: createPostResponse.data?.image,
        );
        newsCtl.newsFeeds.insert(0, newsfeed);
        Get.until((route) => Get.currentRoute == RouteNames.home);
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(createPostResponse.errorCode!)
        );
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Exception');
    }
  }

  void changeType (String typeValue) {
    type.value = typeValue;
  }

  void selectMusic() {
    showBarModalBottomSheet(
        context: Get.context!,
        builder: (context) {
          return SearchMusicDialog(controller: this,);
        }
    ).then((value) {
      if (audioPlayer.playing) {
        audioPlayer.stop();
      }
    });
  }

  void playMusic(String url) async {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    }
    var duration = await audioPlayer.setUrl(url);
    audioPlayer.play();
  }

  void searchingMusic(String key) async {
    isSearchingMusic.value = true;
    musicsSearch.value = await SpotifyMusic.searchSong(key);
    isSearchingMusic.value = false;
  }

  void onClickMusicItem(Items itemClicked) {
    currentMusic.value = itemClicked;
    playMusic(itemClicked.previewUrl!);
    Get.back();
  }

  Future createStory() async {
    stopAudio();
    isLoading.value = true;
    UploadImageResponse? uploadImage = await api.sendImageStore(imageFile: selectedImage.value);
    if (uploadImage == null ) {
      debugPrint('Response null');
      isLoading.value = false;
      showSnackBar(Get.context! , AppColor.red, 'Đã có lỗi xảy ra.');
      return ;
    }

    Map<String, String> bodyData = {
      // 'audio': currentMusic.value.previewUrl!,
      'image' : uploadImage.data!.url!,
    };

    try {
      CreatePostResponse? createPostResponse = await api.createStory(bodyData: bodyData);
      if (createPostResponse == null) {
        debugPrint('Response null');
        showSnackBar(Get.context! , AppColor.red, 'Đã có lỗi xảy ra.');
        return ;
      }
      if (createPostResponse.errorCode!.isEmpty) {
        showSnackBar(
            Get.context!,
            AppColor.green,
            "Đăng tải thành công."
        );
        // final newsCtl = Get.find<NewsFeedCtl>();
        // var newsfeed = Newsfeed(
        //   userId: createPostResponse.data?.userId,
        //   content: createPostResponse.data?.content,
        //   createdTime: createPostResponse.data?.createdTime,
        //   // image: createPostResponse.data?.image,
        // );
        // newsCtl.newsFeeds.insert(0, newsfeed);
        Get.until((route) => Get.currentRoute == RouteNames.home);
      } else {
        showSnackBar(
            Get.context!,
            AppColor.red,
            ErrorCode.getMessageByError(createPostResponse.errorCode!)
        );
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      print('Exception');
    }
  }

  void stopAudio() {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    }
  }

}