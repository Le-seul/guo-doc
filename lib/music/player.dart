import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_first/bean/music.dart';
import 'package:flutter_first/music/channel_media_player.dart';
import 'package:flutter_first/music/lryic.dart';
import 'package:meta/meta.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//export 'package:quiet/component/player/bottom_player_bar.dart';
//export 'package:quiet/component/player/lryic.dart';

MusicPlayer quiet = MusicPlayer._private();

///key which save playing music to local preference
const String _PREF_KEY_PLAYING = "quiet_player_playing";

///key which save playing music list to local preference
const String _PREF_KEY_PLAYLIST = "quiet_player_playlist";

///key which save playing list token to local preference
const String _PREF_KEY_TOKEN = "quiet_player_token";

///key which save playing mode to local preference
const String _PREF_KEY_PLAY_MODE = "quiet_player_play_mode";

class MusicPlayer implements ValueNotifier<PlayerControllerState> {
  MusicPlayer._private() : super() {
    () async {
      //load former player information from SharedPreference
      var preference = await SharedPreferences.getInstance();
      Music current;
      List<Music> playingList;
      String token;
      PlayMode playMode;
      try {
        current = Music.fromMap(json.decode(preference.get(_PREF_KEY_PLAYING)));
        token = preference.get(_PREF_KEY_TOKEN);
        playingList = (json.decode(preference.get(_PREF_KEY_PLAYLIST)) as List).cast<Map>().map(Music.fromMap).toList();
        playMode = PlayMode.values[preference.getInt(_PREF_KEY_PLAY_MODE) ?? 0];
      } catch (e) {
        debugPrint(e.toString());
      }

      debugPrint("loaded : $current");
      debugPrint("loaded : $playingList");
      debugPrint("loaded : $token");
      debugPrint("loaded : $playMode");

      //save player info to SharedPreference
      addListener(() {
        if (current != value.current) {
          preference.setString(_PREF_KEY_PLAYING, json.encode(value.current, toEncodable: (e) => e.toMap()));
          current = value.current;
        }
        if (playingList != value.playingList) {
          preference.setString(_PREF_KEY_PLAYLIST, json.encode(value.playingList, toEncodable: (e) => e.toMap()));
          playingList = value.playingList;
        }
        if (playMode != value.playMode) {
          preference.setInt(_PREF_KEY_PLAY_MODE, value.playMode.index);
          playMode = value.playMode;
        }
        if (token != value.token) {
          preference.setString(_PREF_KEY_TOKEN, value.token);
          token = value.token;
        }
      });
      _controller.init(playingList, current, token, playMode ?? PlayMode.sequence);
    }();
  }

  PlayerController get _controller {
    if (Platform.isAndroid) {
      //目前播放音乐支持Android平台
      return PlayerController();
    } else {
      return FakePlayerController();
    }
  }

  ///play a single song
  Future<void> play({Music music}) async {
    music = music ?? value.current;
    if (music == null) {
      //null music, null current playing, this is an error state
      return;
    }
    if (!value.playingList.contains(music)) {
      //playing list do not contain music
      //so we insert this music to next of current playing
      await insertToNext(music);
    }
    await _performPlay(music);
  }

  ///insert a music to [value.current] next position
  Future<void> insertToNext(Music music) {
    return insertToNext2([music]);
  }

  Future<void> insertToNext2(List<Music> list) async {
    final playingList = List.of(value.playingList);
    playingList.removeWhere((m) => list.contains(m));

    final index = playingList.indexOf(value.current) + 1;
    playingList.insertAll(index, list);
    await _controller.updatePlaylist(playingList, value.token);
  }

  Future<void> removeFromPlayingList(Music music) async {
    if (!value.playingList.contains(music)) {
      return;
    }
    final list = List.of(value.playingList);
    list.remove(music);
    await _controller.updatePlaylist(list, value.token);
  }

  Future<void> playWithList(Music music, List<Music> list, String token) async {
    debugPrint("playWithList ${list.map((m) => m.name).join(",")}");
    debugPrint("playWithList token = $token");
    assert(list != null && token != null);
    if (list.isEmpty) {
      return;
    }
    if (music == null) {
      music = list.first;
    }
    await _controller.updatePlaylist(list, token);
    await _controller.playWith(music);
  }

