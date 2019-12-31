import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/search_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/consultation_detail_page.dart';
import 'package:flutter_first/pages/consultation/psyCenter/center_detail_page.dart';
import 'package:flutter_first/pages/home/home_widgets/course/course_detail_page.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/first.dart';
import 'package:flutter_first/pages/home/home_widgets/music_list_page.dart';
import 'package:flutter_first/pages/service/servicenext/activity.dart';
import 'package:flutter_first/pages/service/servicenext/activity_list2.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/widgets/search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SesrchPage extends StatefulWidget {
  String model;
  String hintText;
  SesrchPage(this.model, this.hintText);

  @override
  _SesrchPageState createState() => _SesrchPageState();
}

class _SesrchPageState extends State<SesrchPage> with TickerProviderStateMixin {
  TextEditingController _SearchController = TextEditingController();
  var textList = new List<String>();
  var numb = 1;
  var tabText = ['音乐', '心理课程', '活动参与', '资讯文章'];
  List<Widget> tabs = [];
  List<Widget> tabViews = List<Widget>();
  List<SearchContent> searchList = List();
  bool isSearch = false;
  TabController _tabController;

  Widget searchHistoryWidget() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                '搜索历史',
                style: TextStyle(fontSize: 16),
              )),
              GestureDetector(
                  onTap: () async {
                    setState(() {
                      textList.removeRange(0, textList.length);
                    });
                    await StorageManager.sharedPreferences
                        .remove(Constant.searchHistory);
                  },
                  child: Text(
                    '清空',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: List.generate(
                textList.length,
                (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          print('列表数1：$textList');
                          _SearchController.text = textList[index];
                          _search(_SearchController.text);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 12, right: 12, top: 3, bottom: 3),
                        child: Text(textList[index]),
                        decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(18)),
                      ),
                    )),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: searchList.length, vsync: this);
    if (StorageManager.sharedPreferences
            .getStringList(Constant.searchHistory) !=
        null) {
      textList = StorageManager.sharedPreferences
          .getStringList(Constant.searchHistory);
    }
  }

  _search(String keyword) {
    DioUtils.instance.requestNetwork<SearchContent>(
      Method.get,
      Api.SEARCH,
      isList: true,
      queryParameters: {
        "model": widget.model,
        'keyword': keyword,
        'pageNumber': numb,
        'pageSize': 20,
      },
      onSuccessList: (data) {
        setState(() {
          searchList = data;
          _tabController =
              TabController(length: searchList.length, vsync: this);
          isSearch = true;
          print('搜索成功!');
        });
      },
      onError: (code, msg) {
        print('搜索失败！');
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: SearchTextFieldWidget(
          isborder: true,
          onSubmitted: (text) async {
            setState(() {
              print('搜索:${_SearchController.text}');
              _search(_SearchController.text);
              textList.insert(0, text);
            });
            await StorageManager.sharedPreferences
                .setStringList(Constant.searchHistory, textList);
          },
          controller: _SearchController,
          hintText: widget.hintText,
          onTab: () {},
        ),
      ),
      body: isSearch
          ? searchList.isEmpty
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text('暂无搜索结果'),
                )
              : (widget.model == '*'
                  ? Container(
        color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          TabBar(
                            isScrollable: true,
                            controller: _tabController,
                            labelPadding: EdgeInsets.only(
                                left: 8, right: 8, bottom: 5, top: 5),
                            indicatorColor: Color(0xff2CA687),
                            labelColor: Color(0xff2CA687),
                            indicatorSize: TabBarIndicatorSize.label,
                            unselectedLabelColor: Color(0xff666666),
                            unselectedLabelStyle: TextStyle(fontSize: 14),
                            labelStyle: TextStyle(fontSize: 14.0),
                            tabs: searchList.map((value) {
                              return Text(value.modelName);
                            }).toList(),
                          ),
                          Expanded(
                              child: TabBarView(
                                  controller: _tabController,
                                  children: searchList.map((value) {
                                    return SearchTabView(
                                        value, _SearchController.text);
                                  }).toList())),
                        ],
                      ),
                    )
                  : SearchTabView(searchList[0], _SearchController.text))
          : searchHistoryWidget(),
      resizeToAvoidBottomPadding: false,
    );
  }
}

