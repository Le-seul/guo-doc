import 'package:flutter/material.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';


class ServiceActivity extends StatefulWidget {

  bool offstage = true;
  @override
  _ServiceActivityState createState() => _ServiceActivityState();

  ServiceActivity({Key key, @required this.offstage}): super(key: key);
}

class _ServiceActivityState extends State<ServiceActivity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text('活动',style: TextStyle(color: Colors.black),),
          centerTitle: true,
        ),
        body: Container(
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child:Image.network('http://s.114study.com/images/admin_xly_upload/upload/xly/big/20180408181106136040.jpg',
                    height: 180,
                    fit: BoxFit.fill,
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('活动时间: 2019.07.15  -  2019.08.20',style: TextStyle(fontSize: 16),),
                        SizedBox(height: 10,),
                        Text('活动地点: 808心理服务分中心',style: TextStyle(fontSize: 16),),
                        SizedBox(height: 10,),
                        Text('报名人数: 30人   先到先得',style: TextStyle(fontSize: 16),),
                      ],
                    ),

                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.people),
                    Text("1人已报名    ")
                  ],
                ),
                SizedBox(height: 10,),
                Offstage(
                  offstage: widget.offstage,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 2,
                        child: Container(
                          color: Colors.grey[200],
                        ),
                      ),
                      Container(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: false,
                          itemCount: 4,
                          itemBuilder: (context, index) => _childItem(index),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                        child: Container(
                          color: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) => _buildItem(index),
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                  padding: EdgeInsets.only(left: 10,right: 30,top: 10,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('活动满意度调查问卷，点击前往'),
                      Icon(Icons.dashboard,color: Colors.green,)
                    ],),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.0 ,right: 30.0),
                  child: FlatButton(
                    onPressed: (){
                      Toast.show('报名成功!');
                    },
                    color: Colors.orange,
                    child: Text('报名',style: TextStyle(color: Colors.white),),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

                  ),
                )

              ],
            ),

        )
    );
  }
  _childItem(int index) {
    return GestureDetector(
      onTap: (){
        Router.push(context, Router.serviceActivity,true);
      },
      child:Container(
        padding: EdgeInsets.only(left: 10,right:15,top: 10,bottom: 8),
        child: Column(
          children: <Widget>[
            Image.network('http://s.114study.com/images/admin_xly_upload/upload/xly/big/20180408181106136040.jpg',
              height: 80,
              width: 120,) ,
            Text('808分中心活动')
          ],
        ),
      ),
    );
  }
  _buildItem(int index) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
      margin: EdgeInsets.only(left: 10,right:10,top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('808分中心活动',style: TextStyle(fontSize: 15),),
          Image.network('http://s.114study.com/images/admin_xly_upload/upload/xly/big/20180408181106136040.jpg',
            height: 80,
            width: 120,)
        ],
      ),
    );
  }
}

