import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_first/bean/health_adv.dart';
import 'package:flutter_first/mock_request.dart';
import 'package:flutter_first/pages/consultation/title_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_first/res/styles.dart';
import 'package:flutter_first/util/toast.dart';

GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
var numb = 0;

class SelectedPage extends StatefulWidget {
  SelectedPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelectedPageState();
  }
}

class _SelectedPageState extends State<SelectedPage> {
  Widget titleWidget;
  List<HealthAdv> list = List();
  List<HealthAdv> tmplist;

  @override
  void initState() {
    super.initState();
    titleWidget = Container(
//      padding: EdgeInsets.only(top: 10.0),
      child: TitleWidget(),
    );

    _requestAPI();

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
  Widget build(BuildContext context) {
    // TODO: implement build
    return new EasyRefresh(
      key: _easyRefreshKey,
      behavior: ScrollOverBehavior(),

      refreshHeader: ClassicsHeader(
        key: _headerKey,
        refreshHeight: 50,
        refreshText: "pullToRefresh",
        refreshReadyText: "releaseToRefresh",
        refreshingText: "refreshing" + "...",
        refreshedText: "refreshed",
        moreInfo: "updateAt",
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        showMore: false,
      ),
      refreshFooter: ClassicsFooter(
        key: _footerKey,

        loadHeight: 50,
        loadText: "pushToLoad",
        loadReadyText: "releaseToLoad",
        loadingText:"loading",
        loadedText: "loaded",
        noMoreText: "noMore",
        moreInfo: "updateAt",
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        showMore: true,
      ),
      child: containerBody(),
      onRefresh: () async {
        if(list==null){
          numb=0;
          _requestAPI();
        }
      },
      loadMore: () async {
        if(numb<2){
          numb++;
          _requestAPI();

        }else{
          Toast.show("已加载完毕！");
        }

      },
    );
  }

  Widget containerBody() {
    return Container(
      color: const Color.fromARGB(255, 247, 247, 247),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: titleWidget,
          ),
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
    return Container(
      child:showThree?getThreeImagItem(item):getContentItem(item) ,
    );
  }
  getContentItem(HealthAdv item) {
    return Container(
        height: 120,
        color: Colors.white,
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex:2 ,
              child:Column(
                children: <Widget>[
                  Text(item.title
                    ,textAlign: TextAlign.left,),
                  Expanded(
                      child: Align(
                        child:Row(

                          children: <Widget>[
                            Text(item.net_name),
                            Gaps.hGap50,
                            Text(item.num)],
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
        margin: const EdgeInsets.only(top: 10.0),
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
                  child: Image.network(item.images.medium,
                    height:85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(item.images.large,
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