class SearchTabView extends StatefulWidget {
  SearchContent searchContent;
  String inputText;

  @override
  _SearchTabViewState createState() => _SearchTabViewState();

  SearchTabView(this.searchContent, this.inputText);
}

class _SearchTabViewState extends State<SearchTabView> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var numb = 2;

  @override
  void initState() {}

  @override
  void dispose() {
    _refreshController.dispose();
  }

  _refreshContent() {
    DioUtils.instance.requestNetwork<SearchContent>(
      Method.get,
      Api.SEARCH,
      isList: true,
      queryParameters: {
        "model": widget.searchContent.model,
        'keyword': widget.inputText,
        'pageNumber': numb,
        'pageSize': 20,
      },
      onSuccessList: (data) {
        if (data == null || data.length == 0) {
          _refreshController.loadNoData();
        } else {
          numb++;
          _refreshController.loadComplete();
        }
        setState(() {
          widget.searchContent.list.addAll(data[0].list);
          _refreshController.refreshCompleted();
          print('搜索成功!');
        });
      },
      onError: (code, msg) {
        _refreshController.refreshFailed();
        _refreshController.loadFailed();
        print('搜索失败！');
      },
    );
  }

  void _onRefresh() async {
//    Toast.show('这是下拉刷新操作');
    if (widget.searchContent.list == null ||
        widget.searchContent.list.length == 0) {
      _refreshContent();
    } else {
      _refreshController.refreshCompleted();
    }
  }

  void _onLoading() async {
    _refreshController.requestLoading();
//    Toast.show('这是上拉加载操作');
    _refreshContent();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
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
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.searchContent.list.length,
          itemBuilder: (context, index) =>
              _buildItem(widget.searchContent.list[index]),
        ),
      ),
    );
  }

  _buildItem(ListContent listContent) {
    return GestureDetector(
      onTap: () {
        if (widget.searchContent.model == 'article') {
          NavigatorUtil.pushPage(
              context,
              ConsultationDetailPage(
                id: listContent.id,
                imgurl: listContent.image,
              ));
        } else if (widget.searchContent.model == 'activity') {
          NavigatorUtil.pushPage(
              context, ServiceActivityPage(activityId: listContent.id));
        } else if (widget.searchContent.model == 'song') {
        } else if (widget.searchContent.model == 'musicList') {
          NavigatorUtil.pushPage(
              context,
              MusicListPage(
                  listContent.id, listContent.image, listContent.title));
        } else if (widget.searchContent.model == 'psyCourse') {
          NavigatorUtil.pushPage(
              context,
              CourseDetailPage(
                courseId: listContent.id,
              ));
        } else if (widget.searchContent.model == 'psyCoReading') {
          NavigatorUtil.pushWebView(
              context,
              'https://www.aireading.club/phms_resource_base/psyReading/XinLiXueWZ_CZ2.html',
              {"title": listContent.title});
        } else if (widget.searchContent.model == 'psyDailyTest') {
          NavigatorUtil.pushPage(
              context,
              Test0(
                questionnaireId: listContent.id,
              ));
        } else if (widget.searchContent.model == 'psyServiceCenter') {
          NavigatorUtil.pushPage(
              context,
              PsyCenterDetail(
                id: listContent.id,
              ));
        }
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              listContent.image ??
                  'http://jyj.jl.gov.cn/tpxw/201903/W020190318527359045201.jpg',
              height: 50,
              width: 50,
              fit: BoxFit.fill,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              listContent.title,
            )),
          ],
        ),
      ),
    );
  }
}