  //perform to play music
  Future<void> _performPlay(Music music) async {
    assert(music != null);

//    if (value.current == music && _controller.value.playbackState != PlaybackState.none) {
//      return await _controller.setPlayWhenReady(true);
//    }
//    assert(music.audioStream != null && music.audioStream.isNotEmpty, "music url can not be null");
    return await _controller.playWith(music);
  }

  Future<void> pause() {
    return _controller.setPlayWhenReady(false);
  }

  void quiet() {
    _controller.dispose();
  }

  Future<void> playNext() async {
    await _controller.playNext();
  }

  Future<void> playPrevious() async {
    await _controller.playPrevious();
  }

  ///might be null
  Future<Music> getNext() {
    return _controller.getNext();
  }

  ///might be null
  Future<Music> getPrevious() {
    return _controller.getPrevious();
  }

  ///seek to position in milliseconds
  Future<void> seekTo(int position) {
    return _controller.seekTo(position);
  }

  Future<void> setVolume(double volume) {
    return _controller.setVolume(volume);
  }

  ///change playlist play mode
  ///[PlayMode]
  Future<void> changePlayMode() {
    PlayMode next = PlayMode.values[(value.playMode.index + 1) % 3];
    return _controller.setPlayMode(next);
  }

  @override
  PlayerControllerState get value => _controller.value;

  @override
  void addListener(VoidCallback listener) {
    _controller.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _controller.removeListener(listener);
  }

  @override
  void dispose() => _controller.dispose();

  @override
  bool get hasListeners => _controller.hasListeners;

  @override
  void notifyListeners() {
    _controller.notifyListeners();
  }

  @override
  set value(PlayerControllerState newValue) => throw "Unsupported operation";
}

class Quiet extends StatefulWidget {
  Quiet({@Required() this.child, Key key}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() => _QuietState();
}

class _QuietState extends State<Quiet> {
  PlayerControllerState value;

  void _onPlayerChange() {
    setState(() {
      value = quiet.value;
      if (value.hasError) {
        showSimpleNotification(Text("播放歌曲${value.current?.name ?? ""}失败!"),
            leading: Icon(Icons.error), background: Theme.of(context).errorColor);
      }
    });
  }

  @override
  void initState() {
    value = quiet.value;
    quiet.addListener(_onPlayerChange);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    quiet.removeListener(_onPlayerChange);
  }

  final _playingLyric = PlayingLyric(quiet);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: _playingLyric,
      child: PlayerState(
        child: widget.child,
        value: value,
      ),
    );
  }
}

class PlayerState extends InheritedModel<PlayerStateAspect> {
  PlayerState({@required Widget child, @required this.value}) : super(child: child);

  ///get current playing music
  final PlayerControllerState value;

  static PlayerState of(BuildContext context, {PlayerStateAspect aspect}) {
    return context.inheritFromWidgetOfExactType(PlayerState, aspect: aspect);
  }

  @override
  bool updateShouldNotify(PlayerState oldWidget) {
    return value != oldWidget.value;
  }

  @override
  bool updateShouldNotifyDependent(PlayerState oldWidget, Set<PlayerStateAspect> dependencies) {
    if (dependencies.contains(PlayerStateAspect.position) && (value.position != oldWidget.value.position)) {
      return true;
    }
    if (dependencies.contains(PlayerStateAspect.playbackState) &&
        ((value.playbackState != oldWidget.value.playbackState) ||
            (value.playWhenReady != oldWidget.value.playWhenReady || value.hasError != oldWidget.value.hasError))) {
      return true;
    }
    if (dependencies.contains(PlayerStateAspect.playlist) && (value.playingList != oldWidget.value.playingList)) {
      return true;
    }
    if (dependencies.contains(PlayerStateAspect.music) && (value.current != oldWidget.value.current)) {
      return true;
    }
    if (dependencies.contains(PlayerStateAspect.playMode) && (value.playMode) != oldWidget.value.playMode) {
      return true;
    }
    return false;
  }
}

enum PlayerStateAspect {
  ///the position of playing
  position,

  ///the playing state
  playbackState,

  ///the current playing
  music,

  ///the current playing playlist
  playlist,

  ///the play mode of playlist
  playMode,
}
