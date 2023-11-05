import 'package:flutter/material.dart';

enum FriendStatus {
  _,
  request,
  accept,
  deny,
  unfollow,
  delete,
  cancel
}

enum LikeStatus {
  _,
  like,
  dislike,
}

enum SearchType {
  _,
  user,
  post
}

enum NotificationType {
  message,
  requestFollow,
  comment,
  likePost,
  acceptFollow
}

enum Gender {
  _,
  male,
  female
}

enum GroupJoinStatus {
  _,
  joined,
  notJoin
}

enum GroupOwnerStatus {
  _,
  owner,
  notOwner
}

extension GenderEx on Gender {
  IconData getGenderIcon() {
    switch(this) {
      case Gender.male:
        return Icons.male;
      case Gender.female:
        return Icons.female;
      default:
        return Icons.male;
    }
  }
}