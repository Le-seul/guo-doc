import 'package:flutter/material.dart';
import 'package:flutter_first/bean/activity_detail_entity.dart';
import 'package:flutter_first/bean/service_activity_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';


class ServiceActivityPage extends StatefulWidget {

  bool offstage = true;
  ServiceActivity serviceActivity;
  @override
  _ServiceActivityPageState createState() => _ServiceActivityPageState();

  ServiceActivityPage({Key key, @required this.offstage,@required this.serviceActivity}): super(key: key);
}

class _ServiceActivityPageState extends State<ServiceActivityPage> {

  ActivityDetail activityDetail;

  @override
  void initState() {
    _getActivityDetail();
  }


  _getActivityDetail(){
    DioUtils.instance.requestNetwork<ActivityDetail>(
      Method.get,
      Api.GETACTIVITIEDETAIL,
      onSuccess: (data) {
        setState(() {
          activityDetail = data;
        });
      },
      onError: (code, msg) {
        setState(() {
          Toast.show('请求失败！');
        });
      },
    );
  }

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
                  child:Image.network(activityDetail.cover,
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
                        Text('活动时间: ${activityDetail.startTime}',style: TextStyle(fontSize: 16),),
                        SizedBox(height: 10,),
                        Text('活动地点: ${activityDetail.location}',style: TextStyle(fontSize: 16),),
                        SizedBox(height: 10,),
                        Text('报名人数: ${activityDetail.signInCount}人   先到先得',style: TextStyle(fontSize: 16),),
                      ],
                    ),

                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.people),
                    Text("${activityDetail.signInCount}人已报名    ")
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
        Router.push(context, Router.serviceActivityPage,{'offstage': true, 'serviceActivity': widget.serviceActivity});
      },
      child:Container(
        padding: EdgeInsets.only(left: 10,right:15,top: 10,bottom: 8),
        child: Column(
          children: <Widget>[
            Image.network(activityDetail.childActivity[0].cover,
              height: 80,
              width: 120,
              fit: BoxFit.fitHeight,) ,
            Text(activityDetail.childActivity[0].name)
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
          Text(activityDetail.name,style: TextStyle(fontSize: 15),),
          Image.network(activityDetail.cover,
            height: 80,
            width: 120,
            fit: BoxFit.fitHeight)
        ],
      ),
    );
  }

}

