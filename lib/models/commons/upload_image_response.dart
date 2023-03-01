class UploadImageResponse {
  UploadData? data;
  bool? success;
  int? status;

  UploadImageResponse({this.data, this.success, this.status});

  UploadImageResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? UploadData.fromJson(json['data']) : null;
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    data['status'] = status;
    return data;
  }
}

class UploadData {
  String? id;
  String? title;
  String? urlViewer;
  String? url;
  String? displayUrl;
  int? width;
  int? height;
  int? size;
  int? time;
  int? expiration;
  Image? image;
  Image? thumb;
  Image? medium;
  String? deleteUrl;

  UploadData(
      {this.id,
        this.title,
        this.urlViewer,
        this.url,
        this.displayUrl,
        this.width,
        this.height,
        this.size,
        this.time,
        this.expiration,
        this.image,
        this.thumb,
        this.medium,
        this.deleteUrl});

  UploadData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    urlViewer = json['url_viewer'];
    url = json['url'];
    displayUrl = json['display_url'];
    width = json['width'];
    height = json['height'];
    size = json['size'];
    time = json['time'];
    expiration = json['expiration'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    thumb = json['thumb'] != null ? Image.fromJson(json['thumb']) : null;
    medium = json['medium'] != null ? Image.fromJson(json['medium']) : null;
    deleteUrl = json['delete_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url_viewer'] = urlViewer;
    data['url'] = url;
    data['display_url'] = displayUrl;
    data['width'] = width;
    data['height'] = height;
    data['size'] = size;
    data['time'] = time;
    data['expiration'] = expiration;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (thumb != null) {
      data['thumb'] = thumb!.toJson();
    }
    if (medium != null) {
      data['medium'] = medium!.toJson();
    }
    data['delete_url'] = deleteUrl;
    return data;
  }
}

class Image {
  String? filename;
  String? name;
  String? mime;
  String? extension;
  String? url;

  Image({this.filename, this.name, this.mime, this.extension, this.url});

  Image.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    name = json['name'];
    mime = json['mime'];
    extension = json['extension'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['name'] = name;
    data['mime'] = mime;
    data['extension'] = extension;
    data['url'] = url;
    return data;
  }
}
