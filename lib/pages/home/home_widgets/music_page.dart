import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/home_widgets/music_tab_page.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';

class MusicPage extends StatefulWidget {
  String tagId;
  int num;
  MusicPage({Key key, @required this.num, this.tagId}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage>
    with SingleTickerProviderStateMixin {
  List<GetAllMusic> GetAllMusicList = List();
  List<MusicTag> musicTagList = List();
  List<Widget> tabs = [];
  List<Widget> tabViews = [];
  int tagNum = 1;

  TabController _tabController;
  @override
  void initState() {
    _getMusicTag();
//    if (widget.num == 0) {
//      _getAllMusicList();
//    } else if (widget.num == 1) {
//      _getMusicListByTag();
//    }
  }

  _getMusicTag() {
    DioUtils.instance.requestNetwork<MusicTag>(Method.get, Api.GETMUSICTAG,
        isList: true, onSuccessList: (data) {
      setState(() {
        tabs.add(Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          alignment: Alignment.center,
          child: Text('全部'),
        ));
        tabViews.add(MusicTabPage('0'));
        musicTagList = data;
        _tabController = TabController(length: data.length + 1, vsync: this);

        musicTagList.forEach((str) {
          tabs.add(Container(
            padding: EdgeInsets.only(left: 5, right: 5),
            alignment: Alignment.center,
            child: Text(str.name),
          ));
        });

        musicTagList.forEach((str) {
          tabViews.add(MusicTabPage(str.id));
        });
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
        elevation: 0.0,
        backgroundColor: Color(0xff2CA687),
        title: Text(
          '轻松音乐',
        ),
      ),
      body: _tabController == null
          ? LoadingWidget.childWidget()
          : Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  height: 35,
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    labelPadding: EdgeInsets.all(0.0),
                    indicatorColor: Color(0xff2CA687),
                    labelColor: Color(0xff2CA687),
                    unselectedLabelColor: Color(0xff666666),
                    unselectedLabelStyle: TextStyle(fontSize: 14),
                    labelStyle: TextStyle(fontSize: 14.0),
                    tabs: tabs,
                  ),
                ),
                Flexible(
                    child: TabBarView(
                        controller: _tabController, children: tabViews)),
              ],
            ),
    );
  }
}
