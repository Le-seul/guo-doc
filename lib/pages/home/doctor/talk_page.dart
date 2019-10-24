import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/audioUrl.dart';
import 'package:flutter_first/bean/doctorInfo.dart';
import 'package:flutter_first/bean/message.dart';
import 'package:flutter_first/bean/user_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/db/databaseHelper.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/util/voice_animation_image.dart';
import 'package:flutter_first/widgets/greenBgWidget.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class TalkPage extends StatefulWidget {
  TalkPage({Key key, this.detail}) : super(key: key);
  final detail;

  @override
  _TalkPageState createState() => new _TalkPageState();
}

class _TalkPageState extends State<TalkPage>
    with SingleTickerProviderStateMixin {
  var fsNode1 = new FocusNode();
  var _scrollController = new ScrollController();
  var _textInputController = new TextEditingController();

  List<Message> listMessage = List();
//  List<Message> list = List();
  Animation animation;
  Animation animationTalk;
  AnimationController controller;
  bool talkFOT = false;
  bool _isRecording = false;
//  bool _isPlaying = false;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;
  double slider_current_position = 0.0;
  double max_duration = 1.0;
  String _playSeconds = '00';
  var val;
  bool offstage = true;
  DoctorInfo doctorInfo;
  String orderId;
  int num = 1;
  String dataType;
  List<String> _assetList = new List();
  User user;

  @override
  void initState() {
    init();
    _assetList.add("assets/images/doctor/sound_right_3.png");
    _assetList.add("assets/images/doctor/sound_right_2.png");
    _assetList.add("assets/images/doctor/sound_right_1.png");

    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
    initializeDateFormatting();

    user = User.fromJson(json
        .decode(StorageManager.sharedPreferences.getString(Constant.userInfo)));

    controller = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);
    animationTalk = new Tween(begin: 1.0, end: 1.5).animate(controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          controller.reverse();
        } else if (state == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    fsNode1.addListener(_focusListener);
    super.initState();
  }

  _focusListener() async {
    if (fsNode1.hasFocus) {
      setState(() {
        talkFOT = false;
      });
    }
  }

  _create(String content) {
    Map<String, dynamic> _map =
        json.decode(content.substring(1, content.length - 1));
    String text = _map['text'];
    if (text.length < 10) {
      Toast.show('请输入超过10个字！');
      return;
    }
    DioUtils.instance.requestNetwork<OrderId>(Method.post, Api.CREATEORDER,
        queryParameters: {
          'content': content,
        }, onSuccess: (data) {
      setState(() {
        orderId = data.orderId;
        saveOrder(orderId);
        print('orderId成功：$orderId');
        _getLastContent();
        Toast.show('获取订单成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        print('orderId失败：$orderId');
        Toast.show('获取订单失败!');
      });
    });
  }

  _ask(String content) {
    DioUtils.instance
        .requestNetwork<String>(Method.post, Api.USERASK, queryParameters: {
      'content': content,
      'orderId': orderId,
    }, onSuccess: (data) {
      setState(() {
        print(data);
        Toast.show('提问成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show('提问失败!');
      });
    });
  }

  static saveOrder(String orderId) async {
    StorageManager.sharedPreferences.setString(Constant.orderId, orderId);
    print('orderId:$orderId');
  }

  _getLastContent() {
    DioUtils.instance.requestNetwork<Message>(
        Method.get, Api.GETLASTINTERACTIONCONTENT,
        queryParameters: {
          'orderId': orderId,
        }, onSuccess: (data) {
      setState(() {
        print('456订单');
        listMessage.add(data);
        _getDoctorInfo();
        Toast.show('获取最后一次交互成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show('获取最后一次交互失败!');
      });
    });
  }

  _getDoctorInfo() {
    DioUtils.instance.requestNetwork<DoctorInfo>(Method.get, Api.GETDOCTERINFO,
        queryParameters: {
          'orderId': orderId,
        }, onSuccess: (data) {
      setState(() {
        print('789订单');
        doctorInfo = data;
        offstage = false;
        Toast.show('获取医生信息成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show('获取医生信息失败!');
      });
    });
  }

  init() async {
    orderId =
        await StorageManager.sharedPreferences.getString(Constant.orderId);
    var db = DatabaseHelper();
    List<Map> list = await db.getAllMessages();
    setState(() {
      listMessage = list.map<Message>((item) => Message.fromMap(item)).toList();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    flutterSound.stopRecorder();
    super.dispose();
  }

  List<String> returnTalkList = [
    '流水窗前，树影迷离，人影如尘，来来去去。那些看似匆忙的背影，不知从哪里来，又行将哪去。人生如行路，一路艰辛，一路风景，而你的目光所及之处，就是你的人生境界。',
    '这是自动留言,我的手机不在身边, 有事请直接Call我....',
    '呵呵,真好笑!!!',
    '你最近好吗?',
    '我一不小心笑出来猪叫声。',
    '我和我的祖国，一刻也不能分离!',
  ];

  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      autoTalk(image.path, 'image');
    }
  }

  autoTalk(val, type) async {
    Message message;
    String content = "";
    if (type == 'image') {
      content = "[{\"type\":\"$type\",\"file\":\"$val\"}]";
      message = Message(
        content: content,
        type: 'TW',
      );
    } else if (type == 'audio') {
      num++;
      content = "[{\"type\":\"$type\",\"file\":\"$val\"}]";
      message = Message(
        isPlaying: false,
        time: _playSeconds,
        content: content,
        type: 'TW',
      );
    } else {
      content = "[{\"type\":\"$type\",\"text\":\"$val\"}]";
      print('content:$content');
      message = Message(
        content: content,
        type: 'TW',
      );
    }
    if (orderId == null) {
      print('orderId:$orderId');
      _create(content);
    } else {
      _ask(content);
    }
    setState(() {
      listMessage.add(message);
      _scrollController.animateTo(50.0 * listMessage.length + 100,
          duration: new Duration(seconds: 1), curve: Curves.ease);
    });
    print('数据库：1');

    autoCallBack();
    var db = DatabaseHelper();
    int count = await db.saveMessage(message);
    List<Map> list = await db.getAllMessages();
    print('数据库：${list}');
  }

  autoCallBack() {
    Future.delayed(new Duration(seconds: 1), () async {
      var data = {
        'type': 'text',
        'text': returnTalkList[listMessage.length % 5],
      };

      String content =
          "[{\"type\":\"text\",\"text\":\"${returnTalkList[listMessage.length % 5]}\"}]";
      Message message = Message(
        content: content,
        type: 'HF',
      );
      var db = DatabaseHelper();
      int count = await db.saveMessage(message);
      setState(() {
        listMessage.add(message);
        _scrollController.animateTo(50.0 * listMessage.length + 100,
            duration: new Duration(seconds: 1), curve: Curves.ease);
      });
    });
  }

  returnTalkType(type, val, index) {
    switch (type) {
      case 'text':
        return new Text(val,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 100,
            textAlign: TextAlign.left,
            style: new TextStyle(
              height: 1,
            ));
        break;
      case 'image':
        return listMessage[index].type == 'TW'
            ? Image.file(File(val))
            : Image.network(val);
        break;
      case 'audio':
        return GestureDetector(
          child: Container(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('${listMessage[index].time}\'\''),
                VoiceAnimationImage(
                  _assetList,
                  width: 20,
                  height: 20,
                  isStop: listMessage[index].isPlaying,
                ),
              ],
            ),
          ),
          onTap: () {
            setState(() {
              print('val:$val');
              startPlayer(val, index);
            });
          },
        );
        break;
    }
  }

  _buildItem(int index) {
//    if(index == 0){
//      return Container(
//        padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
//        color: Colors.black12,
//        child: Text(
//          '医生的回复仅为建议，具体诊疗请前往医院进行',
//          style: TextStyle(color: Colors.black26),
//        ),
//      );
//    }
    List<Widget> widgetList = [];
    Map<String, dynamic> _map = json.decode(listMessage[index]
        .content
        .substring(1, listMessage[index].content.length - 1));

    dataType = _map['type'];
    if (dataType == 'text') {
      val = _map['text'];
    } else {
      val = _map['file'];
    }

    if (listMessage[index].type == 'TW') {
      widgetList = [
        new Container(
            margin: new EdgeInsets.only(right: 20.0, top: 2),
            padding: dataType == 'image'
                ? EdgeInsets.all(0.0)
                : EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
                color: Color(0xFFebebf3),
                borderRadius: new BorderRadius.circular(10.0)),
            child: new LimitedBox(
              maxWidth: MediaQuery.of(context).size.width - 120.0,
              child: returnTalkType(dataType, val, index),
            )),
        new CircleAvatar(
          backgroundImage: new NetworkImage(
              'http://ygyd.aireading.top/jeecg/api/image.do?getImage&imageId=4'),
        ),
      ];
    } else if (listMessage[index].type == 'HF') {
      // 非本人的信息
      widgetList = [
        GestureDetector(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/beijing2.jpg'),
            ),
            onTap: () {
              Router.pushNoParams(context, Router.doctorPage);
            }),
        Container(
            margin: new EdgeInsets.only(left: 20.0, top: 2),
            padding: dataType == 'image'
                ? EdgeInsets.all(0.0)
                : EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
                color: Color(0xFFebebf3),
                borderRadius: new BorderRadius.circular(10.0)),
            child: new LimitedBox(
              maxWidth: MediaQuery.of(context).size.width - 120.0,
              child: returnTalkType(dataType, val, index),
            )),
      ];
    }

    return Container(
        width: MediaQuery.of(context).size.width - 120.0,
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
            mainAxisAlignment: listMessage[index].type == 'HF'
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgetList));
//    return
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 30,),
                  Text(
                      '问题详情',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                 GestureDetector(
                   onTap: (){
                     Router.pushNoParams(context, Router.evaluationPage);
                   },
                   child: Text('评价'),
                 )

                ],
              ),
            ),
            Text(
              '22小时或9次对话后问题关闭',
              style: TextStyle(color: Colors.black26, fontSize: 15),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          controller.reset();
          controller.stop();
          setState(() {
            talkFOT = false;
            fsNode1.unfocus();
          });
        },
        child: Container(
            color: Color(0xFFF9F9F9),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Offstage(
                      offstage: offstage,
                      child: GestureDetector(
                        onTap: () {
                          Router.pushNoParams(context, Router.doctorPage);
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(15),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage:
                                    AssetImage('assets/images/beijing2.jpg'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        '季洪菊',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '产科',
                                        style: TextStyle(color: Colors.black26),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '副主任医师',
                                        style: TextStyle(color: Colors.black26),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      GreenBgWidget(name: '三级医院',),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      GreenBgWidget(name:'快速回复'),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      GreenBgWidget(name:'专业有效'),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Container(
                          margin: new EdgeInsets.symmetric(horizontal: 20.0),
                          padding: new EdgeInsets.only(bottom: 50.0),
                          // width: MediaQuery.of(context).size.width - 40.0,
                          child: ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: listMessage.length,
                            itemBuilder: (context, index) => _buildItem(index),
                          )),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      color: Color(0xFFebebf3),
                      child: new Column(
                        children: <Widget>[
                          new Offstage(
                            offstage: talkFOT,
                            child: new Row(
                              children: <Widget>[
                                new Container(
                                  width: 40.0,
                                  color: Color(0xFFaaaab6),
                                  child: new IconButton(
                                    icon: new Icon(Icons.keyboard_voice),
                                    onPressed: () {
                                      setState(() {
                                        fsNode1.unfocus();
                                        talkFOT = !talkFOT;
                                      });
                                    },
                                  ),
                                ),
                                new Container(
                                  padding: new EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  width:
                                      MediaQuery.of(context).size.width - 140.0,
                                  child: new TextField(
                                    focusNode: fsNode1,
                                    controller: _textInputController,
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '输入你的信息...',
                                        hintStyle: new TextStyle(
                                            color: Color(0xFF7c7c7e))),
                                    onSubmitted: (val) {
                                      if (val != '' && val != null) {
                                        autoTalk(val, 'text');
                                      }
                                      _textInputController.clear();
                                    },
                                  ),
                                ),
                                new IconButton(
                                  icon: Icon(Icons.insert_emoticon,
                                      color: Color(0xFF707072)),
                                  onPressed: () {},
                                ),
                                new IconButton(
                                  icon: Icon(Icons.add_circle_outline,
                                      color: Color(0xFF707072)),
                                  onPressed: () {
                                    setState(() {
                                      getImage();
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          new Offstage(
                              // 录音按钮
                              offstage: !talkFOT,
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 170.0,
                                    color: Color(0xFFededed),
                                    child: new Center(
                                        child: new AnimatedBuilder(
                                      animation: animationTalk,
                                      builder: (_, child) {
                                        return new GestureDetector(
                                          child: new CircleAvatar(
                                            radius: animationTalk.value * 30,
                                            backgroundColor: Color(0x306b6aba),
                                            child: new Center(
                                              child: Icon(Icons.keyboard_voice,
                                                  size: 30.0,
                                                  color: Color(0xFF6b6aba)),
                                            ),
                                          ),
                                          onLongPress: () {
                                            controller.forward();
                                            startRecorder('num$num');
                                          },
                                          onLongPressUp: () {
                                            stopRecorder();
                                            controller.reset();
                                            controller.stop();
                                            autoTalk('num$num', 'audio');
                                          },
                                        );
                                      },
                                    )),
                                  ),
                                ],
                              )),
                        ],
                      )),
                )
              ],
            )),
      ),
      resizeToAvoidBottomPadding: true, //输入框抵住键盘 内容不随键盘滚动
    );
  }

  void startRecorder(String num) async {
    try {
      String path = await flutterSound.startRecorder(num, bitRate: 320000);
      File audioFile = new File(path);
      var file = new UploadFileInfo(audioFile, '${path}$num.mp3',
          contentType: ContentType.parse("video/mp3"));
      FormData formData = new FormData.from({'file': file});
      uploadAudio(formData);
      print("数据$path");
      _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(
            e.currentPosition.toInt(),
            isUtc: true);
        // print("时长$date");
        String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
        _playSeconds = txt.substring(3, 5);
      });
    } catch (err) {
      print('startRecorder error: $err');
    }
  }

  void stopRecorder() async {
    try {
      String result = await flutterSound.stopRecorder();
      print('停止录音返回结果: $result');

      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
      if (_dbPeakSubscription != null) {
        _dbPeakSubscription.cancel();
        _dbPeakSubscription = null;
      }

      this.setState(() {
        _isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  void startPlayer(String num, int index) async {
    String path = await flutterSound.startPlayer('/storage/emulated/0/$num');
    File file = await new File(path);
    List contents = await file.readAsBytesSync();

    // return print("file文件：$contents");
    await flutterSound.setVolume(1.0);
    print('startPlayer: $path');

    try {
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          slider_current_position = e.currentPosition;
          max_duration = e.duration;

          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt(),
              isUtc: true);
          print('date: $date');
          String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
          print('txt: $txt');
//          returnTalkType(null, 'voice');
          this.setState(() {
            listMessage[index].isPlaying = flutterSound.isPlaying;
//            print('_isPlaying: $_isPlaying');
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

      this.setState(() {
//        this._isPlaying = false;
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void resumePlayer() async {
    String result = await flutterSound.resumePlayer();
    print('resumePlayer: $result');
  }

  uploadAudio(FormData formData) {
    DioUtils.instance.requestNetwork<AudioUrl>(Method.post, Api.UPLOADAUDIO,
        params: formData, onSuccess: (data) {
      setState(() {
        Toast.show('上传成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show('上传失败!');
      });
    });
  }
}
