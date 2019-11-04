import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/search.dart';

class MusicPage extends StatefulWidget {
  String tagId;
  int num;
  MusicPage({Key key, @required this.num, this.tagId}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  List<GetAllMusic> GetAllMusicList = List();

  @override
  void initState() {
    if (widget.num == 0) {
      _getAllMusicList();
    } else if (widget.num == 1) {
      _getMusicListByTag();
    }
  }

  _getMusicListByTag() {
    DioUtils.instance.requestNetwork<GetAllMusic>(
        Method.get, Api.GETMUSICLISTBYTAG,
        queryParameters: {"tagId": widget.tagId},
        isList: true, onSuccessList: (data) {
      setState(() {
        GetAllMusicList = data;
      });
    }, onError: (code, msg) {
      Toast.show('请求失败！');
    });
  }

  _getAllMusicList() {
    DioUtils.instance.requestNetwork<GetAllMusic>(
        Method.get, Api.GETAllMUSICLIST,
        queryParameters: {"pageSize": 3, "pageNumber": 1},
        isList: true, onSuccessList: (data) {
      setState(() {
        GetAllMusicList = data;
      });
    }, onError: (code, msg) {
      Toast.show('请求失败！');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Text(
                  '音乐',
                  style: TextStyle(color: Colors.black),
                ),
               ),

        body: Container(
          child: Container(
              padding: EdgeInsets.only(top: 10, right: 10, left: 10),
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                //设置四周边框
                border: new Border.all(width: 1, color: Colors.white),
              ),
              height: double.infinity,
              child: GridView.builder(
                  itemCount: GetAllMusicList.length,
                  //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //横轴元素个数
                      crossAxisCount: 2,
                      //纵轴间距
                      mainAxisSpacing: 0.0,
                      //横轴间距
                      crossAxisSpacing: 0.0,
                      //子组件宽高长度比例
                      childAspectRatio: 0.8),
                  itemBuilder: (BuildContext context, int index) {
                    //Widget Function(BuildContext context, int index)
                    return _buildItem(index);
                  })),
          color: Color(0xFFEEEEEE),
          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        ));
  }

  _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        Router.push(context, Router.musicListPage, GetAllMusicList[index]);
      },
      child: Container(
          height: 105,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  GetAllMusicList[index].image,
                  height:140,
                  width: 140,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 5,),
                  Text(GetAllMusicList[index].name,
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            ],
          )),
    );
  }
}
