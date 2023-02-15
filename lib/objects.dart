class Collection {
  String id;
  String title;
  String subtitle;
  String display;
  List<SongWrap> songs;

  Collection({this.id, this.title, this.subtitle, this.display, this.songs});

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    display = json['display'];
    if (json['songs'] != null) {
      songs = <SongWrap>[];
      json['songs'].forEach((v) {
        songs.add(SongWrap.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['display'] = display;
    if (songs != null) {
      data['songs'] = songs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SongWrap {
  Song songsId;

  SongWrap({this.songsId});

  SongWrap.fromJson(Map<String, dynamic> json) {
    songsId = json['Songs_id'] != null
        ? Song.fromJson(json['Songs_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (songsId != null) {
      data['Songs_id'] = songsId.toJson();
    }
    return data;
  }
}

class Song {
  String id;
  String name;
  Genre genre;
  bool explicit;
  bool enabled;
  SongFile songFile;
  Album album;
  User userCreated;

  Song(
      {this.id,
        this.name,
        this.genre,
        this.explicit,
        this.enabled,
        this.songFile,
        this.album,
        this.userCreated});

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    genre = json['genre'] != null ? Genre.fromJson(json['genre']) : null;
    explicit = json['explicit'];
    enabled = json['enabled'];
    songFile = json['song_file'] != null
        ? SongFile.fromJson(json['song_file'])
        : null;
    album = json['album'] != null ? Album.fromJson(json['album']) : null;
    userCreated = json['user_created'] != null
        ? User.fromJson(json['user_created'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (genre != null) {
      data['genre'] = genre.toJson();
    }
    data['explicit'] = explicit;
    data['enabled'] = enabled;
    if (songFile != null) {
      data['song_file'] = songFile.toJson();
    }
    if (album != null) {
      data['album'] = album.toJson();
    }
    if (userCreated != null) {
      data['user_created'] = userCreated.toJson();
    }
    return data;
  }
}

class Genre {
  String name;

  Genre({this.name});

  Genre.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class SongFile {
  String id;

  SongFile({this.id});

  SongFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class Album {
  SongFile cover;

  Album({this.cover});

  Album.fromJson(Map<String, dynamic> json) {
    cover = json['cover'] != null ? SongFile.fromJson(json['cover']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cover != null) {
      data['cover'] = cover.toJson();
    }
    return data;
  }
}

class User {
  String id;
  String firstName;
  String lastName;

  User({this.id, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}

