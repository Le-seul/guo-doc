import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/music/player.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';

class MusicListPage extends StatefulWidget {
  GetAllMusic allMusicList;
  MusicListPage({Key key, @required this.allMusicList}) : super(key: key);
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  List<Music> musicList = List();

  @override
  void initState() {
    DioUtils.instance.requestNetwork<Music>(Method.get, Api.GETMUSICLIST,
        queryParameters: {"musicListId": widget.allMusicList.id},
        isList: true, onSuccessList: (data) {
      setState(() {
        musicList = data;
      });
      print('音乐成功！');
    }, onError: (code, msg) {
      print('音乐失败！');
    });
  }

  @override
  Widget build(BuildContext context) {
    Music music =
        PlayerState.of(context, aspect: PlayerStateAspect.music).value.current;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff2CA687),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            '列表',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              _buildTop(),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '播放列表',
                      style: TextStyle(fontSize: 18),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () {
                        Router.push(context, Router.playingPage, musicList[0]);
                        quiet.playWithList(musicList[0], musicList, 'playlist');
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 3, bottom: 3),
                        margin: EdgeInsets.only(
                          right: 10.0,
                        ),
                        decoration: new BoxDecoration(
                            color: Color(0xff2CA687),
                            borderRadius: new BorderRadius.circular(15.0)),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              loadAssetImage('play.png',
                                  height: 14, width: 14, color: Colors.white),
                              SizedBox(
                                width: 5,
                              ),
                              Center(
                                child: Text(
                                  '全部播放',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 1,
                color: Colors.black12,
                margin: EdgeInsets.only(left: 15, right: 15),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: musicList.length,
                  itemBuilder: (context, index) {
                    Music item = musicList[index];
                    return _buildItem(
                        index, music == null ? false : item.id == music.id);
                  }),
            ],
          ),
        ));
  }

  _buildTop() {
    return GestureDetector(
      onTap: () {
        Router.push(context, Router.musicDetailPage, widget.allMusicList);
      },
      child: Container(
          padding: EdgeInsets.only(left: 10, right: 5),
          color: Color(0xFFEEEEEE),
          child: Column(
            children: <Widget>[
              Container(
                height: 180,
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, right: 5, left: 5),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Image.network(
                            widget.allMusicList.image,
                            height: 140,
                            width: 140,
                            fit: BoxFit.fill,
                          ),
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.allMusicList.name,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('周杰伦', style: TextStyle(color: Colors.black54)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.allMusicList.name,
                          style: TextStyle(color: Colors.black54),
                          strutStyle:
                              StrutStyle(forceStrutHeight: true, height: 1.5),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ],
          )),
    );
  }

  _buildItem(int index, bool isPlaying) {
    return GestureDetector(
        onTap: () {
          Router.push(context, Router.playingPage, musicList[index]);
          quiet.playWithList(musicList[index], musicList, 'playlist');
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  '${musicList[index].order}',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                width: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                musicList[index].name,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: isPlaying
                                        ? Color(0xff2CA687)
                                        : Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '周杰伦',
                                style: TextStyle(
                                    color: isPlaying
                                        ? Color(0xff2CA687)
                                        : Colors.black54,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.play_circle_outline,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 1,
                      color: Colors.black12,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
