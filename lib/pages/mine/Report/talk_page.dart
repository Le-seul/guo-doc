import 'package:flutter/material.dart';
import 'package:flutter_first/bean/user_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<Widget> talkWidgetList = <Widget>[];
  List<Map> talkHistory = [];
  Animation animationTalk;
  AnimationController controller;
  User user;

  @override
  void initState() {
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
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  List<String> returnTalkList = [
    '这是自动留言,我的手机不在身边, 有事请直接Call我....',
    '呵呵,真好笑!!!',
    '你最近好吗?',
    '我一不小心笑出来猪叫声。',
    'hohohohohoho, boom!',
    '流水窗前，树影迷离，人影如尘，来来去去。那些看似匆忙的背影，不知从哪里来，又行将哪去。人生如行路，一路艰辛，一路风景，而你的目光所及之处，就是你的人生境界。',
  ];

  getTalkList() {
    List<Widget> widgetList = [];

    for (var i = 0; i < talkHistory.length; i++) {
      widgetList.add(returnTalkItem(talkHistory[i]));
    }

    setState(() {
      _scrollController.animateTo(50.0 * talkHistory.length + 100,
          duration: new Duration(seconds: 1), curve: Curves.ease);
      talkWidgetList = widgetList;
    });
  }

  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      autoTalk(image, 'image');
    }
  }

  autoTalk(val, type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mySelf = json.decode(prefs.getString('userInfo'));

    talkHistory.add({
      'name': user.userName,
      'id': '1',
      'imageUrl': user.imageUrl,
      'content': val,
      'type': type // image text
    });
    getTalkList();

    Future.delayed(new Duration(seconds: 1), () {
      var item = {
        'name': '张三',
        'id': '2',
        'imageUrl': user.imageUrl2,
        'content': returnTalkList[talkHistory.length % 5],
        'type': 'text'
      };
      talkHistory.add(item);
      getTalkList();
    });
  }

  returnTalkType(type, val) {
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
        return new Image.file(val);
        break;
      case 'text':
        return new Text(val);
        break;
    }
  }

  returnTalkItem(item) {
    List<Widget> widgetList = [];

    if (item['id'] == '1') {
      // 本人的信息
      widgetList = [
        new Container(
            margin: new EdgeInsets.only(right: 20.0),
            padding: new EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
                color: Color(0xFFebebf3),
                borderRadius: new BorderRadius.circular(10.0)),
            child: new LimitedBox(
              maxWidth: MediaQuery.of(context).size.width - 120.0,
              child: returnTalkType(item['type'], item['content']),
            )),
        new CircleAvatar(
          backgroundImage: new NetworkImage('${item['imageUrl']}'),
        ),
      ];
    } else {
      // 非本人的信息
      widgetList = [
        new CircleAvatar(
          backgroundImage: new NetworkImage('${item['imageUrl']}'),
        ),
        new Container(
          margin: new EdgeInsets.only(left: 20.0),
          padding: new EdgeInsets.all(10.0),
          decoration: new BoxDecoration(
              color: Color(0xFFebebf3),
              borderRadius: new BorderRadius.circular(10.0)),
          child: new LimitedBox(
              maxWidth: MediaQuery.of(context).size.width - 120.0,
              child: returnTalkType(item['type'], item['content'])),
        ),
      ];
    }

    return new Container(
        width: MediaQuery.of(context).size.width - 120.0,
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
            mainAxisAlignment: '2' == item['id']
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widgetList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          '张警官',
          style: new TextStyle(fontSize: 20.0),
        ),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.add, size: 30.0),
            onPressed: () {

            },
          )
        ],
        centerTitle: true,
      ),
      body: new Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                padding: new EdgeInsets.only(bottom: 50.0),
                // width: MediaQuery.of(context).size.width - 40.0,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  controller: _scrollController,
                  children: talkWidgetList,
                ),
              ),
              new Positioned(
                bottom: 0,
                left: 0,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Color(0xFFebebf3),
                  child: Row(
                    children: <Widget>[
                      new Container(
                        width: 40.0,
                        color: Color(0xFFaaaab6),
                        child: new IconButton(
                          icon: new Icon(Icons.keyboard_voice),
                          onPressed: () {
                            setState(() {
                              fsNode1.unfocus();
                            });
                          },
                        ),
                      ),
                      new Container(
                        padding: new EdgeInsets.symmetric(horizontal: 10.0),
                        width: MediaQuery.of(context).size.width - 140.0,
                        child: new TextField(
                          focusNode: fsNode1,
                          controller: _textInputController,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: '输入你的信息...',
                              hintStyle:
                                  new TextStyle(color: Color(0xFF7c7c7e))),
                          onSubmitted: (val) {
                            if (val != '' && val != null) {
                              getTalkList();
                              autoTalk(val, 'text');
                            }
                            _textInputController.clear();
                          },
                        ),
                      ),
                      new IconButton(
                        icon: Icon(Icons.insert_emoticon, color: Color(0xFF707072)),
                        onPressed: (){

                        },
                      ),
                      new IconButton(
                        icon: Icon(Icons.add_circle_outline,
                            color: Color(0xFF707072)),
                        onPressed: () {
                          getImage();
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
