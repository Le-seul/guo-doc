import 'package:flutter/material.dart';
import 'package:flutter_first/bean/step_ranking.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepRanking extends StatefulWidget {
  @override
  _StepRankingState createState() => _StepRankingState();
}

class _StepRankingState extends State<StepRanking> {
  List<Stepranking> steplist = List();
  List<Stepranking> Rankinglist = List();

  void initState() {
    _requestAPI();

  }
  void _requestAPI() async{
//    var _request= MockRequest();
    var result=await MockRequest().getNoParams('step');
    var resultList= result['step'];
    steplist = resultList.map<Stepranking>((item) => Stepranking.fromMap(item)).toList();
    //list.addAll(steplist);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return Scaffold(
      backgroundColor: Colours.line,
      appBar: AppBar(
        title: Text('步数排行',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black,size: 32),
        actions: <Widget>[
          Container(child: Image.asset('assets/images/mine/rank/fenxiang.png',height: 10,),
            padding: EdgeInsets.all(15),
          ),
          SizedBox(width: ScreenUtil().setWidth(4),)
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: ListView.builder(
          itemCount: 11,
          itemBuilder:(BuildContext context,int index){
            return _buildItem(index);
          } ,
        ),
      ),

    );
  }
}
_buildItem(int index) {
  Widget itemWidget;
  String num;

  if (index < 9) {
    num = "0" + "${index + 1}";
  } else {
    num = "${index + 1}";
  }
  if (index == 0) {
    itemWidget = Container(
      child: loadAssetImage('mine/rank/排行 1.png', height: 40),
      padding: EdgeInsets.fromLTRB(10,10,10,10),
    );
  } else if (index == 1) {
    itemWidget = Container(
      child: loadAssetImage('mine/rank/排行 2.png', height: 40),
      padding: EdgeInsets.fromLTRB(10,10,10,10),
    );
  } else if (index == 2) {
    itemWidget = Container(
      child: loadAssetImage('mine/rank/排行 3.png', height: 40),
      padding: EdgeInsets.fromLTRB(10,10,10,10),
    );
  } else {
    itemWidget = Container(
      height: 25,
      child: CircleAvatar(
        backgroundColor: Colors.black12,
        radius: 10,
        child: Text(
          num,
          style: TextStyle(fontSize: 17, color: Colors.black54),
        ),
      ),
    );
  }
  return GestureDetector(
    onTap: () {
    },
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
      height: ScreenUtil().setHeight(11),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(flex: 2,child: itemWidget,),
          Expanded(flex: 2,child: Container(
            padding: EdgeInsets.all(5),
            child: ClipOval(
              child: Image.network('https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2080823830,3911438045&fm=26&gp=0.jpg'),
            ),
          )),
          Expanded(flex: 6,child: Text('  张警官'),),
          Expanded(flex: 3,child: Container(
            child: Row(
              children: <Widget>[
                loadAssetImage('mine/脚印.png',height: 20),
                Text('  20000',style: TextStyle(color: Colors.red),)
              ],
            ),
          ),),
        ],
      ),
      ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 1,
            color: Colours.line,
          ),
        ],
      ),

  );
}