class GetAllMusic {
  String image;
  String name;
  String id;
  int state;
  int order;
  int songCount;

  GetAllMusic(
      {this.image, this.name, this.id, this.state, this.order, this.songCount});

  GetAllMusic.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    id = json['id'];
    state = json['state'];
    order = json['order'];
    songCount = json['songCount'];
  }
}

class MusicTag {
  String name;
  String id;

  MusicTag({this.name, this.id});

  MusicTag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }
}

class MusicList {
  String name;
  String id;
  int state;
  int order;

  MusicList({this.name, this.id, this.state, this.order});

  MusicList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    state = json['state'];
    order = json['order'];
  }
}

class MusicDetail {
  String image = 'http://b-ssl.duitang.com/uploads/item/201706/19/20170619170108_YuHLa.jpeg';
  int playCount;
  String lyric;
  String comeFrom;
  String name;
  String id;
  String audioStream;
  int state;
  int order;

  MusicDetail(
      {this.image,
        this.playCount,
        this.lyric,
        this.comeFrom,
        this.name,
        this.id,
        this.audioStream,
        this.state,
        this.order});

  MusicDetail.fromJson(Map<String, dynamic> json) {
//    image = json['image'];
    playCount = json['playCount'];
    lyric = json['lyric'];
    comeFrom = json['comeFrom'];
    name = json['name'];
    id = json['id'];
    audioStream = json['audioStream'];
    state = json['state'];
    order = json['order'];
  }
}