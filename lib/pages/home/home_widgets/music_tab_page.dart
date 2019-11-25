import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';

class MusicTabPage extends StatefulWidget {
  String tagId;
  MusicTabPage(this.tagId);
  @override
  _MusicTabPageState createState() => _MusicTabPageState();
}

class _MusicTabPageState extends State<MusicTabPage> {
  bool isShowLoading = true; //课程图片
  List<GetAllMusic> getTagMusicList = List();

  @override
  void initState() {
    if (widget.tagId == "0") {
      _getAllMusicList();
    }else{
      _getMusicListByTag();
    }

  }

  _getAllMusicList() {
    DioUtils.instance.requestNetwork<GetAllMusic>(
        Method.get, Api.GETAllMUSICLIST,
        queryParameters: {"pageSize": 20, "pageNumber": 1},
        isList: true, onSuccessList: (data) {
      setState(() {
        getTagMusicList = data;
        isShowLoading = false;
      });
    }, onError: (code, msg) {
      Toast.show('请求失败！');
    });
  }

  _getMusicListByTag() {
    DioUtils.instance.requestNetwork<GetAllMusic>(
        Method.get, Api.GETMUSICLISTBYTAG,
        queryParameters: {"tagId": widget.tagId},
        isList: true, onSuccessList: (data) {
      setState(() {
        getTagMusicList = data;
        isShowLoading = false;
      });
    }, onError: (code, msg) {
      Toast.show('请求失败！');
    });
  }

  @override
  Widget build(BuildContext context) {
    return isShowLoading
        ? LoadingWidget.childWidget()
        : getTagMusicList.isEmpty
            ? Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Text('暂无数据'),
              )
            : Container(
                padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                color: Colors.white,
                child: GridView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: getTagMusicList.length,
                    //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                        crossAxisCount: 2,
                        //纵轴间距
                        mainAxisSpacing: 0.0,
                        //横轴间距
                        crossAxisSpacing: 15.0,
                        //子组件宽高长度比例
                        childAspectRatio: 0.70
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      //Widget Function(BuildContext context, int index)
                      return _buildItem(index);
                    }));
  }

  _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        Router.push(context, Router.musicListPage, getTagMusicList[index]);
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
                      getTagMusicList[index].image,
                      height: 140,
                      width: 140,
                      fit: BoxFit.fill,
                    ),
                  )),
              SizedBox(
                height: 8,
              ),
              Text(getTagMusicList[index].name, style: TextStyle(fontSize: 14),  overflow: TextOverflow.ellipsis,),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.headset,
                    size: 12,
                    color: Colors.black26,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '2038',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
