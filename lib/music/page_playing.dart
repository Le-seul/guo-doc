import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music_model.dart';
import 'package:flutter_first/music/anims/needle_anim.dart';
import 'package:flutter_first/music/anims/record_anim.dart';
import 'package:flutter_first/music/player_page.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';

final GlobalKey<PlayerState> musicPlayerKey = new GlobalKey();

class PlayingPage extends StatefulWidget {
  String songId;
  PlayingPage({Key key, @required this.songId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new _PlayingPageState();
  }
}

class _PlayingPageState extends State<PlayingPage>
    with TickerProviderStateMixin {
  bool isShowLoading = true;
  Music _music;
  AnimationController controller_record;
  Animation<double> animation_record;
  Animation<double> animation_needle;
  AnimationController controller_needle;
  final _rotateTween = new Tween<double>(begin: -0.15, end: 0.0);
  final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);

  @override
  void initState() {
    super.initState();
    _getMusicDetail();
    controller_record = new AnimationController(
        duration: const Duration(milliseconds: 15000), vsync: this);
    animation_record =
        new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    controller_needle = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation_needle =
        new CurvedAnimation(parent: controller_needle, curve: Curves.linear);

    animation_record.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller_record.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller_record.forward();
      }
    });
  }

  _getMusicDetail() {
    DioUtils.instance.requestNetwork<Music>(Method.get, Api.GETMUSICDETAIL,
        queryParameters: {"songId": widget.songId}, onSuccess: (data) {
      setState(() {
        isShowLoading = false;
        _music = data;
      });
    }, onError: (code, msg) {
      isShowLoading = false;
      Toast.show('请求失败！');
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_music == null)
        ? Container()
        : Stack(
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new NetworkImage(_music.image),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                      Colors.black54,
                      BlendMode.overlay,
                    ),
                  ),
                ),
              ),
              new Container(
                  child: new BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Opacity(
                  opacity: 0.6,
                  child: new Container(
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
              )),
              new Scaffold(
                backgroundColor: Colors.transparent,
                appBar: new AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: Container(
                    child: Text(
                      _music.name,
                      style: new TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                body: new Stack(
                  alignment: const FractionalOffset(0.5, 0.0),
                  children: <Widget>[
                    new Stack(
                      alignment: const FractionalOffset(0.7, 0.1),
                      children: <Widget>[
                        new Container(
                          child: RotateRecord(_music.image,
                              animation:
                                  _commonTween.animate(controller_record)),
                          margin: EdgeInsets.only(top: 100.0),
                        ),
                        new Container(
                          child: new PivotTransition(
                            turns: _rotateTween.animate(controller_needle),
                            alignment: FractionalOffset.topLeft,
                            child: new Container(
                              width: 100.0,
                              child: new Image.asset(
                                  "assets/images/play_needle.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: new Player(
                        onError: (e) {
                          Scaffold.of(context).showSnackBar(
                            new SnackBar(
                              content: new Text(e),
                            ),
                          );
                        },
                        onPrevious: () {},
                        onNext: () {},
                        onCompleted: () {},
                        onPlaying: (isPlaying) {
                          if (isPlaying) {
                            controller_record.forward();
                            controller_needle.forward();
                          } else {
                            controller_record.stop(canceled: false);
                            controller_needle.reverse();
                          }
                        },
                        key: musicPlayerKey,
                        color: Colors.white,
                        audioUrl: _music.audioStream,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  @override
  void dispose() {
    controller_record.dispose();
    controller_needle.dispose();
    super.dispose();
  }
}
