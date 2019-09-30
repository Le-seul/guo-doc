import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music.dart';
import 'package:flutter_first/music/player.dart';
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

  List<Music> musicList = List();


  @override
  void initState() {
    DioUtils.instance.requestNetwork<Music>(
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
    );
  }
  _buildItem(index){
    return GestureDetector(
      onTap: (){
        Router.push(context,Router.playingPage,musicList[index]);
        quiet.playWithList(musicList[index], musicList, 'playlist');
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

