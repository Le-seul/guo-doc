import 'package:flutter/material.dart';
import 'package:flutter_first/bean/message_entity.dart';
import 'package:flutter_first/common/common.dart';
import 'dart:convert';
import 'package:flutter_first/util/storage_manager.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<MessageEntity> messgaeList = List();

  @override
  void initState() {
    super.initState();

    List<String> textList =
        StorageManager.sharedPreferences.getStringList(Constant.messageHistory);
    print('消息记录2：${textList.toString()}');
    if (textList != null) {
      textList.forEach((item) {
        print('消息记录3$item');
        messgaeList.add(MessageEntity.fromJson(json.decode(item)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        backgroundColor: Color(0xff2CA687),
        title: Text(
          '消息通知',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () async{
              setState(() {
                messgaeList.clear();
              });
              await StorageManager.sharedPreferences
                  .remove(Constant.messageHistory);
            },
              child: Icon(Icons.adb)),
        ],
      ),
      body: messgaeList.isEmpty
          ? Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Text('暂无数据'))
          : Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: messgaeList.length,
                itemBuilder: (context, index) => _buildItem(messgaeList[index]),
              ),
            ),
    );
  }

  _buildItem(MessageEntity messageEntity) {
    return Container(
      padding: EdgeInsets.only(top: 10,left: 10,right: 10),
      child: Row(
        children: <Widget>[
          Text(messageEntity.content),
          SizedBox(
            width: 10,
          ),
          Text(messageEntity.model),
        ],
      ),
    );
  }
}
