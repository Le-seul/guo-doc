import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_first/bean/music.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/music/cached_image.dart';
import 'package:flutter_first/music/channel_media_player.dart';
import 'package:flutter_first/music/cover.dart';
import 'package:flutter_first/music/lryic.dart';
import 'package:flutter_first/music/lyricstate.dart';
import 'package:flutter_first/music/page_playing_list.dart';
import 'package:flutter_first/music/player.dart';
import 'package:flutter_first/music/playing_indicator.dart';
import 'package:flutter_first/music/time.dart';

import 'music_controlbar_utils.dart';

///歌曲播放页面
class PlayingPage extends StatefulWidget {
  Music music;
  PlayingPage({Key key, @required this.music}) : super(key: key);

  @override
  _PlayingPageState createState() {
    return new _PlayingPageState();
  }
}

class _PlayingPageState extends State<PlayingPage> {

  StreamSubscription exitLogin;

  @override
  void initState() {
    super.initState();
    print('音乐测试:${widget.music.name}');
    MusicControlBar.removeControlBar();
    widget.music = quiet.value.current;
    quiet.addListener(_onPlayerStateChanged);
  }

  void _onPlayerStateChanged() {
    if (widget.music != quiet.value.current) {
      widget.music = quiet.value.current;
      if (widget.music == null) {
        Navigator.pop(context);
      } else {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    quiet.removeListener(_onPlayerStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
      child: Scaffold(
        body: widget.music == null
            ? Container()
            : Stack(
          children: <Widget>[
            _BlurBackground(music: widget.music),
            Material(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  _PlayingTitle(music: widget.music),
                  _CenterSection(music: widget.music),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  _DurationProgressBar(),
                  _ControllerBar(),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ],
        ),
      ),
      onWillPop: (){
        MusicControlBar.startTimer();
        Navigator.pop(context);
        MusicControlBar.showControlBar(context,widget.music,positionText);
      },
    );
  }
}


///player controller
/// pause,play,play next,play previous...
class _ControllerBar extends StatelessWidget {
  Widget getPlayModeIcon(context, Color color) {
    var playMode = PlayerState.of(context, aspect: PlayerStateAspect.playMode)
        .value
        .playMode;
    switch (playMode) {
      case PlayMode.single:
        return Icon(
          Icons.repeat_one,
          color: color,
        );
      case PlayMode.sequence:
        return Icon(
          Icons.repeat,
          color: color,
        );
      case PlayMode.shuffle:
        return Icon(
          Icons.shuffle,
          color: color,
        );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryIconTheme.color;

    final iconPlayPause = PlayingIndicator(
      playing: IconButton(
          tooltip: "暂停",
          iconSize: 40,
          icon: Icon(
            Icons.pause_circle_outline,
            color: color,
          ),
          onPressed: () {
            quiet.pause();
          }),
      pausing: IconButton(
          tooltip: "播放",
          iconSize: 40,
          icon: Icon(
            Icons.play_circle_outline,
            color: color,
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

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              icon: getPlayModeIcon(context, color),
              onPressed: () {
                quiet.changePlayMode();
              }),
          IconButton(
              iconSize: 36,
              icon: Icon(
                Icons.skip_previous,
                color: color,
              ),
              onPressed: () {
                quiet.playPrevious();
              }),
          iconPlayPause,
          IconButton(
              tooltip: "下一曲",
              iconSize: 36,
              icon: Icon(
                Icons.skip_next,
                color: color,
              ),
              onPressed: () {
                quiet.playNext();
              }),
          IconButton(
              tooltip: "当前播放列表",
              icon: Icon(
                Icons.menu,
                color: color,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return PlayingListDialog();
                    });
              }),
        ],
      ),
    );
  }
}

///a seek bar for current position
class _DurationProgressBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DurationProgressBarState();
}

String durationText = "00:00";
String positionText = "00:00";

class _DurationProgressBarState extends State<_DurationProgressBar> {
  bool isUserTracking = false;

  double trackingPosition = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).primaryTextTheme;
    var state = PlayerState.of(context).value;

    Widget progressIndicator;

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

      progressIndicator = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
