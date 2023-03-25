class SpotifyMusicResponse {
  Tracks? tracks;

  SpotifyMusicResponse({this.tracks});

  SpotifyMusicResponse.fromJson(Map<String, dynamic> json) {
    tracks =
    json['tracks'] != null ? Tracks.fromJson(json['tracks']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tracks != null) {
      data['tracks'] = tracks!.toJson();
    }
    return data;
  }
}

class Tracks {
  String? href;
  List<Items>? items;
  int? limit;
  String? next;
  int? offset;
  Null? previous;
  int? total;

  Tracks(
      {this.href,
        this.items,
        this.limit,
        this.next,
        this.offset,
        this.previous,
        this.total});

  Tracks.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    limit = json['limit'];
    next = json['next'];
    offset = json['offset'];
    previous = json['previous'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['limit'] = limit;
    data['next'] = next;
    data['offset'] = offset;
    data['previous'] = previous;
    data['total'] = total;
    return data;
  }
}

class Items {
  AlbumSpotify? album;
  List<Artists>? artists;
  String? name;
  int? popularity;
  String? previewUrl;
  int? trackNumber;
  String? type;
  String? uri;

  Items(
      {this.album,
        this.artists,
        this.name,
        this.popularity,
        this.previewUrl,
        this.trackNumber,
        this.type,
        this.uri});

  Items.fromJson(Map<String, dynamic> json) {
    album = json['album'] != null ? AlbumSpotify.fromJson(json['album']) : null;
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(Artists.fromJson(v));
      });
    }
    name = json['name'];
    popularity = json['popularity'];
    previewUrl = json['preview_url'];
    trackNumber = json['track_number'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (album != null) {
      data['album'] = album!.toJson();
    }
    if (artists != null) {
      data['artists'] = artists!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['popularity'] = popularity;
    data['preview_url'] = previewUrl;
    data['track_number'] = trackNumber;
    data['type'] = type;
    data['uri'] = uri;
    return data;
  }
}

class AlbumSpotify {
  List<Images>? images;
  bool? isPlayable;
  String? name;

  AlbumSpotify(
      {this.images,
        this.isPlayable,
        this.name,});

  AlbumSpotify.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    isPlayable = json['is_playable'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['is_playable'] = isPlayable;
    data['name'] = name;
    return data;
  }
}

class Artists {
  String? href;
  String? id;
  String? name;
  String? type;
  String? uri;

  Artists(
      {this.href, this.id, this.name, this.type, this.uri});

  Artists.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['uri'] = uri;
    return data;
  }
}

class Images {
  int? height;
  String? url;
  int? width;

  Images({this.height, this.url, this.width});

  Images.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['url'] = url;
    data['width'] = width;
    return data;
  }
}

