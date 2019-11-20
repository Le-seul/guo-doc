import 'dart:async';
import 'dart:convert';

import 'package:flustars/flustars.dart'as lib;
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/course_detail.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/date_symbol_data_local.dart';

class BottomControllerBar {
  static OverlayEntry tinyControlbar;
  static OverlayEntry overlayEntry;
  static double dx, dy;
  static bool isClick = true;
  static bool position = false;
  static ChapterList currentCourse;
  static bool hide = false;

  static void removeBar() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
    if (tinyControlbar != null) {
      tinyControlbar.remove();
      tinyControlbar = null;
    }
  }

  static showTinyControlbar(BuildContext context) {
    tinyControlbar = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return new Positioned(
        bottom: dy,
        left: 0,
        child: new Material(
          color: Colors.transparent,
          child: Container(
            width: 25,
            height: 50,
            padding: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF75C2E0), Colors.blue[200]],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: new BorderRadius.horizontal(right: Radius.circular(90)), // 也可控件一边圆角大小
            ),
            child: IconButton(
              padding:EdgeInsets.all(0.0),
              icon: Icon(
                Icons.navigate_next,
                color: Colors.white70,
              ),
              onPressed: () {
                tinyControlbar.remove();
                tinyControlbar = null;
                hide = false;

                Overlay.of(context).setState(() {});
                print("click close");
              },
            ),
          ),
        ),
      );
    });
    //往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(tinyControlbar);
  }


  static void hideBottomControllerBar(BuildContext context,bool isShow){
    if (tinyControlbar != null) {
      tinyControlbar.remove();
      tinyControlbar = null;
    }
    hide = isShow;
    dy = 0.0;
    Overlay.of(context).setState(() {});
  }

  static void setCourse(ChapterList course) {
    currentCourse = course;
  }

  static ChapterList getCourse() {
    return currentCourse;
  }

  static void show(
      BuildContext context, CourseDetail courseDetail, ChapterList chapter) {
    //创建一个OverlayEntry对象
//    hide = true;
    dy = 0.0;
    currentCourse = chapter;
    overlayEntry = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return new Positioned(
          left: 0,
          bottom: dy,
          child: Offstage(
            offstage: hide,
            child: new Material(
              type: MaterialType.transparency, //透明类型
              child: GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    final RenderObject box = context.findRenderObject();
                    //  获得自定义Widget的大小，用来计算Widget的中心锚点
//            dx = details.globalPosition.dx ;
                    dy = lib.ScreenUtil.getInstance().screenHeight-details.globalPosition.dy;
                    print("vertical drag $dx $dy");
                    Overlay.of(context).setState(() {});
                  },
                  onVerticalDragEnd: (DragEndDetails details) {
                  },
                  onHorizontalDragUpdate: (DragUpdateDetails details) {
                    final RenderObject box = context.findRenderObject();
                    //  获得自定义Widget的大小，用来计算Widget的中心锚点
//            dx = details.globalPosition.dx ;
                    if (details.delta.dx < -10) {
                      print("hide action");
                      hide = true;
                      if (tinyControlbar == null) {
                        Overlay.of(context).setState(() {});
                        showTinyControlbar(context);
                      }
                    }
                  },
                  child: BottomControllerWidget(courseDetail, chapter)),
            ),
          ));
    });
    //往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(overlayEntry);

    //两秒后，移除Toast
//    new Future.delayed(Duration(seconds: 2)).then((value) {
//      overlayEntry.remove();
//    });
  }
}

class BottomControllerWidget extends StatefulWidget {
  CourseDetail courseDetail;
  ChapterList chapterList;
  BottomControllerWidget(this.courseDetail, this.chapterList);
  @override
  _BottomControllerWidgetState createState() => _BottomControllerWidgetState();
}

class _BottomControllerWidgetState extends State<BottomControllerWidget> {
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound = new FlutterSound();
  double slider_current_position = 0.0;
  double max_duration = 1.0;
  String _playerTxt = '00:00';
  String _maxTxt = '00:00';
  bool isSeek = true;
  StreamSubscription exitLogin;
  ChapterList course;

  @override
  void initState() {

    init();

    exitLogin = eventBus.on<CourseContent>().listen((event) async{
      if (course.audio == event.chapterList.audio) {
        if (event.type == 0) {
          if(isSeek){
            seekToPlay();
          }else{
            startPlayer(course.audio);
          }

        } else {
          pausePlayer();
        }
        setState(() {
          course.isPlaying = BottomControllerBar.getCourse().isPlaying;
        });

      } else {
        stopPlayer();
        course.isPlaying = false;
        startPlayer(event.chapterList.audio);
        event.chapterList.isPlaying = true;
        setState(() {
          course = event.chapterList;
        });
      }
      BottomControllerBar.setCourse(course);
      print('课程：${course.isPlaying}');
    });

    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
    initializeDateFormatting();
  }

  init() async{
    course = widget.chapterList;
    if(course.isPlaying == true){
      if(isSeek){
        seekToPlay();
      }else{
        startPlayer(course.audio);
      }
    }else{
      pausePlayer();
    }
  }

  @override
  void dispose() {
    exitLogin.cancel();
//    stopPlayer();
  }

  void seekToPlay() async{
    startPlayer(course.audio);
    await flutterSound
        .seekToPlayer(course.duration*1000.toInt());
    isSeek = false;
  }

