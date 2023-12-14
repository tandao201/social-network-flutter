///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class GroupEntity {
/*
{
  "id": 3,
  "name": "group member",
  "owner": 2,
  "banner": null,
  "topic": "tooth",
  "description": null,
  "created_time": "2023-10-22T07:47:48.771Z",
  "updated_time": "2023-10-22T07:47:48.771Z",
  "is_join": 2
}
*/

  int? id;
  String? name;
  int? owner;
  String? banner;
  String? topic;
  String? description;
  String? createdTime;
  String? updatedTime;
  int? isJoin;

  GroupEntity({
    this.id,
    this.name,
    this.owner,
    this.banner,
    this.topic,
    this.description,
    this.createdTime,
    this.updatedTime,
    this.isJoin,
  });
  GroupEntity.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    owner = json['owner']?.toInt();
    banner = json['banner']?.toString();
    topic = json['topic']?.toString();
    description = json['description']?.toString();
    createdTime = json['created_time']?.toString();
    updatedTime = json['updated_time']?.toString();
    isJoin = json['is_join']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['owner'] = owner;
    data['banner'] = banner;
    data['topic'] = topic;
    data['description'] = description;
    data['created_time'] = createdTime;
    data['updated_time'] = updatedTime;
    data['is_join'] = isJoin;
    return data;
  }
}

class ListGroupResponseData {
/*
{
  "data": [
    {
      "id": 3,
      "name": "group member",
      "owner": 2,
      "banner": null,
      "topic": "tooth",
      "description": null,
      "created_time": "2023-10-22T07:47:48.771Z",
      "updated_time": "2023-10-22T07:47:48.771Z",
      "is_join": 2
    }
  ],
  "total": 3
}
*/

  List<GroupEntity>? data;
  int? total;

  ListGroupResponseData({
    this.data,
    this.total,
  });
  ListGroupResponseData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <GroupEntity>[];
      v.forEach((v) {
        arr0.add(GroupEntity.fromJson(v));
      });
      this.data = arr0;
    }
    total = json['total']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['data'] = arr0;
    }
    data['total'] = total;
    return data;
  }
}

class ListGroupResponse {
/*
{
  "error_code": "",
  "data": {
    "data": [
      {
        "id": 3,
        "name": "group member",
        "owner": 2,
        "banner": null,
        "topic": "tooth",
        "description": null,
        "created_time": "2023-10-22T07:47:48.771Z",
        "updated_time": "2023-10-22T07:47:48.771Z",
        "is_join": 2
      }
    ],
    "total": 3
  }
}
*/

  String? errorCode;
  ListGroupResponseData? data;

  ListGroupResponse({
    this.errorCode,
    this.data,
  });
  ListGroupResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code']?.toString();
    data = (json['data'] != null) ? ListGroupResponseData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error_code'] = errorCode;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}