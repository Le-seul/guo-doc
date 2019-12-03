import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_activity_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/service/servicenext/activity.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_first/widgets/my_card.dart';

class ActivityListPage extends StatefulWidget {
  @override
  _ActivityListPageState createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  List<ServiceActivity> serviceActivityList = List();
  bool isShowLoading = true;

  @override
  void initState() {
    _requestActivity();
  }

  void _requestActivity() {
    DioUtils.instance.requestNetwork<ServiceActivity>(
        Method.get,
        Api.GETACTIVITIES,
        queryParameters: {"pageSize": 1, "pageNumber": 1},
        isList: true,
        onSuccessList: (data) {
          setState(() {

            isShowLoading = false;
            serviceActivityList = data;
            print('活动详情请求成功！');
          });

        },
        onError: (code, msg) {

          Toast.show('活动详情请求失败！');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('活动列表'),
        elevation: 0.0,
        backgroundColor: Color(0xff2CA687),
        centerTitle: true,
      ),
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : serviceActivityList.isEmpty
          ? Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('暂无数据'),
      )
          : Container(
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: serviceActivityList.length,
          itemBuilder: (context, index) => _buildItem(serviceActivityList[index]),
        )
      ),
    );
  }
  _buildItem(ServiceActivity serviceActivity) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pushPage(context,ServiceActivityPage(offstage: true,activityId: serviceActivity.id));
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: MyCard(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      child: Image.network(serviceActivity.cover,fit: BoxFit.fill,),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Text(
                          serviceActivity.name,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          serviceActivity.name,
                          style: TextStyle(color: Colors.black26),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
