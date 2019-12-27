import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/pages/service/servicenext/activity_list2.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/widgets/search.dart';

class SesrchPage extends StatefulWidget {
  bool isAll;
  String hintText;
  SesrchPage(this.isAll,this.hintText);

  @override
  _SesrchPageState createState() => _SesrchPageState();


}

class _SesrchPageState extends State<SesrchPage> {
  TextEditingController _SearchController = TextEditingController();
  var textList = new List<String>();
  bool isSearch = false;

  Widget childWidget() {
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
                (index) => Container(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 3, bottom: 3),
                      child: Text(textList[index]),
                      decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(18)),
                    )),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    if (StorageManager.sharedPreferences
            .getStringList(Constant.searchHistory) !=
        null) {
      textList = StorageManager.sharedPreferences
          .getStringList(Constant.searchHistory);
    }
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
              isSearch = true;
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
      body: isSearch?(widget.isAll?SearchChildWidget():SearchContent()):childWidget(),
    );
  }
}

class SearchChildWidget extends StatefulWidget {
  @override
  _SearchChildWidgetState createState() => _SearchChildWidgetState();
}

class _SearchChildWidgetState extends State<SearchChildWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var tabText = ['音乐', '心理课程', '活动参与'];
  List<Widget> tabs = [];
  List<Widget> tabViews = [];

  @override
  void initState() {
    _tabController = TabController(length: tabText.length, vsync: this);
    tabText.forEach((item) {
      tabs.add(Text(item));
    });
    tabText.forEach((item) {
      tabViews.add(SearchContent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TabBar(
            isScrollable: true,
            controller: _tabController,
            labelPadding: EdgeInsets.only(left: 8, right: 8, bottom: 5, top: 5),
            indicatorColor: Color(0xff2CA687),
            labelColor: Color(0xff2CA687),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Color(0xff666666),
            unselectedLabelStyle: TextStyle(fontSize: 14),
            labelStyle: TextStyle(fontSize: 14.0),
            tabs: tabs,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: tabViews))
        ],
      ),
    );
  }
}

class SearchContent extends StatefulWidget {
  @override
  _SearchContentState createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('你好'),
    );
  }
}
