import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_activity_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {

  List<ServiceActivity> serviceActivityList;

  @override
  void initState() {
    _requestActivity();
  }

 void _requestActivity() {
   DioUtils.instance.requestNetwork<ServiceActivity>(
       Method.get,
       Api.GETACTIVITIES,
       queryParameters: {"columnId": 1, "pageSize": 1, "pageNumber": 1},
       isList: true,
       onSuccessList: (data) {
         setState(() {
           serviceActivityList = data;
         });

       },
       onError: (code, msg) {
       });
 }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.black54,
              height: 23,
              alignment: Alignment.center,
              child: Text(
                '服务',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ), //服务
            SizedBox(
              height: 9,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
            Container(
              height: 30,
              child: Row(
                children: <Widget>[
                  Text('  心灵之约'),
                  SizedBox(
                    width: 75,
                  ),
                  Container(
                    width: 80,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/images/jiahao.png',
                              color: Colors.grey),
                          Text(
                            '发起咨询',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ), //发起咨询
                  Container(
                    width: 80,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/dianhua.png',
                            color: Colors.black54,
                          ),
                          Text(
                            '咨询热线',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ), //咨询热线
                  Container(
                    width: 60,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: (Text(
                        '更多',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )),
                      onPressed: () {},
                    ),
                  ) //更多
                ],
              ),
            ), //心灵之约
            SizedBox(
              height: 2,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Image.network(
                      'http://image.uczzd.cn/793049627461073302.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '2018年全局高位冠心病患者越来越多',
                              style: TextStyle(fontSize: 15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '       2019-06-23',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black26),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '等待审核',
                                  style: TextStyle(color: Colors.green),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                  Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ), // 新闻一
            SizedBox(
              height: 2,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Image.network(
                      'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=445686649,1913530531&fm=26&gp=0.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '经常失眠,工作不好,这可咋整啊!',
                              style: TextStyle(fontSize: 15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '       2019-06-23',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black26),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '已结束',
                                  style: TextStyle(color: Colors.black54),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                  Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ), //新闻二
            SizedBox(
              height: 9,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
            Container(
              height: 30,
              child: Row(
                children: <Widget>[
                  Text('  健康咨询'),
                  SizedBox(
                    width: 115,
                  ),
                  Container(
                    width: 90,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/jiahao.png',
                            color: Colors.blue,
                          ),
                          Text(
                            '发起咨询',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        Router.pushNoParams(
                            context, Router.healthyconsultation);
                      },
                    ),
                  ), //发起咨询
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 60,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: (Text(
                        '更多',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )),
                      onPressed: () {},
                    ),
                  ) //更多
                ],
              ),
            ), //健康咨询
            SizedBox(
              height: 2,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Image.network(
                      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1565148151&di=61e65806b8e90b29b3c5a722b06f1bb6&imgtype=jpg&er=1&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn17%2F300%2Fw600h500%2F20180427%2F1a85-fzrwiaz0412254.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    child: Center(
                      child: Icon(
                        Icons.brightness_1,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '最近总是便秘,怎么解决?',
                              style: TextStyle(fontSize: 15),
                              softWrap: false,
                            ),
                            Text(
                              '早起喝一杯凉白开,做深深的蹲坑运动',
                              style: TextStyle(fontSize: 15, color: Colors.red),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '       2019-06-23',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black26),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '等待审核',
                                  style: TextStyle(color: Colors.green),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                  Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ), // 新闻一
            SizedBox(
              height: 2,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Image.network(
                      'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564553493056&di=1598d39733d59a1b20eb0e605f6301f3&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_70%2Cc_zoom%2Cw_640%2Fimages%2F20180618%2F82502d45499248f481417604fc2206fc.jpeg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '舌苔发黄,很厚,食欲不振,口气贼大',
                              style: TextStyle(fontSize: 15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '       2019-06-23',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black26),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '已结束',
                                  style: TextStyle(color: Colors.black54),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                  Expanded(flex: 1, child: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ), //新闻二
            SizedBox(
              height: 9,
              child: Container(
                color: Colors.grey[200],
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 10),
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('活动参与'),
                  Container(
                    width: 60,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: (Text(
                        '更多',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )),
                      onPressed: () {},
                    ),
                  ) //更多
                ],
              ),
            ),
            SizedBox(
              height: 2,
              child: Container(
                color: Colors.grey[200],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: serviceActivityList.length,
                itemBuilder: (context, index) => _buildItem(index),
              ),
            ),

            //活动参与
          ],
        ),
      ),
    );
  }


  _buildItem(int index) {
    return GestureDetector(
        onTap: () {
          Router.push(context, Router.serviceActivity,false);
        },
        child: Container(
          margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: index == 0 ? 0 : 2,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: Image.network(
                  serviceActivityList[index].cover,
                  height: 150,
                  fit: BoxFit.fill,
                ),
                width: double.infinity,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    serviceActivityList[index].name,
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  SizedBox(
                    width: 8
                  ),
                  Text(
                    '${serviceActivityList[index].signInCount}人报名',
                    style: TextStyle(color: Colors.black26, fontSize: 11,
                    ),
                  ),
                  Text(
                    '${serviceActivityList[index].signInCount}人参加',
                    style: TextStyle(color: Colors.black26, fontSize: 11),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 2.0,right: 2.0,top: 1.0, bottom: 1.0),
                    child: Text('进行中',
                      style: TextStyle(fontSize: 8, color: Colors.green),),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }




}