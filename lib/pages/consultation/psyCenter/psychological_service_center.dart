import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_center_entity.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_first/util/toast.dart';

var numb = 0;

class PsychologicalServiceCenterPage extends StatefulWidget {
  PsychologicalServiceCenterPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PsychologicalServiceCenterPageState();
  }
}
class _PsychologicalServiceCenterPageState extends State<PsychologicalServiceCenterPage> {
  List<ServiceCenter> list = List();
  List<ServiceCenter> tmplist;

  @override
  void initState() {
    super.initState();
    _requestAPI();

  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  void _requestAPI() async{
//    var _request= MockRequest();
    var result=await MockRequest().get('servicecenter',params: {'pageNume':numb});
    var resultList= result['information'];
    tmplist = resultList.map<ServiceCenter>((item) => ServiceCenter.fromMap(item)).toList();
    list.addAll(tmplist);
    setState(() {
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _refreshController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: containerBody(),
    );
  }

  Widget containerBody() {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black,),
        title: Text('心理服务分中心',style: new TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w600,),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: Colours.line,
        child: Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white
          ),

          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      ((BuildContext context, int index) {
                        return getCommonItem(list, index);
                      }), childCount: list.length)),
            ],
          ),
        ),
      )
    );
  }

  getCommonItem(List<ServiceCenter> items, int index) {
    ServiceCenter item = items[index];
    bool showThree = (index+1) % 4 == 0;
    return GestureDetector(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 10,),
                  Image.asset('assets/images/consultation/定位.png',
                    height: 25,
                    fit: BoxFit.fitHeight,
                  ),
                  Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          child:  Text(
                            item.name,
                            softWrap: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      )
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                  )
                ],
              ),
              Container(
                height: 1,
                width: 300,
                color: Colors.black12,
              )
            ],
          )
       ,
      onTap: () {
        Router.pushNoParams(context, Router.center_detail);
      },

    );
  }
}
