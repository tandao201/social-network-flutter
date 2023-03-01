import 'package:chat_app_flutter/base/base_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import '../../models/responses/auth_responses/edit_profile_response.dart';
import '../../utils/shared/constants.dart';

class EditProfileRepo extends BaseRepo {
  Future editProfile({required Map<String, dynamic> bodyData}) async {
    EditProfileResponse? editProfileResponse;
    try {
      Response response = await request(
          url: Constants.updateInfo,
          method: Method.PUT,
          params: bodyData
      );
      editProfileResponse = EditProfileResponse.fromJson(response.data);
    } catch (e) {
      debugPrint('Request failed: $e}');
    }
    return editProfileResponse;
  }
}