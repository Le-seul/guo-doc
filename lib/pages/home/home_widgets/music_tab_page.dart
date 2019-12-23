import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/common_dio.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/home_widgets/music_list_page.dart';
import 'package:flutter_first/res/styles.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_first/pages/consultation/title_widget.dart';

class MusicTabPage extends StatefulWidget {
  String tagId;

  MusicTabPage(this.tagId);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MusicTabPageState();
  }
}

class _MusicTabPageState extends State<MusicTabPage> {
  var numb = 1;
  List<GetAllMusic> getTagMusicList = List();
  List<ConsulationColumnsInfo> columnsInfoList = List();
  bool isShowLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.tagId == "0") {
      _getAllMusicList();
    } else {
      _getMusicListByTag();
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
//    Toast.show('这是下拉刷新操作');
    if (getTagMusicList == null || getTagMusicList.length == 0) {
      _getAllMusicList();
    } else {
      _refreshController.refreshCompleted();
    }
  }

  void _onLoading() async {
    _refreshController.requestLoading();
//    Toast.show('这是上拉加载操作');
    _getAllMusicList();
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

  _getAllMusicList() {
    DioUtils.instance.requestNetwork<GetAllMusic>(
      Method.get,
      Api.GETAllMUSICLIST,
      queryParameters: {"pageSize": 8, "pageNumber": numb},
      isList: true,
      onSuccessList: (data) {
        if (data == null || data.length == 0) {
          _refreshController.loadNoData();
        } else {
          numb++;
          _refreshController.loadComplete();
        }
        setState(() {
          getTagMusicList.addAll(data);
          isShowLoading = false;
          _refreshController.refreshCompleted();
        });
      },
      onError: (code, msg) {
        setState(() {
          _refreshController.refreshFailed();
          _refreshController.loadFailed();
          isShowLoading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isShowLoading
        ? LoadingWidget.childWidget()
        : (getTagMusicList.length == 0 || getTagMusicList == null)
            ? Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Text('暂无数据'),
              )
            : SmartRefresher(
                enablePullDown: widget.tagId == "0" ? true : false,
                enablePullUp: widget.tagId == "0" ? true : false,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("加载完成！");
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: containerBody(),
              );
  }

  Widget containerBody() {
    return Container(
        padding: EdgeInsets.only(top: 15, right: 15, left: 15),
        color: Colors.white,
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          slivers: <Widget>[
            SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //横轴元素个数
                    crossAxisCount: 2,
                    //纵轴间距
                    mainAxisSpacing: 0.0,
                    //横轴间距
                    crossAxisSpacing: 15.0,
                    //子组件宽高长度比例
                    childAspectRatio: 0.78),
                delegate: SliverChildBuilderDelegate(
                    ((BuildContext context, int index) {
                  return _buildItem(index);
                }), childCount: getTagMusicList.length)),
          ],
        ));
  }

  _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushPage(context,MusicListPage(allMusicList: getTagMusicList[index]));
        CommonRequest.UpdatePlayCount(getTagMusicList[index].id, 'musicList');

      },
      child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
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
                    Positioned(
                      top: 3.0,
                      left: 3.0,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Row(
                          children: <Widget>[
                            loadAssetImage('music/music_ear.png',height: 13,width: 13,color: Colors.white),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${getTagMusicList[index].playCount??0}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 10, right: 10),
                          child: loadAssetImage('music/music_play.png',height: 32,width: 32)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 13,
              ),
//              Container(
//                height: 15,
//                child: MarqueeWidget(
//                  ratioOfBlankToScreen: 0.1,
//                  text:  '《${getTagMusicList[index].name}》',
//                  textStyle: TextStyle(fontSize: 14),
//                  scrollAxis: Axis.horizontal,
//                ),
//              ),
              Text(
                '《${getTagMusicList[index].name}》',
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )),
    );
  }
}
