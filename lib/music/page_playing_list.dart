import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music.dart';
import 'package:flutter_first/music/channel_media_player.dart';
import 'package:flutter_first/music/player.dart';
import 'package:overlay_support/overlay_support.dart';


class PlayingListDialog extends StatefulWidget {
  @override
  PlayingListDialogState createState() {
    return new PlayingListDialogState();
  }
}

class PlayingListDialogState extends State<PlayingListDialog> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    final playingList = quiet.value.playingList;
    final music = quiet.value.current;
    assert(music != null, '展示播放列表时，当前音乐不能为空！');
    double offset = playingList.indexOf(music) * _HEIGHT_MUSIC_TILE;
    _controller = ScrollController(initialScrollOffset: offset);
  }

  @override
  Widget build(BuildContext context) {
    List<Music> playingList = PlayerState.of(context, aspect: PlayerStateAspect.playlist).value.playingList;
    Music music = PlayerState.of(context, aspect: PlayerStateAspect.music).value.current;

    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: <Widget>[
          _Header(),
          Expanded(
            child: ListView.builder(
                controller: _controller,
                itemCount: playingList.length,
                itemBuilder: (context, index) {
                  Music item = playingList[index];
                  return _MusicTile(music: item, playing: item.id == music.id);
                }),
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  StatelessElement createElement() {
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    final state = PlayerState.of(context, aspect: PlayerStateAspect.playMode);
    final playMode = state.value.playMode;
    final count = state.value.playingList.length;
    IconData icon;
    String name;
    switch (playMode) {
      case PlayMode.single:
        icon = Icons.repeat_one;
        name = "单曲循环";
        break;
      case PlayMode.sequence:
        icon = Icons.repeat;
        name = "列表循环";
        break;
      case PlayMode.shuffle:
        icon = Icons.shuffle;
        name = "随机播放";
        break;
    }
    return Material(
      elevation: 0.5,
      child: Container(
        height: 48,
        child: Row(
          children: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  quiet.changePlayMode();
                },
                icon: Icon(icon),
                label: Text("$name($count)")),
            Spacer(),
            IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () async {
                  Navigator.pop(context);
                  quiet.quiet();
                })
          ],
        ),
      ),
    );
  }
}

const _HEIGHT_MUSIC_TILE = 48.0;

class _MusicTile extends StatelessWidget {
  final Music music;
  final bool playing;

  const _MusicTile({Key key, this.music, this.playing = false})
      : assert(music != null && playing != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget leading;
    Color name, artist;
    if (playing) {
      Color color = Theme.of(context).primaryColor;
      leading = Container(
        margin: EdgeInsets.only(right: 8),
        child: Icon(
          Icons.volume_up,
          color: color,
          size: 18,
        ),
      );
      name = color;
      artist = color;
    } else {
      leading = Container();
      name = Theme.of(context).textTheme.body1.color;
      artist = Theme.of(context).textTheme.caption.color;
    }
    return InkWell(
      onTap: () {
        quiet.play(music: music);
      },
      child: Container(
        padding: EdgeInsets.only(left: 8),
        height: _HEIGHT_MUSIC_TILE,
        decoration:
            BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor, width: 0.3))),
        child: Row(
          children: <Widget>[
            leading,
            Expanded(
                child: Text.rich(
              TextSpan(children: [
                TextSpan(text: music.name, style: TextStyle(color: name)),
              ]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  quiet.removeFromPlayingList(music);
                })
          ],
        ),
      ),
    );
  }
}
