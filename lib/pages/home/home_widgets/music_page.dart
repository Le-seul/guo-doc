import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';

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
        queryParameters: {"pageSize": 20, "pageNumber": 1},
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black,),
        title: Text(
          '轻松音乐',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 15, right: 15, left: 15),
          color: Colors.white,
          child: GridView.builder(
            physics: ClampingScrollPhysics(),
              itemCount: GetAllMusicList.length,
              //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                  crossAxisCount: 2,
                  //纵轴间距
                  mainAxisSpacing: 0.0,
                  //横轴间距
                  crossAxisSpacing: 15.0,
                  //子组件宽高长度比例
                  childAspectRatio: 0.70),
              itemBuilder: (BuildContext context, int index) {
                //Widget Function(BuildContext context, int index)
                return _buildItem(index);
              })),
    );
  }

  _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        Router.push(context, Router.musicListPage, GetAllMusicList[index]);
      },
      child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.network(
                      GetAllMusicList[index].image,
                      height: 140,
                      width: 140,
                      fit: BoxFit.fill,
                    ),
                  )),
              SizedBox(
                height: 5,
              ),
              Text(GetAllMusicList[index].name, style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.headset,size: 15,color: Colors.black54,),
                  SizedBox(width: 5,),
                  Text('2038',style: TextStyle(color: Colors.black54),),
                ],
              )
            ],
          )),
    );
  }
}
