import 'package:flutter/material.dart';
import 'package:flutter_first/bean/CoreadingCatelog.dart';
import 'package:flutter_first/bean/CoreadingDetail.dart';
import 'package:flutter_first/bean/coreading.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dio/dio.dart';

class contentcatalog {

  var title;
  var subtitle1;
  var subtitle2;
  var date1;
  var date2;


  contentcatalog.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    subtitle2 = map['subtitle2'];
    subtitle1 = map['subtitle1'];
    date2 = map['date2'];
    date1 = map['date1'];

  }
}


class SimpleReading extends StatefulWidget {
  @override
  _SimpleReadingState createState() => _SimpleReadingState();
}

class _SimpleReadingState extends State<SimpleReading> {

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
  List<CoReading> Togethereadinglist = List();
  List<CoReading> Imagelist = List();
  bool isShowLoading = true;
  String Detailurl;


  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _requestImage();
    _requestCoreadingDetail();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  void _requestCoreadingDetail() async {
    Dio dio =Dio();
    Response response =await dio.get("http://ygyd.aireading.top/jeecg/api/psyCoreading.do?getPsyCoReadingDetail&id=1");
    setState(() {
      Detailurl = response.toString();
    });

  }
  void _requestImage() {
    DioUtils.instance.requestNetwork<CoReading>(
        Method.get,
        Api.CoReading,
        isList: true,
        onSuccessList: (data) {
          setState(() {
            Togethereadinglist = data;
            isShowLoading = false;
            for (CoReading item in Togethereadinglist){
              for ( int i = 0;i<=Togethereadinglist.length;i++){

              }
            }
          });
        },
        onError: (code, msg) {
          print("sssss");
        });
  }
  @override
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
          title: new Text('简单共读',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          centerTitle: true, // 标题居中
          expandedHeight: 200.0, // 展开高度
          floating: true, // 随着滑动隐藏标题
          pinned: true, // 固定在顶部
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            background:  Container(
              margin: new EdgeInsets.only(top: kToolbarHeight),
              child:isShowLoading
                  ? LoadingWidget.childWidget()
                  : (Imagelist.length == 0)
                  ? Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Text('暂无数据'),
              )
                  : Image.network(Imagelist[0].coverImgId,fit: BoxFit.fill,),
            ),
          ),
        ),
        new SliverPersistentHeader(
          delegate: _SilverAppBarDelegate(TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            controller: _tabController,
            tabs: <Widget>[
              new Tab(
                text: "共读介绍",
              ),
              new Tab(
                text: "内容目录",
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

                Detailurl == null?LoadingWidget.childWidget():Detail(Detailurl: Detailurl,),
                Catalog(),

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

class Detail extends StatefulWidget {
  String Detailurl;
  Detail({Key key, @required this.Detailurl, }): super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.Detailurl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}




class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<CoreadingCatelog> Cateloglist = List();

  void initState(){
    _requestCoreadingCatelog();
  }
  void _requestCoreadingCatelog() {
    DioUtils.instance.requestNetwork<CoreadingCatelog>(
        Method.get,
        Api.CoReadingCatalog,
        isList: true,
        onSuccessList: (data) {
          setState(() {
            Cateloglist = data;
          });
        },
        onError: (code, msg) {
          print("sssss");
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
          children: <Widget>[
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('注意',style: TextStyle(fontWeight:FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(
              height: 2,
              width: 320,
              child: Container(color: Colors.black12,),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              height: 50,
              child: Row(
                children: <Widget>[
                  Image.asset('assets/images/书.png',height: 20,width: 20,),
                  Text('  购买必读')
                ],
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: Cateloglist.length,
              itemBuilder: (context,index) => _firstbuilderitem(index),
            )
          ]
    );

  }
  _firstbuilderitem(int index){
    return Column(
      children: <Widget>[
        Container(
          height: 9,
          width: 320,
          color: Colors.black12,
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(Cateloglist[index].categoryLevel1,style: TextStyle(fontWeight:FontWeight.w600),),
            ],
          ),
        ),
        SizedBox(
          height: 2,
          width: 320,
          child: Container(color: Colors.black12,),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: Cateloglist[index].categoryLevel.length,
          itemBuilder: (context,index1)=> _secondbuilderitem(index,index1),
        )
      ],
    );
  }
  _secondbuilderitem(int index,int index1){
    return Column(
      children: <Widget>[
        InkWell(
          child: Container(
            padding:EdgeInsets.only(left: 20) ,
            height: 60,
            child: Row(
              children: <Widget>[
                Image.asset(Cateloglist[index].categoryLevel[index1].state==1?"assets/images/试听.png":"assets/images/未购买.png",height: 20,width: 20,color: Colors.grey,),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Cateloglist[index].categoryLevel[index1].chapterName,style: TextStyle(fontSize: 16),),
                    Text(Cateloglist[index].categoryLevel[index1].createTime.split(' ')[0].split('-')[1],style: TextStyle(fontSize: 12,color: Colors.grey),)
                  ],
                ),
              ],
            ),
          ),
          onTap: (){
            Cateloglist[index].categoryLevel[index1].state==1?Router.push(context, Cateloglist[index].categoryLevel[index1].detailDesc, {'title':'课程'}):null;
          },
        ),
        SizedBox(
          height: 2,
          width: 320,
          child: Container(color: Colors.black12,),
        ),
      ],
    );
  }
}

