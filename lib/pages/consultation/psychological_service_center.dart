import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_center_entity.dart';
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
        color: const Color.fromARGB(255, 247, 247, 247),
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
      )
    );
  }

  getCommonItem(List<ServiceCenter> items, int index) {
    ServiceCenter item = items[index];
    bool showThree = (index+1) % 4 == 0;
    return GestureDetector(
      child: Container(
          height: 60,
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 5.0),
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset('assets/images/police.jpg',
                height: 60,
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
          )
      ) ,
      onTap: () {
        Router.push(context, 'https://baike.sogou.com/v63254446.htm?fromTitle=%E8%AD%A6%E5%AF%9F%E5%BF%83%E7%90%86%E5%81%A5%E5%BA%B7%E5%8F%8A%E5%85%B6%E7%BB%B4%E6%8A%A4', {'title': '民警心理健康'});
      },

    );
  }
}
