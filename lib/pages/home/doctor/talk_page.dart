import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/audioUrl.dart';
import 'package:flutter_first/bean/doctorInfo.dart';
import 'package:flutter_first/bean/imageUrl.dart';
import 'package:flutter_first/bean/message.dart';
import 'package:flutter_first/bean/orderNum.dart';
import 'package:flutter_first/bean/user_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/db/databaseHelper.dart';
import 'package:flutter_first/db/order_db.dart';
import 'package:flutter_first/event/login_event.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/doctor/graphic_consuitation.dart';
import 'package:flutter_first/util/dialog.dart';
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

import 'package:uuid/uuid.dart';

class TalkPage extends StatefulWidget {
  TalkPage(
      {Key key, @required this.orderId, @required this.type, this.offstage})
      : super(key: key);

  String type;
  bool offstage;
  String orderId;

  @override
  _TalkPageState createState() => new _TalkPageState();
}

class _TalkPageState extends State<TalkPage>
    with SingleTickerProviderStateMixin {
  var fsNode1 = new FocusNode();
  var _scrollController = new ScrollController();
  var _textInputController = new TextEditingController();

  List<Message> listMessage = List();
  Animation animation;
  Animation animationTalk;
  AnimationController controller;
  bool talkFOT = false;
  bool _isRecording = false;
  bool visivility = true;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;
  double slider_current_position = 0.0;
  double max_duration = 1.0;
  String _playSeconds = '00';
  var val;
  Autogenerated autogenerated = new Autogenerated();
  String leseul = "";
  FormData formData;
  bool offstage = true;
  DoctorInfo doctorInfo = new DoctorInfo();
  int num = 1;
  int residualTime = 0;
  String dataType = "";
  List<String> _rightList = new List();
  List<String> _leftList = new List();
  User user;
  StreamSubscription exitLogin;

  @override
  void initState() {

    if(widget.type == "fastphone"){
      print('电话咨询aaa');
      _getFastphoneReplyContent();
    }else{
      init();
      _getAllContent();
    }
    _getDoctorInfo();

    _leftList.add("assets/images/doctor/sound_left_3.png");
    _leftList.add("assets/images/doctor/sound_left_2.png");
    _leftList.add("assets/images/doctor/sound_left_1.png");
    _rightList.add("assets/images/doctor/sound_right_3.png");
    _rightList.add("assets/images/doctor/sound_right_2.png");
    _rightList.add("assets/images/doctor/sound_right_1.png");

    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
    initializeDateFormatting();
    exitLogin = eventBus.on<refreshNum>().listen((event) {
      listMessage.clear();
      _getAllContent();
      _getDoctorInfo();
      init();
    });
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

  _getFastphoneReplyContent(){
    DioUtils.instance.requestNetwork<Message>(
        Method.get, Api.GETFASTPHONEREPLYCONTENT,isList: true,
        queryParameters: {
          'orderId': widget.orderId,
        }, onSuccessList: (data) {
      setState(() {
        listMessage.addAll(data);
        print('获取电话咨询成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        print('获取电话咨询失败!');
      });
    });
  }


  _getAllContent() {
    DioUtils.instance.requestNetwork<Autogenerated>(
        Method.get, Api.GETALLCONTENT,
        queryParameters: {
          'orderId': widget.orderId,
        }, onSuccess: (data) {
      setState(() {
        autogenerated = data;
        if (widget.offstage) {
          visivility = false;
        } else if (autogenerated.interactionCount > 3) {
          visivility = false;
        }
        var time = new Map();

        var today = DateTime.now().toString().split('.')[0].substring(5,DateTime.now().toString().split('.')[0].length);
        for(Message message in autogenerated.contentList){
          if(today == message.createTime){
            message.createTime = "今天";
          }
          if(time.containsKey(message.createTime)){
            message.createTime = "";
          }else{
            time[message.createTime] = "";
          }

        }
        listMessage.addAll(autogenerated.contentList);
        _scrollController.animateTo(50.0 * (listMessage.length + 100),
            duration: new Duration(seconds: 1), curve: Curves.ease);
//        _getDoctorInfo();
        print('获取所有内容成功！');
      });
    }, onError: (code, msg) {
      setState(() {
        print('获取所有内容失败!');
      });
    });
  }

  _ask(String content, Message message) {
    print('开始提问');
    DioUtils.instance
        .requestNetwork<String>(Method.post, Api.USERASK, queryParameters: {
      'content': content,
      'orderId': widget.orderId,
    }, onSuccess: (data) {
      setState(() {
        listMessage.add(message);
        _scrollController.animateTo(50.0 * (listMessage.length + 100),
            duration: new Duration(seconds: 1), curve: Curves.ease);
      });
      print(data);
      print('提问成功！');
//        Toast.show('提问成功!');
    }, onError: (code, msg) {
      setState(() {
        print('提问失败！');
//        Toast.show('提问失败!');
      });
    });
  }

  static saveOrder(String orderId) async {
    StorageManager.sharedPreferences.setString(Constant.orderId, orderId);
    print('orderId:$orderId');
  }

  _getDoctorInfo() {
    print('orderId:${widget.orderId}');
    DioUtils.instance.requestNetwork<DoctorInfo>(Method.get, Api.GETDOCTERINFO,
        queryParameters: {'orderId': widget.orderId, 'type': widget.type},
        onSuccess: (data) {
      setState(() {
        doctorInfo = data;
        offstage = false;
        print('获取医生信息成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        print('获取医生信息失败!');
      });
    });
  }

  init() async {
    print('residualTime0:$residualTime');
    var db = OrderDb();
    int count = await db.updateOrder(widget.orderId, "0");
    print('residualTime1:$residualTime');
    OrderNum orderNum = await db.getOrder(widget.orderId);
    print('orderNum:$orderNum');
    print('residualTime2:$residualTime');
    int currentHour = DateTime.now().hour;
    setState(() {
      if(currentHour > residualTime ){
        residualTime = 24-(DateTime.now().hour-int.parse(orderNum.createTime));
        print('residualTime4:$residualTime');
      }else{
        residualTime = 24 - int.parse(orderNum.createTime) + currentHour;
        print('residualTime4:$residualTime');
      }
    });



  }

  @override
  void dispose() {
    controller.dispose();
    flutterSound.stopRecorder();
    exitLogin.cancel();
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
      final String uuid = Uuid().v1();
      var file = new UploadFileInfo(image, '$uuid.png',
          contentType: ContentType.parse("image/png"));

      FormData formData = new FormData.from({'file': file});
      _updateImage(image.path, formData);
    }
  }

  autoTalk(val, type, url) async {
    Message message;
    var today = DateTime.now().toString().split('.')[0].substring(5,DateTime.now().toString().split('.')[0].length);
    String content = "";
    if (type == 'image') {
      content = "[{\"type\":\"$type\",\"file\":\"$url\"}]";
      message = Message(
        localPath: url,
        createTime: today,
        content: content,
        type: 'TW',
      );
    } else if (type == 'audio') {
      num++;
      content = "[{\"type\":\"$type\",\"file\":\"$url\"}]";
      message = Message(
        isPlaying: false,
        createTime: today,
        time: _playSeconds,
        localPath: url,
        content: content,
        type: 'TW',
      );
    } else {
      content = "[{\"type\":\"$type\",\"text\":\"$val\"}]";
      print('content:$content');
      message = Message(
        content: content,
        createTime: today,
        type: 'TW',
      );
    }
    _ask(content, message);
    print('数据库：1');
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
              color: listMessage[index].type == "TW"?Colors.white:Colors.black,
              height: 1,
            ));
        break;
      case 'image':
        return GestureDetector(
          child: Image.network(val),
          onTap: () {
            showDialog<Null>(
                context: context, //BuildContext对象
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ShowbigImage(val);
                });
          },
        );
        break;

      case 'audio':
        return GestureDetector(
          child: Container(
            width: 80,
            child: Row(
              mainAxisAlignment: listMessage[index].type == 'TW'?MainAxisAlignment.end:MainAxisAlignment.start,
              children: <Widget>[
//                Text('${listMessage[index].time}\'\''),
                listMessage[index].type == 'TW'
                    ? VoiceAnimationImage(
                        _rightList,
                        width: 20,
                        height: 20,
                        isStop: listMessage[index].isPlaying,
                      )
                    : VoiceAnimationImage(
                        _leftList,
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
                gradient: LinearGradient(
                  colors: [Color(0xff65AEF9), Color(0xff3576F0)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: new BorderRadius.circular(10.0)),
            child: new LimitedBox(
              maxWidth: MediaQuery.of(context).size.width - 120.0,
              child: returnTalkType(dataType, val, index),
            )),
        new CircleAvatar(
          backgroundImage: NetworkImage(
              'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572447395389&di=5b0d1077d36473dd6906ed95b553af6c&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201806%2F12%2F20180612111056_2uHKU.thumb.700_0.jpeg'),
        ),
      ];
    } else if (listMessage[index].type == 'HF') {
      // 非本人的信息
      widgetList = [
        GestureDetector(
            child: CircleAvatar(
              backgroundImage: NetworkImage(doctorInfo.image ??
                  "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572450655242&di=f0409d79fb8bd4a4daa803137ad3f2a2&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201806%2F27%2F20180627170925_nsPVv.thumb.700_0.jpeg"),
            ),
            onTap: () {
              if (doctorInfo.image != null) {
                Router.push(context, Router.doctorPage, doctorInfo);
              }
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
        child: Column(
          children: <Widget>[
            listMessage[index].createTime == ""?Container():Container(
                child: Text(listMessage[index].createTime,style: TextStyle(color: Colors.black26),),
              margin: EdgeInsets.only(bottom: 15),
            ),

            Row(
                mainAxisAlignment: listMessage[index].type == 'HF'
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgetList),
          ],
        ));
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
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '问题详情',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  Offstage(
                    offstage: visivility,
                    child: GestureDetector(
                      onTap: () {
                        Router.push(
                            context, Router.evaluationPage, {'orderId': widget.orderId, 'doctorInfo': doctorInfo});
                      },
                      child: Text('评价'),
                    ),
                  )
                ],
              ),
            ),
            widget.offstage == true?Container(child: Text(' '),):Container(
                margin: EdgeInsets.only(bottom: 3),
                child: Text(
                  '$residualTime小时或${20-autogenerated.interactionCount??0}次对话后问题关闭',
                  style: TextStyle(color: Colors.black26, fontSize: 15),
                ),
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
                    doctorInfo.image == null
                        ? Container()
                        : Offstage(
                            offstage: offstage,
                            child: GestureDetector(
                              onTap: () {
                                Router.push(
                                    context, Router.doctorPage, doctorInfo);
                              },
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage:
                                          NetworkImage(doctorInfo.image),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              doctorInfo.name,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              doctorInfo.clinic,
                                              style: TextStyle(
                                                  color: Colors.black26),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              doctorInfo.title,
                                              style: TextStyle(
                                                  color: Colors.black26),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            GreenBgWidget(
                                              name: doctorInfo.levelTitle,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            GreenBgWidget(name: '快速回复'),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    Expanded(
                        child: ListView(
                      controller: _scrollController,
                      physics: ClampingScrollPhysics(),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(
                              left: 12, right: 12, top: 10, bottom: 10),
                          color: Colors.black12,
                          child: Text(
                            '医生的回复仅为建议，具体诊疗请前往医院进行',
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                        Container(
                            margin: new EdgeInsets.symmetric(horizontal: 20.0),
                            padding: new EdgeInsets.only(bottom: 50.0),
                            // width: MediaQuery.of(context).size.width - 40.0,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: listMessage.length,
                              itemBuilder: (context, index) =>
                                  _buildItem(index),
                            )),
                      ],
                    )),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Offstage(
                      offstage: widget.offstage,
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
                                    Expanded(child: Container(
                                      padding: new EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      width: MediaQuery.of(context).size.width -
                                          140.0,
                                      child: new TextField(
                                        focusNode: fsNode1,
                                        controller: _textInputController,
                                        decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            hintText: '输入你的信息...',
                                            hintStyle: new TextStyle(
                                                color: Color(0xFF7c7c7e))),
                                        onChanged: (text){
                                          setState(() {

                                          });
                                        },
                                        onSubmitted: (val) {
                                          if (val != '' && val != null) {
                                            autoTalk(val, 'text', '');
                                          }
                                          _textInputController.clear();
                                        },
                                      ),
                                    )),
                                    _textInputController.text == ''?IconButton(
                                      icon: Icon(Icons.add_circle_outline,
                                          color: Color(0xFF707072)),
                                      onPressed: () {
                                        setState(() {
                                          getImage();
                                        });
                                      },
                                    ):GestureDetector(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 8),
                                        padding: EdgeInsets.only(left: 12,right: 12,top: 7,bottom: 7),
                                        child: Text('发送',style: TextStyle(color: Colors.white),),
                                        decoration: new BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: new BorderRadius.circular(5.0)),
                                      ),
                                      onTap: (){
                                        setState(() {

                                        });
                                        if (_textInputController.text != '' && _textInputController.text != null) {
                                          autoTalk(_textInputController.text, 'text', '');
                                        }
                                        _textInputController.clear();
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 170.0,
                                        color: Color(0xFFededed),
                                        child: new Center(
                                            child: new AnimatedBuilder(
                                          animation: animationTalk,
                                          builder: (_, child) {
                                            return new GestureDetector(
                                              child: new CircleAvatar(
                                                radius:
                                                    animationTalk.value * 30,
                                                backgroundColor:
                                                    Color(0x306b6aba),
                                                child: new Center(
                                                  child: Icon(
                                                      Icons.keyboard_voice,
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
                                              },
                                            );
                                          },
                                        )),
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                    ))
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
      formData = new FormData.from({'file': file});
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
      _uploadAudio(formData);
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
    String path = await flutterSound.startPlayer(num);
    await flutterSound.setVolume(1.0);
    print('startPlayer1: $path');

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
          setState(() {
            listMessage[index].isPlaying = flutterSound.isPlaying;
            print('startPlayer2: $listMessage[index].isPlaying');
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

  _updateImage(String path, FormData formData) {
    DioUtils.instance.requestNetwork<ImageUrl>(Method.post, Api.UPLOADIMAGE,
        params: formData, isList: true, onSuccessList: (data) {
      setState(() {
        autoTalk(path, 'image', data[0].url);
        print('上传图片成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        print('上传图片失败!');
      });
    });
  }

  _uploadAudio(FormData formData) {
    DioUtils.instance.requestNetwork<AudioUrl>(Method.post, Api.UPLOADAUDIO,
        params: formData, isList: true, onSuccessList: (data) {
      setState(() {
        autoTalk('num$num', 'audio', data[0].url);
        Toast.show('上传音频成功!');
      });
    }, onError: (code, msg) {
      setState(() {
        Toast.show('上传音频失败!');
      });
    });
  }
}
