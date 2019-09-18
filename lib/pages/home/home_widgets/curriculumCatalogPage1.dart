import 'package:flutter/material.dart';
import 'package:flutter_first/bean/coursedetail.dart';
import 'package:flutter_first/bean/psycourse.dart';
import 'package:flutter_first/bean/psycoursecatelog.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
class curriculumcatalog {

  var permission;
  var title;


  curriculumcatalog.fromMap(Map<String, dynamic> map) {
    permission = map['permission'];
    title = map['title'];

  }
}


class CurriculumCatalog1 extends StatefulWidget {

  @override
  _CurriculumCatalog1State createState() => _CurriculumCatalog1State();
}

class _CurriculumCatalog1State extends State<CurriculumCatalog1> {
  void initState(){


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:MyRewardPage() ,
    );
  }

}


class MyRewardPage extends StatefulWidget {
  MyRewardPage({Key key}) : super(key: key);

  @override
  _MyRewardPageState createState() => new _MyRewardPageState();
}

class _MyRewardPageState extends State<MyRewardPage>
    with TickerProviderStateMixin {
  TabController _tabController;
List<Coursedetail> coursedetaillist;
List<Psycoursecatelog> psycoursecateloglist;
  bool isShowLoading1 = true;
  bool isShowLoading2 = true;
  String Detailurl;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
//    _requestCoursedetail();
    _requestPsycoursecatelog();
    http.get('http://10.28.195.109:8080/jeecg/api/psycourse.do?getCouserDetail').then((response){
      Detailurl = response.toString();
    });
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  void _requestPsycoursecatelog() {
    DioUtils.instance.requestNetwork<Psycoursecatelog>(
        Method.get,
        Api.PSYCOURSECATELOG,
        isList: true,
        onSuccessList: (data) {
          setState(() {
            psycoursecateloglist = data;
            isShowLoading1 = false;
          });

        },
        onError: (code, msg) {
          print("sssss");
        });
  }
//  void _requestCoursedetail() {
//    DioUtils.instance.requestNetwork<Coursedetail>(
//        Method.get,
//        Api.COURSEDETAIL1,
//        isList: true,
//        onSuccessList: (data) {
//          setState(() {
//            coursedetaillist = data;
//            isShowLoading2 = false;
//          });
//
//        },
//        onError: (code, msg) {
//          print("sssss");
//        });
//  }
  Widget build(BuildContext context) {
    List<Widget> _silverBuilder(BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          leading: new GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child:Icon(Icons.chevron_left,color: Colors.black,)
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: new Text('心理学装腔指南',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          centerTitle: true, // 标题居中
          expandedHeight: 200.0, // 展开高度
          floating: true, // 随着滑动隐藏标题
          pinned: true, // 固定在顶部
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            background: new Container(
              margin: new EdgeInsets.only(top: kToolbarHeight),
              child: Image.asset('assets/images/tu1.jpg',fit: BoxFit.fill,),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite_border),
            ),
            IconButton(
              icon: Icon(Icons.speaker_notes),
            ),
          ],
        ),
        new SliverPersistentHeader(
          delegate: _SilverAppBarDelegate(TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            controller: _tabController,
            tabs: <Widget>[
              new Tab(
                text: "课程详情",
              ),
              new Tab(
                text: "课程目录",
              ),
            ],
          )),
        ),
      ];
    }

    return new Scaffold(
      body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: _silverBuilder,
            body: new TabBarView(
              controller: _tabController,
              children: <Widget>[
                isShowLoading1? LoadingWidget.childWidget()
                    : (Detailurl == null )
                    ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text('暂无数据'),
                )
                    :
                WebView(
                  initialUrl:Detailurl,
                ),
                isShowLoading2? LoadingWidget.childWidget()
                    : (psycoursecateloglist.length == 0 || psycoursecateloglist == null)
                    ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text('暂无数据'),
                )
                    :Catalog(),

              ],
            ),
          )),
    );
  }
}

class _SilverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SilverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class Catalog extends StatefulWidget {

  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Psycoursecatelog> psycoursecateloglist;
  void initState(){
    _requestPsycoursecatelog();
  }
  void _requestPsycoursecatelog() {
    DioUtils.instance.requestNetwork<Psycoursecatelog>(
        Method.get,
        Api.PSYCOURSECATELOG,
        isList: true,
        onSuccessList: (data) {
          setState(() {
            psycoursecateloglist = data;

          });

        },
        onError: (code, msg) {
          print("sssss");
        });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: <Widget>[
            Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(psycoursecateloglist[0].chapterName),
                  FlatButton(onPressed:(){},
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.file_download,color: Colors.blueAccent,),
                          Text('离线缓存',style: TextStyle(color: Colors.blueAccent),),
                        ],
                      ))
                ],
              ),
            ),
            ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: psycoursecateloglist.length,
              itemBuilder:(BuildContext context, int index){
                return  InkWell(
                  child: Container(
                    height: 45,
                    margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 1,child: IconButton(icon: Icon(Icons.play_circle_outline,color: Colors.grey,), onPressed: null), ),
                        Expanded(flex: 1,child: Image.asset(psycoursecateloglist[index].state==1?'assets/images/试听.png':'assets/images/未购买.png',height: 15,width: 15,) ),
                        Expanded(flex: 7,child: Text('  '+psycoursecateloglist[index].chapterName,style: TextStyle(fontSize: 15),), )
                      ],
                    ),
                  ),
                  onTap: (){},
                );
              } ,
            ),
          ]
      ),
    );
  }

}
