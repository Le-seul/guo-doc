import 'package:flutter/material.dart';
import 'package:flutter_first/util/date_utils.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/selected_text.dart';
import 'dart:math' as math;

class MovementClockPage extends StatefulWidget {
  @override
  _MovementClockPageState createState() => _MovementClockPageState();
}

class _MovementClockPageState extends State<MovementClockPage>  with SingleTickerProviderStateMixin {
  var value;
  List<DateTime> _currentMonthsDays;
  bool _isExpanded = false;
  // 月视图中选择的日期
  DateTime _selectedDay;
  DateTime _initialDay;

  @override
  void initState() {
    _initialDay = DateTime.now();
    _selectedDay = _initialDay;
    _currentMonthsDays = DateUtils.daysInMonth(_initialDay);
    _tabController = TabController(length: items.length, vsync: this);
  }


  List<DropdownMenuItem> getListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem;
    for (int i = 1; i <= 12; i++) {
      dropdownMenuItem = new DropdownMenuItem(
        child: new Text('2019年0$i月'),
        value: '$i',
      );
      items.add(dropdownMenuItem);
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          '饮食记录',
          style: new TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Center(
                  child: new DropdownButtonHideUnderline(
                    child: new DropdownButton(
                      items: getListData(),
                      hint:
                      new Text("2019年${_initialDay.month}月"), //当没有默认值的时候可以设置的提示
                      value: value, //下拉菜单选择完之后显示给用户的值
                      onChanged: (T) {
                        //下拉菜单item点击之后的回调
                        setState(() {
                          value = T;
                        });
                      },
                      style: new TextStyle(
                        //设置文本框里面文字的样式
                          color: Colors.black),
                      //              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                      iconSize: 20.0, //设置三角标icon的大小
                    ),
                  )),
              Flexible(
                child: Container(
                  color: Color(0xFFFAFAFA),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AnimatedCrossFade(
                        firstChild: _buildGridView(),
                        secondChild: _buildGridView(),
                        firstCurve: const Interval(0.0, 0.0,
                            curve: Curves.fastOutSlowIn),
                        secondCurve: const Interval(0.0, 0.0,
                            curve: Curves.fastOutSlowIn),
                        sizeCurve: Curves.decelerate,
                        crossFadeState: _isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Container(
                          height: 27.0,
                          alignment: Alignment.topCenter,
                          child: Icon(_isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black12,
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemExtent: 76.0,
                  itemBuilder: (context, index) => _buildItem(index),
                ),
              ),
              Container(
                height: 430,
                child: DefaultTabController(
                    length: items.length,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          child: _TabBarWidget(),
                          alignment: Alignment.center,
                        ),
                        _tabView()
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _tabView() {
    return Expanded(
      child: TabBarView(
        children: [
          _getlist(),
          _getlist(),
          _getlist(),
          _getlist(),
          _getlist(),
        ],
        controller: _tabController,
      ),
    );
  }

  _getlist(){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      itemExtent: 76.0,
      itemBuilder: (context, index) => _getItem(index),
    );
  }

  _getItem(int index){
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('快跑' ),
          Text('30分钟/175大卡'),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.black54,
            height: 1,
          )
        ],
      ),
    );
  }


  _buildItem(int index) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 8),
      child: MyCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 12.0,),
                child:  CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(
                      'assets/images/instructor_demeanor.png'),
                  backgroundColor: Colors.white,
                ),
              ),
              Expanded(
                  child:Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Align(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[Text('早餐'), Text('建议摄入422大卡')],
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  )
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: null,
              )
            ],
          )),
    );
  }

  _buildGridView() {
    return GridView.count(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 7,
      children: _builderCalendar(),
    );
  }

  List<Widget> _builderCalendar() {
    List<Widget> dayWidgets = [];
    List<DateTime> list;
    if (_isExpanded) {
      list = _currentMonthsDays;
    } else {
      list = DateUtils.daysInWeek(_selectedDay);
    }
//    dayWidgets.addAll(_buildWeeks());
    list.forEach((day) {
      dayWidgets.add(Container(
        alignment: Alignment.center,
        child: SelectedText(
          day.day < 10 ? "0${day.day}" : day.day.toString(),
          selected: (day.day == _selectedDay.day &&
              !DateUtils.isExtraDay(day, _initialDay)),
          // 不是本月的日期与超过当前日期的不可点击
          enable: day.day <= _initialDay.day &&
              !DateUtils.isExtraDay(day, _initialDay),
          onTap: () {
            setState(() {
              _selectedDay = day;
            });
          },
        ),
      ));
    });
    return dayWidgets;
  }
}
class _TabBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabBarWidgetState();
}

TabController _tabController;

class _TabBarWidgetState extends State<_TabBarWidget> {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;
  List<Widget> tabWidgets;

  @override
  void initState() {
    super.initState();
    selectColor = Colors.blue;
    unselectedColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 15, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 15, color: selectColor);
    tabWidgets = items.map((ItemView item) {//迭代添加选项卡按钮子项
      //选项卡按钮由文本及图标组成
      return Tab(
        text: item.title,
        icon: Icon(item.icon),
      );
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    if (_tabController != null) {
      _tabController.dispose();
    }
  }

  
  
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabWidgets,
      isScrollable: true,
      indicatorColor: selectColor,
      labelColor: selectColor,
      labelStyle: selectStyle,
      unselectedLabelColor: unselectedColor,
      unselectedLabelStyle: unselectedStyle,
      indicatorSize: TabBarIndicatorSize.tab,
      controller: _tabController,
    );
  }
}

//Widget ItemView(IconData icon,String title){
//    return Expanded(
//      child:Column(
//        children: <Widget>[
//          Icon(icon,size: 20,),
//          Text(title,maxLines: 1,)
//        ],
//      ),
//    );
//  }

//List<Widget> ItemViews = [
//  ItemView(Icons.star,'常用'),
//  ItemView(Icons.directions_walk,'走路跑步'),
//  ItemView(Icons.tonality,'球类运动'),
//  ItemView(Icons.shopping_basket,'日常生活'),
//  ItemView(Icons.directions_bike,'户外运动'),
//];
class ItemView {
  const ItemView({ this.title, this.icon });//构造方法 传入标题及图标
  final String title;//标题
  final IconData icon;//图标
}

//选项卡的类目
const List<ItemView> items = const <ItemView>[
  const ItemView(title: '自驾', icon: Icons.directions_car),
  const ItemView(title: '自行车', icon: Icons.directions_bike),
  const ItemView(title: '轮船', icon: Icons.directions_boat),
  const ItemView(title: '公交车', icon: Icons.directions_bus),
  const ItemView(title: '步行', icon: Icons.directions_walk),
];