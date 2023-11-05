import 'dart:io';

import 'package:chat_app_flutter/base/base_ctl.dart';
import 'package:chat_app_flutter/models/commons/upload_image_response.dart';
import 'package:chat_app_flutter/models/responses/post_responses/create_post_response.dart';
import 'package:chat_app_flutter/pages/group_detail/group_detail_ctl.dart';
import 'package:chat_app_flutter/pages/home/create_post/create_post_repo.dart';
import 'package:chat_app_flutter/pages/home/create_post/create_post_page.dart';
import 'package:chat_app_flutter/pages/home/newsfeeds/news_feed_ctl.dart';
import 'package:chat_app_flutter/routes/route_names.dart';
import 'package:chat_app_flutter/service/music_service.dart';
import 'package:chat_app_flutter/utils/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../../models/commons/spotify_music_response.dart';
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
  RxBool hideStory = false.obs;
  RxString type = "post".obs;
  Rx<Items> currentMusic = Items().obs;
  RxList<Items> musicsSearch = <Items>[].obs;
  RxBool isSearchingMusic = false.obs;
  String from = "";
  int groupId = -1;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // requestPermission(toDo: initData);
    audioPlayer.setLoopMode(LoopMode.one);
    if (isHasArguments('from')) {
      from = getArguments("from");
      if (from == "group") {
        onlyStory.value = false;
        hideStory.value = true;
        type.value = "post";
        groupId = getArguments("group_id");
      } else {
        onlyStory.value = true;
        type.value = "story";
      }
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

    Map<String, dynamic> bodyData = {
      'content': descriptionCtl.text.trim(),
      'image' : uploadImage.data!.url!,
    };

    if (groupId != -1) {
      bodyData['group_id'] = groupId;
    }

    try {
      CreatePostResponse? createPostResponse = from == "group"
        ? await api.createPostGroup(bodyData: bodyData)
        : await api.createPost(bodyData: bodyData);

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
        var newsfeed = Post(
            userId: createPostResponse.data?.userId,
            content: createPostResponse.data?.content,
            image: createPostResponse.data?.image,
            createdTime: createPostResponse.data?.createdTime,
            user: createPostResponse.data?.user
        );
        if (from == "group") {
          final newsCtl = Get.find<GroupDetailCtl>();
          newsCtl.newsFeeds.insert(0, newsfeed);
          Get.back();
        } else {
          final newsCtl = Get.find<NewsFeedCtl>();
          newsCtl.newsFeeds.insert(0, newsfeed);
          Get.until((route) => Get.currentRoute == RouteNames.home);
        }
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
    } finally {
      isLoading.value = false;
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
      'music': currentMusic.value.previewUrl!,
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
        final newsCtl = Get.find<NewsFeedCtl>();
        newsCtl.getStories();
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

  Future pickImage({ImageSource source = ImageSource.gallery}) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    try {
      selectedImage.value = File(image.path);
    } catch (e) {
      print('Fail to pick image!');
    }
  }

}