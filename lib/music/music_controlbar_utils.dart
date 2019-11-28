import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/music/channel_media_player.dart';
import 'package:flutter_first/music/page_playing.dart';
import 'package:flutter_first/music/player.dart';
import 'package:flutter_first/music/playing_indicator.dart';
import 'package:flutter_first/music/time.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:marquee_flutter/marquee_flutter.dart';

import 'cached_image.dart';

class MusicControlBar {
  static OverlayEntry tinyControlbar;
  static OverlayEntry controlBar;
  static double dx, dy;
  static bool hide = false;
  static String _positonText = "00:00";
  static Timer _timer; //倒计时的计时器
  static int _seconds; //当前倒计时的秒数

  //启动计时器
  static void startTimer() {
    _seconds = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
    });
  }

  static showTinyControlbar(BuildContext context) {
    tinyControlbar = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return new Positioned(
        top: dy,
        left: 0,
        child: new Material(
          color: Colors.transparent,
          child: Container(
            width: 25,
            height: 50,
            padding: EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff009a73), Color(0xff3bd3ac)],
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
                startTimer();
                tinyControlbar.remove();
                tinyControlbar = null;
                hideControlBar(context);
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

  static hideControlBar(BuildContext context) {
    hide = false;
    Overlay.of(context).setState(() {});
  }

  static removeControlBar() {
    if (controlBar != null) {
      controlBar.remove();
      controlBar = null;
    }
    if (tinyControlbar != null) {
      tinyControlbar.remove();
      tinyControlbar = null;
    }
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  static showControlBar(BuildContext context, Music music, String position) {
    hide = false;
    music = quiet.value.current;
    dy = ScreenUtil.getInstance().screenHeight * 0.7;
    dx = 15;
    print("show $dx $dy");

    bool isUserTracking = false;
    double trackingPosition = 0;

    final iconPlayPause = PlayingIndicator(
      playing: IconButton(
          tooltip: "暂停",
          icon: Icon(
            Icons.pause,
            color: Colors.white,
          ),
          onPressed: () {
            quiet.pause();
          }),
      pausing: IconButton(
          tooltip: "播放",
          icon: Icon(
            Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: () {
            quiet.play();
          }),
      buffering: Container(
        height: 56,
        width: 56,
        child: Center(
          child: Container(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      ),
    );

    String durationText = "00:00";
    String positionText = "00:00";

    GlobalKey<TextWidgetState> textKey = GlobalKey();
    controlBar = new OverlayEntry(builder: (context) {
      void _onPlayerStateChanged() {
        if (music != quiet.value.current) {
          music = quiet.value.current;
          if (music == null) {
            Navigator.pop(context);
          } else {
            Overlay.of(context).setState(() {});
          }
        }
        if (quiet.value.position != position) {
          var state = PlayerState.of(context).value;
          if (state.initialized) {
            var duration = state.duration.inMilliseconds;
            var position = isUserTracking
                ? trackingPosition.round()
                : state.position.inMilliseconds;

            durationText = getTimeStamp(duration);
            positionText = getTimeStamp(position);
            int maxBuffering = 0;
            for (DurationRange range in state.buffered) {
              final int end = range.end.inMilliseconds;
              if (end > maxBuffering) {
                maxBuffering = end;
              }
            }
          }

          isUserTracking = true;
          trackingPosition = quiet.value.position.inMilliseconds.toDouble();

          textKey.currentState.refresh(positionText, durationText);
        }
        if (_seconds == 5) {
          hide = true;
          if (tinyControlbar == null) {
            Overlay.of(context).setState(() {
              showTinyControlbar(context);
            });
          }
          _seconds = 0;
          _timer?.cancel();
        }
      }

      quiet.addListener(_onPlayerStateChanged);

      //外层使用Positioned进行定位，控制在Overlay中的位置

      return new Positioned(
          top: dy,
          left: dx,
          child: Offstage(
            offstage: hide,
            child: GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails details) {
                final RenderObject box = context.findRenderObject();
                //  获得自定义Widget的大小，用来计算Widget的中心锚点
//            dx = details.globalPosition.dx ;
                dy = details.globalPosition.dy;
                print("vertical drag $dx $dy");
                Overlay.of(context).setState(() {});
                _seconds = 0;
                _timer?.cancel();
              },
              onVerticalDragEnd: (DragEndDetails details) {
                startTimer();
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
                  _seconds = 0;
                  _timer?.cancel();
                }
              },
              child: new Material(
                child: Container(
                  height: 50,
                  constraints: BoxConstraints(minWidth: 300),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Color(0xff009a73), Color(0xff3bd3ac)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image(
                          width: 42,
                          height: 42,
                          image: CachedImage(music.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(left: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 30,
                              child: MarqueeWidget(
                                ratioOfBlankToScreen: 0.1,
                                text: music.name,
                                textStyle: new TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                                scrollAxis: Axis.horizontal,
                              ),
                            ),
                            Expanded(
                              child: TextWidget(textKey),
                            )

                            ///需要更新的Text)
                          ],
                        ),
                      ),
                      iconPlayPause,
                      IconButton(
                        icon: Icon(
                          Icons.skip_next,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Overlay.of(context).setState(() {});
                          quiet.playNext();
                        },
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black26,
                          ),
                          onPressed: () {
                            quiet.removeListener(_onPlayerStateChanged);
                            removeControlBar();
                          }),
                    ],
                  ),
                ),
              ),
              onTap: () {
                NavigatorUtil.pushPage(context,PlayingPage());
              },
            ),
          ));
    });
    //往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(controlBar);
  }
}

class TextWidget extends StatefulWidget {
  TextWidget(Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TextWidgetState();
  }
}

class TextWidgetState extends State<TextWidget> {
  String durationText = "00:00";
  String positionText = "00:00";

  @override
  Widget build(BuildContext context) {
    return Text(
      "$positionText/$durationText",
      style: TextStyle(color: Colors.white, fontSize: 13),
    );
  }

  void refresh(String startTime, String endTime) {
    setState(() {
      positionText = startTime;
      durationText = endTime;
    });
  }
}
