import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/home_widgets/music_page.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/util/toast.dart';

class MusicSortPage extends StatefulWidget {
  String tagId;
  int num;
  MusicSortPage({Key key, @required this.num, this.tagId}) : super(key: key);

  @override
  _MusicSortPageState createState() => _MusicSortPageState();
}

class _MusicSortPageState extends State<MusicSortPage> {
  List<MusicTag> musicTagList = List();
  List<GetAllMusic> GetAllMusicList = List();
  @override
  void initState() {
//    _getMusicTag();

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

  _getMusicTag() {
    DioUtils.instance.requestNetwork<MusicTag>(Method.get, Api.GETMUSICTAG,
        isList: true, onSuccessList: (data) {
      setState(() {
        musicTagList = data;
      });
    }, onError: (code, msg) {
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
          itemCount: GetAllMusicList.length,
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
      alignment: Alignment.center,

      child: GestureDetector(
          onTap: () {
            NavigatorUtil.pushPage(context,MusicPage(num: 1,tagId: GetAllMusicList[index].id));

          },
          child: Container(
            padding: EdgeInsets.only(top:2,bottom: 2,left:6,right: 6),
            child: Text(GetAllMusicList[index].name,maxLines: 1,),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(12)),
          ),
          ),
    );
  }
}
