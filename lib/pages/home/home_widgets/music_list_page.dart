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
    DioUtils.instance.requestNetwork<Music>(
        Method.get,
        Api.GETMUSICLIST,
        queryParameters: {"musicListId": widget.allMusicList.id},
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
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color(0xFFEEEEEE),
        centerTitle: true,
      ),
      body:ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          _buildTop(),
          Container(
            padding: EdgeInsets.only(left: 10,right: 10,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 15,),
              Text('${musicList.length}',style: TextStyle(color: Colors.green,fontSize: 20),),
              SizedBox(width: 5,),
              Text('条音频',style: TextStyle(color: Colors.black54),),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  Router.push(context,Router.playingPage,musicList[0]);
                  quiet.playWithList(musicList[0], musicList, 'playlist');
                },
                child: Container(

                  margin: EdgeInsets.only(right:10.0,),
                  height: 26,
                  width: 110,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    loadAssetImage('play.png',height: 15,width: 15,color: Colors.green),
                        SizedBox(width: 5,),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            '全部播放',
                            style: TextStyle(fontSize: 15, color: Colors.green ),
                          ),
                        ),

                      ],
                    ),
                  ),

                ),
              ),

            ],),
          ),
          SizedBox(height: 10,),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: musicList.length,
            itemBuilder: (context, index) => _buildItem(index),),
        ],
      )
    );
  }
  _buildTop() {
    return GestureDetector(
      onTap: (){

      },
      child:Container(
        padding: EdgeInsets.only(left: 10),
          height: 105,
          color: Color(0xFFEEEEEE),
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child:  ClipRRect(
                        borderRadius: BorderRadius.circular(4),child:Image.network(
                        widget.allMusicList.image,
                        height: 70,
                        fit: BoxFit.fill,
                      ),)
                    ),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10,top: 15,bottom: 15
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(widget.allMusicList.name,style: TextStyle(fontSize: 18),),
                                  SizedBox(width: 10,),
                                  loadAssetImage('more.png',height: 15,width: 15),
                                ],
                              ),
                              Text(
                                '周杰伦',
                                style: TextStyle(color: Colors.black12, fontSize: 12),
                              ),

                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          )),
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
              child: Text('${musicList[index].order}',style: TextStyle(fontSize: 30),),
              width: 40,
            ),
            SizedBox(width: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(musicList[index].name,style: TextStyle(fontSize: 18),),
                Text('周杰伦',style: TextStyle(color: Colors.black12,fontSize: 12),)
              ],
            ),

            Expanded(child: Align(
              alignment: Alignment.centerRight,
            )),
          ],
        ),
      )
    );
  }

}

