import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GraphicConsultation extends StatefulWidget {
  @override
  _GraphicConsultationState createState() => _GraphicConsultationState();
}

class _GraphicConsultationState extends State<GraphicConsultation> {
  bool offstage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          '快速提问',
          style: new TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 45,
            color: Color(0xFFFFEBEE),
            alignment: Alignment.center,
            child: Text(
              '重要通知：文字描述文字描述文字描述文字描述',
              style: TextStyle(color: Colors.red),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 15),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                TextField(
                    onChanged: (val) {},
                    maxLines: 10,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: '请简要描述需要咨询的内容，以及期待达到的咨询效果。',
                      contentPadding: EdgeInsets.all(10.0),
                      border: InputBorder.none,
                    )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: <Widget>[
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                                list.length+1,
                                    (index) => index == 0 ?GestureDetector(
                                      child: Image.asset(
                                        'assets/images/add.png',
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.fill,
                                      ),
                                      onTap: () {
                                        getImage();
                                      },
                                    ):Image.file(
                                      File(list[index-1]),
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.fill,
                                    )),
                          ),
                        ],
                      ),
//                    Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: list),
                      SizedBox(
                        width: 10,
                      ),
                      Offstage(
                          offstage: offstage,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 80,
                            child: Text(
                              '图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述',
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomSheet: Container(
        height: 40,
        color: Colors.green,
        alignment: Alignment.center,
        child: Text(
          '立即提交',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  List<String> list = List() ;
  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        offstage = true;
        list.add(image.path);
      });
    }
  }

}
