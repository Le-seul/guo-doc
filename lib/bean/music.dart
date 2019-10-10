class Music {
  String image ;
  int playCount;
  String lyric;
  String comeFrom;
  String name;
  String id;
  String audioStream ;
  int state;
  int order;

  Music(
      {this.image,
        this.playCount,
        this.lyric,
        this.comeFrom,
        this.name,
        this.id,
        this.audioStream,
        this.state,
        this.order});

  Music.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    playCount = json['playCount'];
    lyric = json['lyric'];
    comeFrom = json['comeFrom'];
    name = json['name'];
    id = json['id'];
    audioStream = json['audioStream'];
    state = json['state'];
    order = json['order'];
  }

  @override
  int get hashCode => id.hashCode;

  static Music fromMap(Map map) {
    if (map == null) {
      return null;
    }
    return Music(
        id: map["id"],
        name: map["name"],
        audioStream: map["audioStream"],
        state: map['state'],
        order: map["order"],
        lyric: map["lyric"],
        comeFrom: map["comeFrom"],
        playCount: map['playCount'],
        image: map["image"],
    );
  }

  Map toMap() {
    return {
      "id": id,
      "name": name,
      "audioStream": audioStream,
      "state": state,
      "order": order,
      "lyric": lyric,
      "comeFrom": comeFrom,
      "playCount": playCount,
      "image": image,
    };
  }
}

