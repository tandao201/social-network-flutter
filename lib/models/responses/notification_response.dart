class NotificationAppResponse {
  String? errorCode;
  List<NotiData>? data;

  NotificationAppResponse({this.errorCode, this.data});

  NotificationAppResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    if (json['data'] != null) {
      data = <NotiData>[];
      json['data'].forEach((v) {
        data!.add(NotiData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error_code'] = errorCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotiData {
  int? userId;
  int? type;
  int? targetId;
  List<Notification>? listNoti;
  String? newestTime;

  NotiData({this.userId, this.type, this.targetId, this.listNoti, this.newestTime});

  NotiData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    type = json['type'];
    targetId = json['target_id'];
    if (json['list_noti'] != null) {
      listNoti = <Notification>[];
      json['list_noti'].forEach((v) {
        listNoti!.add(Notification.fromJson(v));
      });
    }
    newestTime = json['newestTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['type'] = type;
    data['target_id'] = targetId;
    if (listNoti != null) {
      data['list_noti'] = listNoti!.map((v) => v.toJson()).toList();
    }
    data['newestTime'] = newestTime;
    return data;
  }
}

class Notification {
  int? id;
  String? body;
  String? title;
  String? avatar;
  String? username;
  int? userSender;
  String? createdTime;

  Notification(
      {this.id,
        this.body,
        this.title,
        this.avatar,
        this.username,
        this.userSender,
        this.createdTime});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    title = json['title'];
    avatar = json['avatar'];
    username = json['username'];
    userSender = json['user_sender'];
    createdTime = json['created_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['body'] = body;
    data['title'] = title;
    data['avatar'] = avatar;
    data['username'] = username;
    data['user_sender'] = userSender;
    data['created_time'] = createdTime;
    return data;
  }
}