import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';

class MusicSortPage extends StatefulWidget {
  @override
  _MusicSortPageState createState() => _MusicSortPageState();
}

class _MusicSortPageState extends State<MusicSortPage> {

  List<MusicTag> musicTagList = List();

  @override
  void initState() {
    _getMusicTag();
  }

  _getMusicTag(){
    DioUtils.instance.requestNetwork<MusicTag>(
        Method.get,
        Api.GETMUSICTAG,
        isList: true,
        onSuccessList: (data) {
          setState(() {
            musicTagList = data;
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
      body: GridView.builder(
          itemCount: musicTagList.length,
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 4,
              //纵轴间距
              mainAxisSpacing: 0.0,
              //横轴间距
              crossAxisSpacing: 0.0,
              //子组件宽高长度比例
              childAspectRatio: 2.0),
          itemBuilder: (BuildContext context, int index) {
            //Widget Function(BuildContext context, int index)
            return getItemContainer(index);
          }),
    );
  }

  getItemContainer(int index) {
    return Container(
//      margin: EdgeInsets.only(top:5,bottom: 5,left:5,right: 5),
      child: FlatButton(onPressed: () {
        Router.push(context, Router.musicPage,{
          'num': 1,'tagId':musicTagList[index].id
        });
      }, child: Text(musicTagList[index].name)),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.5),
          borderRadius: BorderRadius.circular(16)),
    );
  }


}
