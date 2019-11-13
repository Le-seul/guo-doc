import 'package:flutter/material.dart';
import 'package:flutter_first/bean/course_detail.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/home_widgets/course/bottom_player%20bar.dart';
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CourseDetailPage extends StatefulWidget {
  String courseId;
  CourseDetailPage({Key key, @required this.courseId}) : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  TabController mTabController;
  CourseDetail courseDetail = new CourseDetail();
  bool isShowLoading = true; //课程目录


  @override
  void initState() {
    super.initState();
    BottomControllerBar.removeBar();
    _requestPsycourse();

    mTabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
  }

  void _requestPsycourse() {
    DioUtils.instance.requestNetwork<CourseDetail>(
        Method.get, Api.GETCOURSTEDETAIL,
        queryParameters: {
          'courseId': widget.courseId,
        }, onSuccess: (data) {
      setState(() {
        isShowLoading = false;
        courseDetail = data;
        print("获取课程详情成功！");
      });
      BottomControllerBar.show(context,courseDetail.chapterList);

    }, onError: (code, msg) {
      print("获取课程详情失败！");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            tooltip: '返回上一层',
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: (){
              Navigator.pop(context);

            } ),
        title: Text(
          '心理课程',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : courseDetail == null
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text('暂无数据'),
                )
              : Container(
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        courseDetail.image,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        height: 60,
                        child: TabBar(
                          isScrollable: false,
                          //是否可以滚动
                          controller: mTabController,
                          labelPadding: EdgeInsets.only(left: 5, right: 5),
                          indicatorColor: Color(0xff2CA687),
                          labelColor: Color(0xff2CA687),
                          unselectedLabelColor: Color(0xff666666),
                          unselectedLabelStyle: TextStyle(fontSize: 16),
                          labelStyle: TextStyle(fontSize: 16.0),
                          tabs: <Widget>[
                            Text('课程详情'),
                            Text('课程目录'),
                          ],
                        ),
                      ),
                      Flexible(
                        child: TabBarView(
                          controller: mTabController,
                          children: <Widget>[
                            Detail(
                              Detailurl: courseDetail.detailDescription,
                            ),
                            itemWidget2(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
//      bottomSheet: BottomControllerWidget(),

    );
  }



  itemWidget2() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Text(
                '如何利用时间',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 10,
              ),
              Text('共16讲', style: TextStyle(color: Colors.black26))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: courseDetail.chapterList.length,
            itemBuilder: (context, index) =>
                _buildItem(courseDetail.chapterList[index], index),
          ),
        ],
      ),
    );
  }

  _buildItem(ChapterList chapterList, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if(chapterList.isPlaying == false){
            eventBus
                .fire(CourseContent(index, 0));
//            startPlayer();
          }else{
            eventBus
                .fire(CourseContent(index, 1));
//            pausePlayer();
          }
        });

//        Router.push(context, Router.catalogdetail,chapterList.detailDescription);
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 1,
            color: Colors.black26,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Text('${index + 1}.', style: TextStyle(fontSize: 18)),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child:
                      Text(chapterList.name, style: TextStyle(fontSize: 16))),
              Icon(
                chapterList.isPlaying?Icons.pause_circle_outline:Icons.play_circle_outline,
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class Detail extends StatefulWidget {
  String Detailurl;
  Detail({
    Key key,
    @required this.Detailurl,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return WebView(
      initialUrl: widget.Detailurl,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
