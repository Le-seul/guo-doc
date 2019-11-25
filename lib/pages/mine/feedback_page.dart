import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/util/serviceLocator.dart';
import 'package:flutter_first/util/tel_service.dart';
import 'package:flutter_first/widgets/checkboxWidget.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  List<String> list = List();
  String emergePerson = '';
  TextEditingController _vCodeController = TextEditingController();
  final TelAndSmsService _service = locator<TelAndSmsService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('意见建议'),
        elevation: 0.0,
        backgroundColor: Color(0xff2CA687),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, top: 12, bottom: 12),
              color: Color(0xFFEEEEEE),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 3,
                    height: 12,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('人工服务'),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                _service.call('65256250');
              },
              child: Container(
                padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("拨打官方服务电话：65256250",style: TextStyle(fontSize: 15),),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "(周一至周日09:00-22:00)",
                          style: TextStyle(color: Colors.black26, fontSize: 12),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              margin: EdgeInsets.only(left: 15, right: 15),
              color: Colors.black26,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                _service.sendSms('65256250');
              },
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.message,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text('意见反馈',style: TextStyle(fontSize: 15),),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Color(0xFFEEEEEE),
              padding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
              child: Text('问题类型'),
            ),
            CheckBoxWidget('功能异常','不能正常使用现有功能'),
            Container(height: 1,color: Colors.black26,margin: EdgeInsets.only(left: 15,right: 20),),
            CheckBoxWidget('使用建议','用的不满意的地方都提出来吧'),
            Container(height: 1,color: Colors.black26,margin: EdgeInsets.only(left: 15,right: 20),),
            CheckBoxWidget('功能需求','现有功能不能满足'),
            Container(height: 1,color: Colors.black26,margin: EdgeInsets.only(left: 15,right: 20),),
            CheckBoxWidget('系统闪退','APP意外退出，闪退'),
            Container(
              color: Color(0xFFEEEEEE),
              padding: EdgeInsets.only(left: 15,top: 15,bottom: 15),
              child: Text('详细描述'),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 15),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  TextField(
                      onChanged: (val) {},
                      maxLines: 6,
                      controller: _vCodeController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: '如果您对我们有什么建议、想法和期望，请告诉我们',
                        hintStyle: TextStyle(fontSize: 14),
                        contentPadding: EdgeInsets.all(15.0),
                        border: InputBorder.none,
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  clickIcon();
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
                  ),
                  SizedBox(height: 5,),
                  Container(height: 1,color: Colors.black26,margin: EdgeInsets.only(left: 15,right: 20),),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      children: <Widget>[
                        Text('手机号'),
                        SizedBox(width: 10,),
                        Container(height: 20,width: 1,color: Colors.black26,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 25,
                            child: TextField(
                                onChanged: (val) {
                                  emergePerson = val;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  WhitelistingTextInputFormatter
                                      .digitsOnly, //只输入数字
                                  LengthLimitingTextInputFormatter(11) //限制长度
                                ],
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  hintText: '方便我们更快向你反馈问题哦',
                                  hintStyle: TextStyle(fontSize: 14),
                                  contentPadding: EdgeInsets.all(2.0),
                                  border: InputBorder.none,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )

                ],
              ),
            )


          ],
        ),
      ),

      bottomSheet: GestureDetector(
        child: Container(
          height: 45,
          alignment: Alignment.center,
          color: Color(0xff2CA687),
          child: Text(
            '立即提交',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        onTap: () {
        },
      ),
    );
  }

  FormData formData;
  clickIcon() async {
    var arr = new Map();
    List<UploadFileInfo> files = [];
    try {
      List<Asset> resultList = await MultiImagePicker.pickImages(
          maxImages: 9,
          enableCamera: true
      );
      if (resultList.length > 0) {
        formData = new FormData.from({});
        for(int i = 0; i< resultList.length; i ++) {
          Asset asset = resultList[i];
          ByteData byteData = await asset.requestThumbnail(200, 200);
          List<int> imageData = byteData.buffer.asUint8List();

          //获得一个uuud码用于给图片命名
          final String uuid = Uuid().v1();
          //获得应用临时目录路径
          final Directory _directory = await getTemporaryDirectory();
          final Directory _imageDirectory =
          await new Directory('${_directory.path}/image/')
              .create(recursive: true);
          var path = _imageDirectory.path;
          print('本次获得路径：${_imageDirectory.path}');
          //将压缩的图片暂时存入应用缓存目录
          File imageFile = new File('${path}originalImage_$uuid.png')
            ..writeAsBytesSync(imageData);
          setState(() {
            list.add(imageFile.path);
          });

          print('图片path：${imageFile.path}');
          var file = new UploadFileInfo(imageFile, '${path}originalImage_$uuid.png', contentType: ContentType.parse("image/png"));
          arr['file$i'] = file;
          print("file$i");
          formData["file$i"] = file;
        };
//        formData = new FormData.from(arr);
//        print("formData:${json.encode(arr)}");
      } else {

      }
    } catch (e) {
      print(e.message);
    }
  }
}
