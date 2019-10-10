import 'package:flutter/material.dart';
import 'package:flutter_first/bean/coreading.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleCoreading extends StatefulWidget {
  @override
  _SimpleCoreadingState createState() => _SimpleCoreadingState();
}

class _SimpleCoreadingState extends State<SimpleCoreading> {
List<CoReading> Coreadinglist = List();
bool isShowLoading = true;
  void initState(){
    _requestImage();
  }

  void _requestImage() {
    DioUtils.instance.requestNetwork<CoReading>(
        Method.get,
        Api.CoReading,
        isList: true,
        onSuccessList: (data) {
          setState(() {
            Coreadinglist = data;
            isShowLoading = false;

            //Coreadinglist.sort();

          });
        },
        onError: (code, msg) {
          print("sssss");
        });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return Scaffold(
      backgroundColor: Colours.line,
      appBar: AppBar(
        title: Text('简单共读'),
          centerTitle: true,
      ),
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : (Coreadinglist.length == 0 )
          ? Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('暂无数据'),
      )
          :ListView(
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(43),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: InkWell(
                    child: Container(
                      child: Image.network(
                        Coreadinglist[0].coverImgId,
                        height: ScreenUtil().setHeight(36),
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: (){
                      Router.pushNoParams(context, Router.simplereading);
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: ScreenUtil().setWidth(5),
                  child: InkWell(
                    child: Image.network(
                      Coreadinglist[1].coverImgId,
                      height: 100,
                      width: 140,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(5),
          ),
          Container(
              child: Container(
                height: ScreenUtil().setHeight(46),
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5),0,ScreenUtil().setWidth(5),0),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            child: Image.network(
                              Coreadinglist[2].coverImgId,
                              fit: BoxFit.fill,
                            ),
                          )),
                      Expanded(
                          child: Row(
                            children: <Widget>[
//                              SizedBox(
//                                width: 14,
//                              ),
                              Expanded(
                                child: Container(
                                  child: Image.network(
                                    Coreadinglist[3].coverImgId,
                                  ),
                                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                ),
                                flex: 1,
                              ),
//                              SizedBox(
//                                width: 14,
//                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[Text(
                                          Coreadinglist[3].shortDesc,
                                          style: TextStyle(color: Colors.grey),)],
                                      ),
                                      flex: 5,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text('2019人正在读',style: TextStyle(color: Colors.grey),),
                                            flex: 6,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {},
                                                child: ClipRRect(
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        '现在加入',
                                                        style: TextStyle(fontSize: 14,color: Colors.white),
                                                      ),
                                                      color: Colors.red,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(6))),
                                            flex: 5,
                                          )
                                        ],
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                ),
                                flex: 2,
                              ),
//                              SizedBox(
//                                width: 14,
//                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius:BorderRadius.all(Radius.circular(10)),
                  color: Colors.white
                ),
              ),
            ) ,


        ],
      ),
    );
  }
}
