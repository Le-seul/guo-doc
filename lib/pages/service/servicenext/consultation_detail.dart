import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_detail_entity.dart';

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
      body: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: consultationDetailList.length,
        itemBuilder: (context, index) => _buildItem(index),
      ),
    );
  }

  _buildItem(int index) {
    PsychologicalDetail item = consultationDetailList[index];
    return index == 0 ? consultationDetail(item) : consultationList(item);
  }

  consultationDetail(PsychologicalDetail item) {
    return GestureDetector(
        child: Container(
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
                    child: Image.network(
                      'http://b-ssl.duitang.com/uploads/item/201712/22/20171222223729_d8HCB.jpeg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('张警官'),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('预约日期：2019-8-8 上午8：00',style: TextStyle(color: Colors.black12),),
                      Text('预约地点：808分区服务中心',style: TextStyle(color: Colors.black12)),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text('安排咨询师：'),
                  SizedBox(
                    width: 20,
                  ),
                  ClipOval( //圆形头像
                      child: new Image.network(
                        'https://cdn.duitang.com/uploads/item/201608/25/20160825214118_nMzNT.thumb.700_0.jpeg',
                        width: 50,
                        height: 70,
                        fit: BoxFit.fill,
                      ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('张医生'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Text('状态：线上申请'),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.description,color: Colors.blue,),
                        SizedBox(
                          width: 10,
                        ),
                        Text('点击进行压力测试'),
                      ],
                    ),
                  )

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 2,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
    ));
  }

  consultationList(PsychologicalDetail item) {
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
}
