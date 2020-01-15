import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/chapter_record.dart';
import 'package:flutter_first/bean/course_bookmark.dart';
import 'package:flutter_first/bean/course_detail.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/config.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/home_widgets/course/bottom_player%20bar.dart';
import 'package:flutter_first/pages/home/home_widgets/course/catalog_detail_page.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/storage_manager.dart';

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
  StreamSubscription exitLogin;



  @override
  void initState() {
    super.initState();
    exitLogin = eventBus.on<CourseContent1>().listen((event) {
      for(ChapterList chapterList in courseDetail.chapterList){
        if(event.chapterList.chapterId == chapterList.chapterId){
          setState(() {
            print('evenBus接收');
            if(event.type == 0){
              print('evenBus接收0');
              chapterList.isPlaying = true;
            }else if(event.type == 1){
              print('evenBus接收1');
              chapterList.isPlaying = false;
            }
          });
        }
      }
    });

    _requestPsycourse();

    mTabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    super.dispose();
    exitLogin.cancel();
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
        _getChapterRecord();
        _getCourseBookmark();
        print("获取课程详情成功！");
      });
    }, onError: (code, msg) {
      print("获取课程详情失败！");
    });
  }

  void _getCourseBookmark() {
    DioUtils.instance.requestNetwork<CourseBookmark>(
        Method.get, Api.GETBOOKMARK,
        queryParameters: {
          'courseId': widget.courseId,
        }, onSuccess: (data) {
      for (ChapterList chapter in courseDetail.chapterList) {
        if (chapter.chapterId == data.chapterId) {
          chapter.isHighlight = true;
          chapter.duration = data.duration;
          if(BottomControllerBar.overlayEntry == null){
            print('创建bottomBar');
            BottomControllerBar.show(context, courseDetail, chapter,false);
          }

          if(BottomControllerBar.getCourse().isPlaying == true){
            chapter.isPlaying = true;
          }
        }
      }
      setState(() {
        print("获取书签成功！");
      });
    }, onError: (code, msg) {
      print("获取书签失败！");
    });
  }

  void _getChapterRecord() {
    DioUtils.instance.requestNetwork<ChapterRecord>(
        Method.get, Api.GETCOURSERECORD,
        isList: true,
        queryParameters: {
          'courseId': widget.courseId,
        }, onSuccessList: (data) {
      setState(() {
        if (data.length == 0 || data == []) {
          courseDetail.chapterList[0].state = 'P';
          print('第一个：${courseDetail.chapterList[0].state}');
        } else {
          print('第n个');
          var recordMap = new Map();
          for (ChapterRecord record in data)
            recordMap[record.chapterId] = record;
          for (int n = 0; n < courseDetail.chapterList.length; n++) {
            ChapterList chapter = courseDetail.chapterList[n];
            if(chapter != null && chapter.chapterId == BottomControllerBar.getCourse().chapterId){
              chapter.isPlaying = BottomControllerBar.getCourse().isPlaying;
            }

            if (recordMap.containsKey(chapter.chapterId)) {
              ChapterRecord record = recordMap[chapter.chapterId];
              if (record.isFinish == 'Y') {
                chapter.state = 'Y';
                chapter.duration = record.duration;
              } else {
                chapter.state = 'P';
                chapter.duration = record.duration;
              }
            } else {
              chapter.state = 'N';
              chapter.duration = 0;
            }
          }
          for (int n = 1; n < courseDetail.chapterList.length; n++) {
            ChapterList chapter = courseDetail.chapterList[n];
            ChapterList chapterBefore = courseDetail.chapterList[n - 1];
            if (chapter.state == 'N' && chapterBefore.state == 'Y') {
              chapter.state = 'P';
              break;
            }
          }
        }

        print("获取课程内章节进度成功！");
      });
    }, onError: (code, msg) {
      print("获取课程内章节进度失败！");
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
            onPressed: () {
              Navigator.pop(context);
            }),
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
                      AspectRatio(
                        aspectRatio: 11/6,
                        child: Image.network(
                          courseDetail.image,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
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
                              id: courseDetail.id,
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
              Text('共${courseDetail.chapterList.length}讲', style: TextStyle(color: Colors.black26))
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

        if(chapterList.state == 'N'){

        }else{
          if(BottomControllerBar.overlayEntry == null){
            BottomControllerBar.show(context, courseDetail, chapterList,true);
          }else{
            BottomControllerBar.hideBottomControllerBar(context, true);
          }

          NavigatorUtil.pushPage(context,CatalogDetail(Detail: chapterList.detailDescription,));
          if(chapterList.isPlaying == false){
            if (chapterList.state != 'N') {
              if (chapterList.isPlaying == false) {
                chapterList.isPlaying = true;
                BottomControllerBar.setCourse(chapterList);
                eventBus.fire(CourseContent(chapterList, 0));
              } else {
                chapterList.isPlaying = false;
                BottomControllerBar.setCourse(chapterList);
                eventBus.fire(CourseContent(chapterList, 1));
              }
//          if(BottomControllerBar.overlayEntry == null){
//            print('创建bottomBar');
//            BottomControllerBar.show(context, courseDetail, chapterList);
//          }

            }
            for (ChapterList chapterList in courseDetail.chapterList) {
              chapterList.isHighlight = false;
              if(BottomControllerBar.getCourse().chapterId != chapterList.chapterId){
                chapterList.isPlaying = false;
              }
            }
            chapterList.isHighlight = true;
            setState(() {
//          chapterList.isPlaying = BottomControllerBar.getCourse().isPlaying;
            });
            _sendBookMark(chapterList);
          }

        }



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
              Text('${index + 1}.',
                  style: TextStyle(
                      fontSize: 18,
                      color: chapterList.isHighlight
                          ? Color(0xFFF6A643)
                          : Colors.black)),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child: Text(chapterList.name,
                      style: TextStyle(
                          fontSize: 16,
                          color: chapterList.isHighlight
                              ? Color(0xFFF6A643)
                              : Colors.black))),
              chapterList.state == 'N'
                  ? Icon(Icons.lock_outline):chapterList.isPlaying?Icon(Icons.pause_circle_outline,
                  color: chapterList.isHighlight
                      ? Color(0xFFF6A643)
                      : Colors.black)
                  : Icon(Icons.play_circle_outline,
                      color: chapterList.isHighlight
                          ? Color(0xFFF6A643)
                          : Colors.black)
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
  _sendBookMark(ChapterList chapterList) {

    DioUtils.instance.requestNetwork<String>(Method.post, Api.SAVEBOOKMARK,
        queryParameters: {
          'courseId': courseDetail.id,
          'chapterId': chapterList.chapterId,
          'duration': 0,
        }, onSuccess: (data) {
          print('上传书签成功!');
        }, onError: (code, msg) {
          print('上传书签失败!');
        });
  }


}

class Detail extends StatefulWidget {
  String id;
  Detail({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String token;

  String baseurl;

  @override
  void initState() {
    token = StorageManager.sharedPreferences.getString(Constant.access_Token);
    baseurl = Config.apiHost;
  }

  @override
  Widget build(BuildContext context) {

    return WebView(
      initialUrl: '${baseurl}/api/staticResource.do?getResource&url=mobile_course_ui/courseCatalog.html&token=$token&catalogId=${widget.id}&commonIp=${baseurl}',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
