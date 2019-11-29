import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/common_dio.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/consultation_detail_page.dart';
import 'package:flutter_first/pages/consultation/topic_page.dart';
import 'package:flutter_first/pages/home/home_widgets/music_page.dart';
import 'package:flutter_first/res/styles.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_first/pages/consultation/title_widget.dart';

class ChildPage extends StatefulWidget {
  bool offstage;
  String id;
  bool isTopic;
  ChildPage(this.offstage, this.id, this.isTopic, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChildPageState(offstage);
  }
}

class _ChildPageState extends State<ChildPage> {
  var numb = 1;
  String defaultImage =
      'https://www.aireading.club/phms_resource_base/image_base/BJ_YaJianKang_02.jpg';
  bool offstage;
  Widget titleWidget;
  List<ConsulationColumnsInfo> columnsInfoList = List();
  bool isShowLoading = true;
  _ChildPageState(this.offstage);

  @override
  void initState() {
    super.initState();
    titleWidget = Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: TitleWidget(),
    );
    if (widget.isTopic) {
      _getTopicList();
    } else {
      _getColumnsInfo();
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
//    Toast.show('这是下拉刷新操作');
    if (columnsInfoList == null || columnsInfoList.length == 0) {
      if (widget.isTopic) {
        _getTopicList();
      } else {
        _getColumnsInfo();
      }
    } else {
      _refreshController.refreshCompleted();
    }
  }

  void _onLoading() async {
    _refreshController.requestLoading();
//    Toast.show('这是上拉加载操作');
    if (widget.isTopic) {
      _getTopicList();
    } else {
      _getColumnsInfo();
    }
  }

  _getTopicList() {
    DioUtils.instance.requestNetwork<ConsulationColumnsInfo>(
      Method.get,
      Api.GETARTICLETOPIC,
      queryParameters: {"topicId": widget.id},
      isList: true,
      onSuccessList: (data) {
        if (data == null || data.length == 0) {
          _refreshController.loadNoData();
        } else {
          numb++;
          _refreshController.loadComplete();
        }
        setState(() {
          columnsInfoList.addAll(data);
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

  void _getColumnsInfo() {
    DioUtils.instance.requestNetwork<ConsulationColumnsInfo>(
      Method.get,
      Api.GETAllCOlUMNINFO,
      queryParameters: {
        "columnId": widget.id,
        "pageSize": 20,
        "pageNumber": numb
      },
      isList: true,
      onSuccessList: (data) {
        if (data == null || data.length == 0) {
          _refreshController.loadNoData();
        } else {
          numb++;
          _refreshController.loadComplete();
        }
        setState(() {
          columnsInfoList.addAll(data);
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
        : (columnsInfoList.length == 0 || columnsInfoList == null)
            ? Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Text('暂无数据'),
              )
            : SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
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
      color: const Color.fromARGB(255, 247, 247, 247),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Offstage(
              offstage: offstage,
              child: titleWidget,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  ((BuildContext context, int index) {
            return Column(
              children: <Widget>[
                
                getCommonItem(columnsInfoList, index)],
            );
          }), childCount: columnsInfoList.length)),
        ],
      ),
    );
  }

  getCommonItem(List<ConsulationColumnsInfo> items, int index) {
    ConsulationColumnsInfo item = items[index];
    bool showThree = (index + 1) % 4 == 0;
    return GestureDetector(
      child: (item.cover2 == null || item.cover3 == null)
          ? getContentItem(item)
          : getThreeImagItem(item),
      onTap: () {
        if (!widget.isTopic && item.type == 'T') {
          NavigatorUtil.pushPage(context, TopicPage(item.id));
          CommonRequest.UserReadingLog(item.id, item.type, 'DJ');
        } else {
          NavigatorUtil.pushPage(
              context,
              ConsultationDetailPage(
                id: item.id,
              ));
          CommonRequest.UserReadingLog(item.id, item.type, 'YD');
        }
      },
    );
  }

  getContentItem(ConsulationColumnsInfo item) {
    return Container(
        height: 93,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5.0),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(item.title,style: TextStyle(fontSize: 15,color: Colors.black87),strutStyle: StrutStyle(
                    height: 1.5
                  ),),
                 Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            '中国健康网',
                            style: TextStyle(color: Colors.grey,fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        item.type == "T"
                            ? Text('')
                            : Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/consultation/查看.png',
                                      height: 9,
                                    ),
                                    Text(' ${item.readCount}',
                                      style: TextStyle(color: Colors.grey,fontSize: 11),
                                    ),
                                    Gaps.hGap8,
                                    Image.asset(
                                      'assets/images/consultation/点赞.png',
                                      height: 11,
                                    ),
                                    Text(' ${item.likeCount}',
                                      style: TextStyle(color: Colors.grey,fontSize: 11),
                                    ),
                                    Gaps.hGap8,
                                    Image.asset(
                                      'assets/images/consultation/分享.png',
                                      height: 11,
                                      color: Colors.grey,
                                    ),
                                    Text(' ${item.transmitCount}',
                                      style: TextStyle(color: Colors.grey,fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),

                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Image.network(
                  item.cover1 ?? defaultImage,
                  height: 90,
                  fit: BoxFit.fill,
                ),
              )
            )
          ],
        ));
  }

  getThreeImagItem(ConsulationColumnsInfo item) {
    return Container(
        height: 120,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5.0),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(item.title),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Image.network(
                    item.cover1 ?? defaultImage,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    item.cover2 ?? defaultImage,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    item.cover3 ?? defaultImage,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )
          ],
        ));
  }
}
