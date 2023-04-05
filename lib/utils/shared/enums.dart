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