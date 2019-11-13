import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/course_detail.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/date_symbol_data_local.dart';

class BottomControllerBar {
  static OverlayEntry overlayEntry;

  static void removeBar(){
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  static void show(BuildContext context,List<ChapterList> chapterList) {
    //创建一个OverlayEntry对象
   overlayEntry = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return new Positioned(
          bottom: 0.0,
          child: new Material(
            type: MaterialType.transparency, //透明类型
            child: BottomControllerWidget(chapterList),
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

  List<ChapterList> chapterList;
  BottomControllerWidget(this.chapterList);
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
  StreamSubscription exitLogin;
  ChapterList course = new ChapterList();

  @override
  void initState() {

    course = widget.chapterList[0];
    exitLogin = eventBus.on<CourseContent>().listen((event) {
      setState(() {
        course = widget.chapterList[event.index];

      });
      if(event.type == 0){
        startPlayer(course.audio);
//          course.isPlaying = true;
      }else{
        pausePlayer();
//          course.isPlaying = false;
      }
      course.isPlaying = !course.isPlaying;

    });

    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
    initializeDateFormatting();
  }

  @override
  void dispose() {
    exitLogin.cancel();
//    stopPlayer();
  }

  void startPlayer(String url) async {
    String utf8Url = Uri.encodeFull(url);
    String path = await flutterSound.startPlayer(utf8Url);
    print('傻子吧');
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

          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt(),
              isUtc: true);
          DateTime date2 = new DateTime.fromMillisecondsSinceEpoch(
              e.duration.toInt(),
              isUtc: true);
          String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
          String txt2 = DateFormat('mm:ss:SS', 'en_GB').format(date2);

          setState(() {
            _playerTxt = txt.substring(0,5);
            _maxTxt = txt2.substring(0,5);

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

      setState(() {
        course.isPlaying = false;
      });

    } catch (err) {
      print('error: $err');
    }
  }

  void pausePlayer() async {
    String result = await flutterSound.pausePlayer();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        BottomControllerBar.removeBar();
        stopPlayer();
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
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                        onTap: (){
                          if(course.isPlaying == false){
                            print('url:${course.audio}');
                            startPlayer(course.audio);
                          }else{
                            pausePlayer();
                          }
                          setState(() {
                            course.isPlaying = !course.isPlaying;
                          });

                        },
                        child: Container(
                            padding: EdgeInsets.only(top: 10, right: 10),
                            child: Icon(
                              course.isPlaying?Icons.pause_circle_outline:Icons.play_circle_outline,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: <Widget>[
                      Text(_playerTxt,style: TextStyle(color: Colors.white),),
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
                                await flutterSound.seekToPlayer(value.toInt());
                              },
                              min: 0.0,
                              max: max_duration,
                            ),
                          ),
                        ),
                      ),
                      Text(_maxTxt,style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
