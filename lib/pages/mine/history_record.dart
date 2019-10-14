import 'package:flutter/material.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/my_card.dart';
class HistoryRecord extends StatefulWidget {
  @override
  _HistoryRecordState createState() => _HistoryRecordState();
}

class _HistoryRecordState extends State<HistoryRecord> with SingleTickerProviderStateMixin {

  TabController mController;


  @override
  void initState() {
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
      appBar: PreferredSize(
          child:AppBar(
            iconTheme: null,
            backgroundColor: Colors.white,
            title: Container(
              height: 38,
             decoration: BoxDecoration(

            border: Border.all(color: Color(0xff2CA687), width: 1),
              borderRadius: BorderRadius.circular(5)),

              child: TabBar(
                isScrollable: true,
                //是否可以滚动
                controller: mController,

                labelStyle: TextStyle(fontSize: 16.0),
                tabs: <Widget>[
                  Text('当前咨询',style: TextStyle(color: Colors.black),),
                  Text('历史纪录',style: TextStyle(color: Colors.black)),
                ],
              ),

            ),
          ),
          preferredSize: Size.fromHeight(40)),

      body: TabBarView(
          controller: mController,
          children: <Widget>[
            _getList(),
            _getList()
          ],
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

    return GestureDetector(
      onTap: (){
        Router.pushNoParams(context, Router.talk);
      },
      child: Container(
        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
        child: MyCard(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage('assets/images/beijing2.jpg'),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('春雨儿科专家团',style: TextStyle(fontSize: 16),),
                    SizedBox(height: 10,),
                    Text('10月09日 上午10：30 | 儿科',style: TextStyle(color: Colors.black26),),
                  ],)
              ],
            ),
          ),
        ),

      ),);
  }
}
