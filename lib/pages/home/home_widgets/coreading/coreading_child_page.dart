import 'package:flutter/material.dart';
import 'package:flutter_first/bean/CoreadingLike.dart';
import 'package:flutter_first/bean/coreading.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoreadingChild extends StatefulWidget {
  String Kind;

  CoreadingChild({Key key, @required this.Kind})
      : super(key: key);
  @override
  _CoreadingChildState createState() => _CoreadingChildState();
}

class _CoreadingChildState extends State<CoreadingChild> {
  List<CoReading> list = List();
  bool isShowLoading = true;

  @override
  void initState() {
    _requestCoreading();
  }

  void _requestCoreading() {
    DioUtils.instance.requestNetwork<CoReading>(Method.get,
        widget.Kind==''? Api.CoReading:Api.CoReadingKind,
        queryParameters: {'categoryId': widget.Kind},
        isList: true, onSuccessList: (data) {
          setState(() {
            list = data;
             isShowLoading = false;

          });
        }, onError: (code, msg) {
          print("sssss");
        });
  }
  _getCoreadingLike(String id ) {
    DioUtils.instance
        .requestNetwork<CoreadingLike>(Method.get,
        Api.CoReadingLike,
        queryParameters: {
          'id': id,
        },
        isList: true, onSuccessList: (data) {
          setState(() {

          });
        }, onError: (code, msg) {
          setState(() {
          });
        });
  }
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return isShowLoading
        ? LoadingWidget.childWidget()
        : (list.length == 0)
        ? Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Text('暂无数据'),
    )
        :ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context , index){
          return InkWell(
            child: Container(
              height: ScreenUtil().setHeight(25),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(23.5, 20, 15, 42.5),
                            color: Color(0xFFFFCDD2),
                          ),
                          Positioned(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(15, 33, 28, 20),
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage(list[index].coverImgId),fit: BoxFit.fill)
                                ),
                              ))
                        ],
                      )
                  ),
                  Expanded(flex: 2,child:
                  Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 23,),
                      Text(list[index].name,style: TextStyle(fontSize: 18),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          Icon(Icons.star,color: Color(0xffFF9935),size: 18,),
                          Text('${list[index].learnedUserCount}人在读',style: TextStyle(color:  Color(0xffFF9935))),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                        child: Text(list[index].shortDesc,style: TextStyle(color: Color(0xff919191),fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      ),

                    ],
                  ),),

                ],
              ),
            ),
            onTap: (){
              _getCoreadingLike(list[index].id);
              NavigatorUtil.pushWebView(context, list[index].detailDesc, {"title":list[index].shortDesc});

            },
          );
        });
  }
}
