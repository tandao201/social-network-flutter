class UserFirebase {
  String? name;
  String? imageUrl;
  String? email;
  String? uid;
  List<String>? groups;
  String? deviceToken;
  List<dynamic>? stories;

  UserFirebase({
    this.name,
    this.imageUrl,
    this.stories,
    this.email,
    this.groups,
    this.uid,
    this.deviceToken
  });

  UserFirebase.fromJson(Map<String, dynamic> json) {
    name = json['fullName'];
    imageUrl = json['profilePic'];
    stories = [];
    email = json['email'];
    groups = <String>[];
    for (var group in json['groups']) {
      groups?.add(group);
    }
    uid = json['uid'];
    deviceToken = json['deviceToken'];
  }
}