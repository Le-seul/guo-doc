import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/consulation_detail_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_first/bean/health_adv.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_first/res/styles.dart';
import 'package:flutter_first/util/toast.dart';

//GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
//GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
//GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
var numb = 0;

class PhysiologyPage extends StatefulWidget {
  PhysiologyPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PhysiologyPageState();
  }
}

class _PhysiologyPageState extends State<PhysiologyPage> {
  List<HealthAdv> list = List();
  List<HealthAdv> tmplist;

  @override
  void initState() {
    super.initState();
    _requestAPI();

  }
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    if(list==null){
      numb=0;
      _requestAPI();
    }
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(numb<2){
      numb++;
      _requestAPI();
    }else{
      Toast.show("已加载完毕！");
    }
    _refreshController.loadComplete();
  }

  void _requestAPI() async{
//    var _request= MockRequest();
    var result=await MockRequest().get('Information',params: {'pageNume':numb});
    var resultList= result['information'];
    tmplist = resultList.map<HealthAdv>((item) => HealthAdv.fromMap(item)).toList();
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
    return new SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  Text("pull up load");
          }
          else if(mode==LoadStatus.loading){
            body =  CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = Text("Load Failed!Click retry!");
          }
          else{
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: containerBody(),

    );

  }

  Widget containerBody() {
    return Container(
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
    );
  }

  getCommonItem(List<HealthAdv> items, int index) {
    HealthAdv item = items[index];
    bool showThree = (index+1) % 4 == 0;
    return GestureDetector(
      child: showThree?getThreeImagItem(item):getContentItem(item) ,
      onTap: () {
        Navigator.push(context,new MaterialPageRoute(builder: (context) =>new ConsulationDetailPage(healthAdv: list[index],)));
      },

    );
  }
  getContentItem(HealthAdv item) {
    return Container(
        height: 120,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5.0),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex:2 ,
              child:Column(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      child: Text(item.title),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Expanded(
                      child: Align(
                        child:Row(
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                child:Text(item.net_name),
                                alignment: Alignment.bottomLeft,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                child:Text(item.num),
                                alignment: Alignment.bottomLeft,
                              ),
                            ),
                          ],
                        ) ,
                        alignment: Alignment.bottomLeft,
                      )
                  )

                ],
              ),
            ),

            Expanded(
              flex:1 ,
              child: Image.network(item.images.small,
                height: 90,
                fit: BoxFit.fitHeight,
              ),
            )
          ],
        )
    );
  }
  getThreeImagItem(HealthAdv item){
    return Container(
        height: 120,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5.0),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(item.title),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Image.network(item.images.small,
                    height:85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(item.images.large,
                    height:85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(item.images.medium,
                    height:85,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )
          ],
        )
    );
  }
}
