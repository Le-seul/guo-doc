import 'package:flutter/material.dart';
import 'package:flutter_first/bean/doctorInfo.dart';
import 'package:flutter_first/bean/evaluation.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/greenBgWidget.dart';
import 'package:flutter_first/widgets/my_card.dart';

class EvaluationPage extends StatefulWidget {
  DoctorInfo doctorInfo;
  String orderId;
  EvaluationPage({Key key, @required this.orderId,@required this.doctorInfo}) : super(key: key);
  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage>
    with SingleTickerProviderStateMixin {
  TabController mController;
  TextEditingController _contentController = TextEditingController();
  List<Evaluation> badList = List();
  List<Evaluation> goodList = List();
  List<Evaluation> bestList = List();
  String level = 'bad';
  var tag_keys = [];
  var evaluationInfo ;

  @override
  void initState() {
    super.initState();


    badList.add(Evaluation('不友好',1101));
    badList.add(Evaluation('不细致',1102));
    badList.add(Evaluation('等好久没回复',1201));
    badList.add(Evaluation('完全听不懂',1301));
    badList.add(Evaluation('感觉不专业',1302));
    badList.add(Evaluation('没有帮助',1303));
    goodList.add(Evaluation('希望更热情',2101));
    goodList.add(Evaluation('希望更细致',2102));
    goodList.add(Evaluation('希望回复更快',2201));
    goodList.add(Evaluation('希望更透彻',2301));
    bestList.add(Evaluation('态度非常好',3101));
    bestList.add(Evaluation('非常清楚',3102));
    bestList.add(Evaluation('回复很及时',3201));
    bestList.add(Evaluation('非常专业认真',3301));
    bestList.add(Evaluation('意见很有帮助',3302));
    bestList.add(Evaluation('非常敬业',3303));


    mController = TabController(
      length: 3,
      vsync: this,
    );

    //TabBar监听器
    mController.addListener(() => _onTabChanged());
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  _onTabChanged() {


    if (mController.indexIsChanging) {


      if (this.mounted) {
        this.setState(() {
          tag_keys = [];
          switch (mController.index) {
            case 0:
              setState(() {
                level = 'bad';

                for(Evaluation evaluation in goodList){
                  evaluation.isSelect = false;
                }
                for(Evaluation evaluation in bestList){
                  evaluation.isSelect = false;
                }
              });

              break;
            case 1:
              setState(() {

                level = 'good';
                for(Evaluation evaluation in badList){
                  evaluation.isSelect = false;
                }
                for(Evaluation evaluation in bestList){
                  evaluation.isSelect = false;
                }
              });

              break;
            case 2:
              setState(() {

                level = 'best';
                for(Evaluation evaluation in goodList){
                  evaluation.isSelect = false;
                }
                for(Evaluation evaluation in badList){
                  evaluation.isSelect = false;
                }
              });

              break;
          }
        });
      }
    }
  }
  postAccessInfo(String accessInfo){
    if(_contentController.text == null || _contentController.text == ""){
      Toast.show('请输入评价内容！');
    }else{
      String content = "[{\"type\":\"text\",\"text\":\"${_contentController.text}\"}]";
      DioUtils.instance.requestNetwork<String>(
          Method.post, Api.POSTACCESSINFO,
          queryParameters: {"assessInfo": accessInfo, "content": content,"orderId": widget.orderId},
          onSuccess: (data) {
            Toast.show('评价成功！');
          }, onError: (code, msg) {
        Toast.show('评价失败！');
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '评价本次服务',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Center(
                  child: Text(
                    '提交',
                    style: TextStyle(color: Colors.black),
                  ),
                )),
            onTap: () {
              evaluationInfo = {"level": level, "tag_keys":tag_keys.toString()};

              String assessInfo = evaluationInfo.toString();
              print('assessInfo:$assessInfo');
              postAccessInfo(assessInfo);
            },
          )
        ],
      ),
      body: Container(

        color: Color(0xFFEEEEEE),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Router.pushNoParams(context, Router.doctorPage);
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:  NetworkImage(widget.doctorInfo.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              widget.doctorInfo.name,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.doctorInfo.clinic,
                              style: TextStyle(color: Colors.black26),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.doctorInfo.title,
                              style: TextStyle(color: Colors.black26),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            GreenBgWidget(
                              name: widget.doctorInfo.levelTitle,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GreenBgWidget(name: '快速回复'),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: MyCard(
                child: Container(
                  height: MediaQuery.of(context).size.height*11/16,
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '您对医生的服务满意吗？',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: Colors.white,
                          height: 80,
                          child: Container(
                            child: TabBar(
                              isScrollable: false,
                              //是否可以滚动
                              controller: mController,
                              indicator: const BoxDecoration(),
                              labelColor: Colors.orange,
                              unselectedLabelColor: Color(0xff666666),
                              labelStyle: TextStyle(fontSize: 16.0),
                              tabs: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.sentiment_dissatisfied,
                                      size: 40,
                                    ),
                                    SizedBox(height: 8,),
                                    Text('不满意'),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.sentiment_neutral,
                                      size: 40,),
                                    SizedBox(height: 8,),
                                    Text('一般'),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Icon(Icons.sentiment_satisfied,
                                      size: 40,),
                                    SizedBox(height: 8,),
                                    Text('满意'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 80,
                          child: TabBarView(
                            controller: mController,
                            children: <Widget>[
                              _buildWidget(badList),
                              _buildWidget(goodList),
                              _buildWidget(bestList),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 150,
                          color: Color(0xFFEEEEEE),
                          child: TextField(
                            controller: _contentController,
                              decoration: InputDecoration(
                                hintText: '您的满意是对医生最大的支持和鼓励。',
                                contentPadding: EdgeInsets.all(5.0),
                                border: InputBorder.none,
                              )
                          ),
                        ),
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }


  _buildWidget(List<Evaluation> list) {
    return GridView.builder(
        itemCount: list.length,
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 3,
            //纵轴间距
            mainAxisSpacing: 10.0,
            //横轴间距
            crossAxisSpacing: 10.0,
            //子组件宽高长度比例
            childAspectRatio: 3.0),
        itemBuilder: (context, index) => _buildItem(list[index]),
    );
  }

  _buildItem(Evaluation evaluation){


    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
              color: evaluation.isSelect?Colors.orange[100]:Colors.white,
              border: Border.all(color: evaluation.isSelect?Colors.orange[100]:Color(0xFFDDDDDD), width: 1),
              borderRadius: BorderRadius.circular(3)),
          child: Center(
            child: Text(
              evaluation.text,
              style: TextStyle(color: evaluation.isSelect?Colors.orange:Color(0xff666666)),
            ),
          )),
      onTap: (){
        setState(() {

          evaluation.isSelect = !evaluation.isSelect;
          if(evaluation.isSelect){
            tag_keys.add(evaluation.num);
          }
        });

      },
    );
  }
}
