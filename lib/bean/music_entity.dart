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
