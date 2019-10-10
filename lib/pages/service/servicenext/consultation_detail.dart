import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_detail_entity.dart';
import 'package:flutter_first/widgets/my_card.dart';

class PsychologicalDetailPage extends StatefulWidget {
  @override
  _PsychologicalDetailPageState createState() =>
      _PsychologicalDetailPageState();
}

class _PsychologicalDetailPageState extends State<PsychologicalDetailPage> {
  List<PsychologicalDetail> consultationDetailList = List(5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          '心理咨询',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: MyCard(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                          width: 80,
                          height: 80,
                          child: MyCard(child: Image.network(
                            'http://b-ssl.duitang.com/uploads/item/201712/22/20171222223729_d8HCB.jpeg',
                            fit: BoxFit.fill,
                          ),)
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('张警官'),
                          Text('预约日期：2019-8-8',style: TextStyle(color: Colors.black12),),
                          Text('预约地点：808分区服务中心',style: TextStyle(color: Colors.black12)),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(height: 2,color: Colors.white12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Image.asset('assets/images/mine/体检报告.png',height: 15,),
                            Text('   压力测试',style: TextStyle(fontSize: 13),)
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text('咨询师:张医师 ',style: TextStyle(fontSize: 13),),
                            ClipOval(child: Image.network('http://pic2.52pk.com/files/140801/4682170_094640_5_lit.jpg',height: 25,),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: MyCard(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics:NeverScrollableScrollPhysics(),
                    itemCount: consultationDetailList.length,
                    itemBuilder:(BuildContext context,int index){
                      return Container(
                          height: 110,
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 5.0),
                          padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  'https://fc3tn.baidu.com/it/u=2699607471,95220664&fm=202&src=add_wise_exp',
                                  height: 90,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: Align(
                                            child: Text('经常失眠，工作状态不好，很多工作无法完成'),
                                            alignment: Alignment.topLeft,
                                          ),
                                        ),
                                        Expanded(
                                            child: Align(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text('2018-06-23'),
                                                  Text('已结束'),
                                                ],
                                              ),
                                              alignment: Alignment.bottomLeft,
                                            ))
                                      ],
                                    ),
                                  )),
                              Icon(
                                Icons.chevron_right,
                                size: 30,
                              ),
                            ],
                          ));
                    }
                )),
          )
        ],
      )
    );
  }


}
