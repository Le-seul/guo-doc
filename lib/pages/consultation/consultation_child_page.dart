import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/styles.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_first/pages/consultation/title_widget.dart';

class ChildPage extends StatefulWidget {
  bool offstage;
  ChildPage(this.offstage, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChildPageState(offstage);
  }
}

class _ChildPageState extends State<ChildPage> {
  var numb = 1;
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
    _getColumnsInfo();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    Toast.show('这是下拉刷新操作');
    if(columnsInfoList == null||columnsInfoList.length == 0){
      _getColumnsInfo();
    }else{
      _refreshController.refreshCompleted();
    }

  }

  void _onLoading() async {
    _refreshController.requestLoading();
    Toast.show('这是上拉加载操作');
    _getColumnsInfo();
  }

  void _getColumnsInfo() {
    DioUtils.instance.requestNetwork<ConsulationColumnsInfo>(
      Method.get,
      Api.GETAllCOlUMNINFO,
      queryParameters: {"columnId": 1, "pageSize":3, "pageNumber": 1},
      isList: true,
      onSuccessList: (data) {
        if (data == null||data.length == 0) {
          _refreshController.loadNoData();
        }else{
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
            return getCommonItem(columnsInfoList, index);
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
        if (item.type == 'T') {
          Router.push(context, Router.topicPage, true);
        } else {
          Router.push(context, Router.consulationDetailPage, item);
        }
      },
    );
  }

  getContentItem(ConsulationColumnsInfo item) {
    return Container(
        height: 120,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5.0),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      child: Text(item.title),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Expanded(
                      child: Align(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            item.description,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        item.type == "T"?Container():Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Image.asset('assets/images/consultation/查看.png',height: 10,),
                              Text('${item.readCount}'),
                              Gaps.hGap8,
                              Image.asset('assets/images/consultation/点赞.png',height: 12,),
                              Text('${item.likeCount}'),
                              Gaps.hGap8,
                              Image.asset('assets/images/consultation/分享.png',height: 12,),
                              Text('${item.transmitCount}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    alignment: Alignment.bottomLeft,
                  ))
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.network(
                item.cover1,
                height: 90,
                fit: BoxFit.fitHeight,
              ),
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
                    item.cover1,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    item.cover2,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    item.cover3,
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
