import 'package:flutter/material.dart';
import 'package:flutter_first/bean/user_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/util/router.dart';
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
    talkWidgetList.add(
      Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
        color: Colors.black12,
        child: Text(
          '医生的回复仅为建议，具体诊疗请前往医院进行',
          style: TextStyle(color: Colors.black26),
        ),
      ),
    );
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
    '流水窗前，树影迷离，人影如尘，来来去去。那些看似匆忙的背影，不知从哪里来，又行将哪去。人生如行路，一路艰辛，一路风景，而你的目光所及之处，就是你的人生境界。',
    '这是自动留言,我的手机不在身边, 有事请直接Call我....',
    '呵呵,真好笑!!!',
    '你最近好吗?',
    '我一不小心笑出来猪叫声。',
    '我和我的祖国，一刻也不能分离!',
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
            margin: new EdgeInsets.only(right: 20.0, top: 2),
            padding: item['type'] == 'image'
                ? EdgeInsets.all(0.0)
                : EdgeInsets.all(10.0),
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
        GestureDetector(
          child: CircleAvatar(
            backgroundImage:
            AssetImage('assets/images/beijing2.jpg'),
          ),
          onTap: (){
            Router.pushNoParams(context, Router.doctorPage);
          }
        ),
        Container(
          margin: new EdgeInsets.only(left: 20.0, top: 2),
          padding: item['type'] == 'image'
              ? EdgeInsets.all(0.0)
              : EdgeInsets.all(10.0),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgetList));
  }

  _nameWidget(String name) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
      child: Text(name,
          style: TextStyle(
            color: Colors.white,
          )),
      decoration: BoxDecoration(
          color: Color(0xff2CA687), borderRadius: BorderRadius.circular(5)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              '问题详情',
              style: TextStyle(fontSize: 20, color: Colors.black),
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
          setState(() {
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
                    GestureDetector(
                      onTap: (){
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
                                    _nameWidget('三级医院'),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    _nameWidget('快速回复'),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    _nameWidget('专业有效'),
                                  ],
                                )
                              ],
                            )
                          ],
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
                        child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          controller: _scrollController,
                          children: talkWidgetList,
                        ),
                      ),
                    )
                  ],
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
                        Expanded(
                          flex: 1,
                          child: Container(
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
                        ),
                        IconButton(
                          icon: Icon(Icons.insert_emoticon,
                              color: Color(0xFF707072)),
                          onPressed: () {},
                        ),
                        IconButton(
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
      ),
      resizeToAvoidBottomPadding: true, //输入框抵住键盘 内容不随键盘滚动
    );
  }
}