  void startPlayer(String url) async {
    String utf8Url = Uri.encodeFull(url);
    String path = await flutterSound.startPlayer(utf8Url);
//    File file= await new File(path);
//    List contents = await file.readAsBytesSync();

    // return print("file文件：$contents");
    await flutterSound.setVolume(1.0);
    print('startPlayer: $path');

    try {
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          slider_current_position = e.currentPosition;
          print('当下位置：$slider_current_position');
          max_duration = e.duration;
          print('最大位置：$max_duration');
          if(slider_current_position > max_duration){
            max_duration = slider_current_position;
          }

          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt(),
              isUtc: true);
          DateTime date2 = new DateTime.fromMillisecondsSinceEpoch(
              e.duration.toInt(),
              isUtc: true);
          String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
          String txt2 = DateFormat('mm:ss:SS', 'en_GB').format(date2);

          setState(() {
//            course.isPlaying = flutterSound.isPlaying;
            if (e.currentPosition.toInt() == e.duration.toInt()) {
              print('lalala');
              eventBus.fire(CourseContent1(course, 1));
              _sendStudyRecord();
              course.isPlaying = false;
            }
            _playerTxt = txt.substring(0, 5);
            _maxTxt = txt2.substring(0, 5);
          });
        }
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void stopPlayer() async {
    try {
      String result = await flutterSound.stopPlayer();
      print('stopPlayer: $result');
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }
    } catch (err) {
      print('error: $err');
    }
  }

  void pausePlayer() async {
    String result = await flutterSound.pausePlayer();
    _sendStudyRecord();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(BottomControllerBar.isClick){
          BottomControllerBar.isClick = false;
          BottomControllerBar.hideBottomControllerBar(context, true);
          Router.push(context, Router.catalogdetail,course.detailDescription);

          BottomControllerBar.hide = true;
          BottomControllerBar.dy = lib.ScreenUtil.getInstance().screenHeight*0.3;
//          BottomControllerBar.showTinyControlbar(context);
          Overlay.of(context).setState(() {});
        }
      },
      child: Container(
        color: Colors.transparent,
        height: 65,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 55,
                color: Color(0xFF75C2E0),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            BottomControllerBar.removeBar();
                            stopPlayer();
                            _sendBookMark();
                            _sendStudyRecord();
                            eventBus.fire(CourseContent1(course, 1));
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                      CircleAvatar(
                        radius: 22.0,
                        backgroundImage: NetworkImage(
                            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572450655242&di=f0409d79fb8bd4a4daa803137ad3f2a2&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201806%2F27%2F20180627170925_nsPVv.thumb.700_0.jpeg'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                course.name,
                                style: TextStyle(color: Colors.white),
                              ))),
                      GestureDetector(
                        onTap: () {

                          if (course.isPlaying == false) {
                            print('url:${course.audio}');
                            eventBus.fire(CourseContent1(course, 0));
                            if(isSeek){
                              seekToPlay();
                            }else{
                              startPlayer(course.audio);
                            }
                            print('状态3：${course.isPlaying}');
                          } else {
                            pausePlayer();
                            print('状态4：${course.isPlaying}');
                            eventBus.fire(CourseContent1(course, 1));
                          }

                          setState(() {
                            print('状态1：${course.isPlaying}');
                            course.isPlaying = !(course.isPlaying);
                            print('状态2：${course.isPlaying}');
                          });
                          BottomControllerBar.setCourse(course);
                        },
                        child: Container(
                            padding: EdgeInsets.only(top: 10, right: 10),
                            child: Icon(
                              course.isPlaying
                                  ? Icons.pause_circle_outline
                                  : Icons.play_circle_outline,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          _playerTxt,
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Container(
                            height: 3,
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white, //进度条滑块左边颜色
                                inactiveTrackColor: Colors.black26, //进度条滑块右边颜色
                                thumbShape: RoundSliderThumbShape(
                                  //可继承SliderComponentShape自定义形状
                                  disabledThumbRadius: 5, //禁用是滑块大小
                                  enabledThumbRadius: 5, //滑块大小
                                ),
                                //提示进度的气泡的背景色
                                //滑块中心的颜色
                                thumbColor: Colors.white,
                              ),
                              child: Slider(
                                value: slider_current_position,
                                onChanged: (double value) async {
                                  await flutterSound
                                      .seekToPlayer(value.toInt());
                                },
                                min: 0.0,
                                max: max_duration,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          _maxTxt,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _sendBookMark() {
    print('duration:${(slider_current_position / 1000).truncate()}');
    DioUtils.instance.requestNetwork<String>(Method.post, Api.SAVEBOOKMARK,
        queryParameters: {
          'courseId': widget.courseDetail.id,
          'chapterId': course.chapterId,
          'duration': (slider_current_position / 1000).truncate(),
        }, onSuccess: (data) {
      print('上传书签成功!');
    }, onError: (code, msg) {
      print('上传书签失败!');
    });
  }

  _sendStudyRecord() {
    DioUtils.instance.requestNetwork<String>(Method.post, Api.SAVESTUDYRECORDER,
        queryParameters: {
          'courseId': widget.courseDetail.id,
          'chapterId': course.chapterId,
          'duration': (slider_current_position / 1000).truncate(),
          'isFinish': 'Y',
        }, onSuccess: (data) {
      print('上传学习进度成功!');
    }, onError: (code, msg) {
      print('上传书签失败!');
    });
  }
}
