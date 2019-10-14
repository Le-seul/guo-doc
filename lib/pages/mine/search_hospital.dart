import 'package:flutter/material.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:flutter_first/widgets/search.dart';

class SearchHospital extends StatefulWidget {
  @override
  _SearchHospitalState createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital>
    with SingleTickerProviderStateMixin {
  TabController mController;

  @override
  void initState() {
    super.initState();

    mController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '找医院',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.8,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.share, size: 20.0,color: Colors.black,),
            onPressed: () {
            },
          )
        ],
      ),
      body: Container(
        color: Color(0xffF9F9F9),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            SearchTextFieldWidget(
              isborder: true,
              hintText: '请输入搜索内容',
              margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              onTab: () {},
            ),
            Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: MyCard(
                      child: Column(
                    children: <Widget>[
                      Container(
                        height: 38,
                        child: TabBar(
                          isScrollable: false,
                          //是否可以滚动
                          controller: mController,
                          indicatorColor: Colors.white,
                          labelColor: Colors.red,
                          unselectedLabelColor: Color(0xff666666),
                          labelStyle: TextStyle(fontSize: 16.0),
                          tabs: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('全国'),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('综合'),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: mController,
                          children: <Widget>[
                            _getList(),
                            _getList(),
                          ],
                        ),
                      )
                    ],
                  )),
                ))
          ],
        ),
      ),
    );
  }

  _getList() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => _buildItem(index),
    );
  }

  _buildItem(int index) {
    String num;
    if(index<9){
      num = "0"+"${index+1}";
    }else{
      num = "${index+1}";
    }

    return GestureDetector(
      onTap: (){
        Router.pushNoParams(context,Router.searchHospitalDetail);
      },
      child: Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Container(
            height: 1,
            color: Colors.black26,
          ),
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.black12,
                  radius: 15,
                  child: Text(
                    num,
                    style: TextStyle(fontSize: 20,color: Colors.black54),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '北京协和医院',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '全国综合排名第一',
                        style: TextStyle(color: Colors.black26),
                      ),
                    ],
                  ),
                ),
                Text('北京东城区', style: TextStyle(color: Colors.black26)),
              ],
            ),
          )
        ],
      ),
    ),);
  }
}
