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
        appBar: PreferredSize(
            child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Text('音乐',style: TextStyle(color: Colors.black),),
                flexibleSpace: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.0,top: 10.0),
                      child:SearchTextFieldWidget(
                        hintText: '请输入搜索内容',
                        margin: const EdgeInsets.only(
                            left: 15.0, right: 15.0),
                        onTab: () {},
                      ),
                    )
                )
            ),
            preferredSize: Size.fromHeight(90)),
        body: Container(

              child:Container(
                padding: EdgeInsets.only(top: 10,right: 10,left: 10),
                  decoration: new BoxDecoration(
                    //背景
                    color: Colors.white,
                    //设置四周圆角 角度
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),topRight: Radius.circular(8.0)),
                    //设置四周边框
                    border: new Border.all(width: 1, color: Colors.white),
                  ),
                height: double.infinity,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: GetAllMusicList.length,
                  itemBuilder: (context, index) => _buildItem(index),),
              ),


          color: Color(0xFFEEEEEE),
          padding: EdgeInsets.only(left: 15,right: 15,top: 15),
        ));
  }

  _buildItem(int index) {
    return GestureDetector(
      onTap: (){
        Router.push(context, Router.musicListPage, GetAllMusicList[index]);
      },
      child:Container(
          height: 105,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),child:Image.network(
                        GetAllMusicList[index].image,
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
                              Text(GetAllMusicList[index].name,style: TextStyle(fontSize: 18)),

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
              Container(
                height: 1,
                color: Color(0xFFEEEEEE),
              )
            ],
          )),
    );
  }
}
