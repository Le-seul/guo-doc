import 'package:flutter/material.dart';
import 'package:flutter_first/bean/search_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/service/servicenext/activity_list2.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/widgets/search.dart';

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
        'pageNumber': 1,
        'pageSize': 20
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
                  child: Text('暂无数据'),
                )
              : (widget.model == '*'
                  ? Container(
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
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: TabBarView(
                                  controller: _tabController,
                                  children: _buildPages()))
                        ],
                      ),
                    )
                  : SearchTabView(searchList[0]))
          : searchHistoryWidget(),
    );
  }

  List<Widget> _buildPages() {
    List<Widget> pages = List();
    for (SearchContent searchContent in searchList) {
      Widget page = SearchTabView(searchContent);
      pages.add(page);
    }
    return pages;
  }
}

class SearchTabView extends StatefulWidget {
  SearchContent searchContent;

  @override
  _SearchTabViewState createState() => _SearchTabViewState();

  SearchTabView(this.searchContent);
}

class _SearchTabViewState extends State<SearchTabView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.searchContent.list.length,
        itemBuilder: (context, index) =>
            _buildItem(widget.searchContent.list[index]),
      ),
    );
  }

  _buildItem(ListContent listContent) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(listContent.title),
        ],
      ),
    );
  }
}
