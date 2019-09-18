import 'package:flutter/material.dart';
import 'package:flutter_first/bean/psydailytest.dart';
import 'package:flutter_first/bean/togetheread.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/widgets/loading_widget.dart';


class EverydayTest extends StatefulWidget {
  @override
  _EverydayTestState createState() => _EverydayTestState();
}

class _EverydayTestState extends State<EverydayTest> with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    //生命周期函数,固定写法
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('每日一测'),
        centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(text: '全部',),
              Tab(text: '已测',),
            ],
          ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          All(),
          Selected(),
        ],
      ),
    );
  }
}
class All extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  List<PsyDailyTest> psylist = List();
  List<PsyDailyTest> Alllist = List();

  bool isShowLoading = true;

  @override
  void initState() {
    //生命周期函数,固定写法
    _requestData();
  }
  void _requestData() {
    DioUtils.instance.requestNetwork<PsyDailyTest>(
        Method.get,
        Api.PsyDailyTest,
        isList: true,
        onSuccessList: (data) {
          setState(() {
            psylist = data;
            isShowLoading = false;
            for (PsyDailyTest item in psylist){

                if(item.state == 1){
                  Alllist.add(item);
                  continue;
                }

            }
          });
        },
        onError: (code, msg) {
          print("sssss");
        });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : (Alllist.length == 0 )
          ? Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('暂无数据'),
      )
          :ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: Alllist.length,
        itemBuilder: (context , index){
          return InkWell(
            onTap:null,
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 5,10, 5),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 180,
                    child: Image.network(
                      Alllist[index].coverImgId,fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(Alllist[index].title,style: TextStyle(fontSize: 20),),
                  SizedBox(
                    height: 10,
                  ),
                  Text(Alllist[index].shortDesc+'丨'+Alllist[index].questionCount+'个问题',style: TextStyle(fontSize: 10,color: Colors.black45),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Selected extends StatefulWidget {
  @override
  _SelectedState createState() => _SelectedState();
}

class _SelectedState extends State<Selected> {
  bool _checkboxSelected1=false;
  bool _checkboxSelected2=false;
  bool _checkboxSelected3=false;
  bool _checkboxSelected4=false;
  bool _checkboxSelected5=false;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