//          LinearProgressIndicator(
//            value: maxBuffering / duration,
//            valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
//            backgroundColor: Colors.white12,
//          ),
          Slider(
            value: position.toDouble().clamp(0.0, duration.toDouble()),
            min: 0.0,
            activeColor: theme.body1.color.withOpacity(0.75),
            inactiveColor: theme.caption.color.withOpacity(0.3),
            max: duration.toDouble(),
            onChangeStart: (value) {
              setState(() {
                isUserTracking = true;
                trackingPosition = value;
              });
            },
            onChanged: (value) {
              setState(() {
                trackingPosition = value;
              });
            },
            onChangeEnd: (value) async {
              isUserTracking = false;
              quiet.seekTo(value.round());
              if (!quiet.value.playWhenReady) {
                quiet.play();
              }
            },
          ),
        ],
      );
    } else {
      //a disable slider if media is not available
      progressIndicator = Slider(value: 0, onChanged: (_) => {});
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: <Widget>[
          Text(positionText ?? "00:00", style: theme.body1),
          Padding(padding: EdgeInsets.only(left: 4)),
          Expanded(
            child: progressIndicator,
          ),
          Padding(padding: EdgeInsets.only(left: 4)),
          Text(durationText ?? "00:00", style: theme.body1),
        ],
      ),
    );
  }
}

class _CenterSection extends StatefulWidget {
  final Music music;

  const _CenterSection({Key key, @required this.music}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CenterSectionState();
}

class _CenterSectionState extends State<_CenterSection> {
  static bool _showLyric = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedCrossFade(
        crossFadeState:
            _showLyric ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild,
            Key bottomChildKey) {
          return Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Center(
                key: bottomChildKey,
                child: bottomChild,
              ),
              Center(
                key: topChildKey,
                child: topChild,
              ),
            ],
          );
        },
        duration: Duration(milliseconds: 300),
        firstChild: GestureDetector(
          onTap: () {
            setState(() {
              _showLyric = !_showLyric;
            });
          },
          child: AlbumCover(music: widget.music),
        ),
        secondChild: widget.music.lyric == null
            ? GestureDetector(
                child: Container(
                  child: Text(
                    '暂无歌词',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _showLyric = !_showLyric;
                  });
                },
              )
            : _CloudLyric(
                music: widget.music,
                onTap: () {
                  setState(() {
                    _showLyric = !_showLyric;
                  });
                },
              ),
      ),
    );
  }
}

class _CloudLyric extends StatefulWidget {
  final VoidCallback onTap;

  final Music music;

  const _CloudLyric({Key key, this.onTap, @required this.music})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CloudLyricState();
}

class _CloudLyricState extends State<_CloudLyric> {
  ValueNotifier<int> position = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    quiet.addListener(_onMusicStateChanged);
    _onMusicStateChanged();
  }

  void _onMusicStateChanged() {
    position.value = quiet.value.position.inMilliseconds;
  }

  @override
  void dispose() {
    quiet.removeListener(_onMusicStateChanged);
    position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .body1
        .copyWith(height: 1.5, fontSize: 16, color: Colors.white);
    final playingLyric = PlayingLyric.of(context);

    if (playingLyric.hasLyric) {
      return LayoutBuilder(builder: (context, constraints) {
        final normalStyle = style.copyWith(color: style.color.withOpacity(0.7));
        //歌词顶部与尾部半透明显示
        return ShaderMask(
          shaderCallback: (rect) {
            return ui.Gradient.linear(Offset(rect.width / 2, 0),
                Offset(rect.width / 2, constraints.maxHeight), [
              const Color(0x00FFFFFF),
              style.color,
              style.color,
              const Color(0x00FFFFFF),
            ], [
              0.0,
              0.15,
              0.85,
              1
            ]);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Lyric(
              lyric: LyricContent.from(widget.music.lyric),
              lyricLineStyle: normalStyle,
              highlight: style.color,
              position: position,
              onTap: widget.onTap,
              size: Size(
                  constraints.maxWidth,
                  constraints.maxHeight == double.infinity
                      ? 0
                      : constraints.maxHeight),
              playing: PlayerState.of(context,
                      aspect: PlayerStateAspect.playbackState)
                  .value
                  .isPlaying,
            ),
          ),
        );
      });
    } else {
      return Container(
        child: Center(
          child: Text(playingLyric.message, style: style),
        ),
      );
    }
  }
}

class _BlurBackground extends StatelessWidget {
  final Music music;

  const _BlurBackground({Key key, @required this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(
          image: CachedImage(music.image),
          fit: BoxFit.cover,
          height: 15,
          width: 15,
          gaplessPlayback: true,
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaY: 14, sigmaX: 24),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54,
                Colors.black26,
                Colors.black45,
                Colors.black87,
              ],
            )),
          ),
        ),
      ],
    );
  }
}

class _PlayingTitle extends StatelessWidget {
  final Music music;

  const _PlayingTitle({Key key, @required this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: AppBar(
        elevation: 0,
        primary: false,
        leading: IconButton(
            tooltip: '返回上一层',
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onPressed: (){
              Navigator.pop(context);
              MusicControlBar.showControlBar(context,music,positionText);
              MusicControlBar.startTimer();

            } ),
        centerTitle: true,
        titleSpacing: 0,
        title: Text(music.name,
            style: TextStyle(
                color: Colors.white, fontSize: 17),
          ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
