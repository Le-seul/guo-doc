import 'package:flutter/material.dart';
import 'package:flutter_first/pages/mine/graphic_consultation_page.dart';
import 'package:flutter_first/pages/mine/tel_consultation_page.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/search.dart';
class Consultation extends StatefulWidget {
  @override
  _ConsultationState createState() => _ConsultationState();
}

class _ConsultationState extends State<Consultation> {

  String title = '图文咨询';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
              actions: <Widget>[
                new IconButton(
                  icon: Icon(Icons.add, size: 30.0,color: Colors.green,),
                  onPressed: () {
                    if(_tabIndex == 0){
                      Router.pushNoParams(context, Router.graphicConsultation);
                    }else{
                      Router.pushNoParams(context, Router.telConsultation);
                    }


                  },
                )
              ],
              automaticallyImplyLeading: false,
              title: Text(title,style: TextStyle(color: Colors.black),),
              flexibleSpace: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.0,top: 10.0),
                  child:SearchTextFieldWidget(
                    isborder: true,
                    hintText: '请输入搜索内容',
                    margin: const EdgeInsets.only(
                        left: 15.0, right: 15.0),
                    onTab: () {},
                  ),
                )
              )
          ),
          preferredSize: Size.fromHeight(90)),
      body: _bodys[_tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: getTabIcon(0), title: getTabTitle(0)),
          new BottomNavigationBarItem(
              icon: getTabIcon(1), title: getTabTitle(1)),
        ],
        //设置显示的模式
        type: BottomNavigationBarType.fixed,
        //设置当前的索引
        currentIndex: _tabIndex,
        //tabBottom的点击监听
        onTap: (index) {
          setState(() {
            title = appBarTitles[index];
            _tabIndex = index;
          });
        },
      ),
    );
  }
  Image getTabImage(path) {
    return loadAssetImage(path, width: 25.0, height: 25.0);
  }
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['图文咨询', '电话咨询'];
  var _bodys;

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: const Color(0xff63ca6c)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: const Color(0xff888888)));
    }
  }

  void initData() {
    /*
      bottom的按压图片
     */
    tabImages = [
      [
        getTabImage('menu_zx0.png'),
        getTabImage('menu_zx1.png')
      ],
      [
        getTabImage('menu_dh0.png'),
        getTabImage('menu_dh1.png')
      ],
    ];

    _bodys = [
      new GraphicConsultationPage(),
      new TelConsultationPage(),
    ];
  }

  @override
  void initState() {
    initData();
  }
}
