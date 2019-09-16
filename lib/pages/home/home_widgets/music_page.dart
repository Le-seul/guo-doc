import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';



class MusicPage extends StatefulWidget {

  String tagId;
  int num;
  MusicPage({Key key, @required this.num,this.tagId}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  List<GetAllMusic> GetAllMusicList = List();


  @override
  void initState() {
    if(widget.num == 0){
      _getAllMusicList();
    }else if(widget.num == 1){
      _getMusicListByTag();
    }

  }

  _getMusicListByTag(){
    DioUtils.instance.requestNetwork<GetAllMusic>(
        Method.get,
        Api.GETMUSICLISTBYTAG,
        queryParameters: {"tagId": widget.tagId},
        isList: true,
        onSuccessList: (data) {
          setState(() {
            GetAllMusicList = data;
          });

        },
        onError: (code, msg) {
          Toast.show('请求失败！');
        });
  }

  _getAllMusicList(){
    DioUtils.instance.requestNetwork<GetAllMusic>(
        Method.get,
        Api.GETAllMUSICLIST,
        queryParameters: {"pageSize": 1, "pageNumber": 1},
        isList: true,
        onSuccessList: (data) {
          setState(() {
            GetAllMusicList = data;
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
            '音乐',
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Router.pushNoParams(context, Router.musicSortPage);
                },
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.only(left: 10),
                  height: 30,
                  width: 80,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '分类',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right,
                          size: 30,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1),
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
              Flexible(
                flex: 1,
                child: GridView.builder(
                    itemCount: GetAllMusicList.length,
                    //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //横轴元素个数
                        crossAxisCount: 2,
                        //纵轴间距
                        mainAxisSpacing: 10.0,
                        //横轴间距
                        crossAxisSpacing: 5.0,
                        //子组件宽高长度比例
                        childAspectRatio: 0.8),
                    itemBuilder: (BuildContext context, int index) {
                      //Widget Function(BuildContext context, int index)
                      return getItemContainer(index);
                    }),
              )
            ],
          ),
        ));
  }

  getItemContainer(int index) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Router.push(context, Router.musicListPage,GetAllMusicList[index].id);
        },
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.network(
                GetAllMusicList[index].image,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(GetAllMusicList[index].name)
          ],
        ),
      ),
    );
  }
}
