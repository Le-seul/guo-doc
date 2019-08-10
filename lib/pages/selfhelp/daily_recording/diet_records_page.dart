import 'package:flutter/material.dart';
import 'package:flutter_first/res/styles.dart';
import 'package:flutter_first/util/date_utils.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/selected_text.dart';

class DietRecordsPage extends StatefulWidget {
  @override
  _DietRecordsPageState createState() => _DietRecordsPageState();
}

class _DietRecordsPageState extends State<DietRecordsPage> {
  var value;
  List<DateTime> _currentMonthsDays;
  bool _isExpanded = false;
  // 月视图中选择的日期
  DateTime _selectedDay;
  DateTime _initialDay;
  static const List<String> _weeks = const [
    "周一",
    "周二",
    "周三",
    "周四",
    "周五",
    "周六",
    "周日"
  ];

  @override
  void initState() {
    _initialDay = DateTime.now();
    _selectedDay = _initialDay;
    _currentMonthsDays = DateUtils.daysInMonth(_initialDay);
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

  /*  _LearnDropdownButton(){
    value=getListData()[0].value;
  }*/

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
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemExtent: 76.0,
                  itemBuilder: (context, index) => _buildItem(index),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20,bottom: 20),
                alignment: Alignment.center,
                child:Column(
                  children: <Widget>[
                    Image.asset('assets/images/instructor_demeanor.png',height: 40,width: 40,),
                    Gaps.vGap5,
                    Text('三餐配比')
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemExtent: 76.0,
                  itemBuilder: (context, index) => _items(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _items(int index){
    return Container(
        child:Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Align(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('早餐(偏低)'),
                            Gaps.vGap8,
                            Container(
                              height: 5,
                              color: Colors.black12,

                            )

                          ]
                      ),
                      alignment: Alignment.centerLeft,
                    ),

                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('0大卡'),
                        Gaps.vGap8,
                        Text('推荐423大卡',style: TextStyle(color: Colors.black54),)],
                    ),
                    alignment: Alignment.centerRight,
                  ),

                ),
              ],
            ),
            Gaps.vGap10,
            Container(
              height: 1,
              color: Colors.black12,
            )
          ],
        )
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

  List<Widget> _buildWeeks() {
    List<Widget> widgets = [];
    _weeks.forEach((str) {
      widgets.add(Container(
        alignment: Alignment.center,
        child: Text(str, style: TextStyles.textGray12),
      ));
    });
    return widgets;
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
