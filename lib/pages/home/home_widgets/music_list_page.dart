import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/music/player_page.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';

class MusicListPage extends StatefulWidget {

  String musicListId;
  MusicListPage({Key key, @required this.musicListId}) : super(key: key);
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {

  final GlobalKey<PlayerState> musicPlayerKey = new GlobalKey();

  List<MusicList> musicList = List();


  @override
  void initState() {
    DioUtils.instance.requestNetwork<MusicList>(
        Method.get,
        Api.GETMUSICLIST,
        queryParameters: {"musicListId": widget.musicListId},
        isList: true,
        onSuccessList: (data) {
          setState(() {
            musicList = data;
          });

        },
        onError: (code, msg) {
          Toast.show('请求失败！');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: Text(
          '筛选歌单',
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: musicList.length,
        itemBuilder: (context, index) => _buildItem(index),),
//      bottomSheet: Container(
//        child: Player(
//          onPrevious: () {},
//          onNext: () {},
//          onCompleted: () {},
//          onPlaying: (isPlaying) {
//          },
//          key: musicPlayerKey,
//          audioUrl: 'http://music.163.com/song/media/outer/url?id=451703096.mp3',
//        ),
//      ),
    );
  }
  _buildItem(index){
    return GestureDetector(
      onTap: (){
        Router.push(context,Router.playingPage,musicList[index].id);
      },
      child:Container(
        padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text('${musicList[index].order}'),
              width: 20,
            ),

            SizedBox(width: 15,),
            Text(musicList[index].name,style: TextStyle(fontSize: 15),),
            Expanded(child: Align(
              alignment: Alignment.centerRight,
            )),
            Icon(Icons.music_video)
          ],
        ),
      )
    );
  }

}

