import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music_entity.dart';

class MusicDetail extends StatefulWidget {
  String name;
  String image;
  MusicDetail(this.image,this.name) ;
  @override
  _MusicDetailState createState() => _MusicDetailState();
}

class _MusicDetailState extends State<MusicDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          '详情',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 15),
        width: double.infinity,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                ),
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20,),
                Text(
                  '这是一首旋律非常简洁的歌曲却深深打动了几代中国人，这是一首旋律非常简洁的歌曲却深深打动了几代中国人，这是一首旋律非常简洁的歌曲却深深打动了几代中国人，这是一首旋律非常简洁的歌曲却深深打动了几代中国人，这是一首旋律非常简洁的歌曲却深深打动了几代中国人，这是一首旋律非常简洁的歌曲却深深打动了几代中国人，这是一首旋律非常简洁的歌曲却深深打动了几代中国人。',
                  strutStyle: StrutStyle(forceStrutHeight: true, height: 2.2),
                  style: TextStyle(fontSize: 18,color: Colors.black54),
                ),
                SizedBox(height: 25,)
            ],),

          ],
        ),
      ),
    );
  }
}
