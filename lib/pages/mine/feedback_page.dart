import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/bean/imageUrl.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/util/serviceLocator.dart';
import 'package:flutter_first/util/tel_service.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/checkboxWidget.dart';
import 'package:flutter_first/widgets/my_card.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  List<String> list = List();

  String imageIdList = '';
  int groupValue = -1;
  String type = '';
  TextEditingController _textController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
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
        color: Color(0xffF9F9F9),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 3,
                    height: 15,
                    color: Color(0xff2CA687),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '人工服务',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _service.call('65256250');
              },
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: MyCard(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        loadAssetImage('phone.png',height: 22,width: 22),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "拨打官方服务电话：65256250",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "(周一至周日09：00-22：00)",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
//            Container(
//              height: 1,
//              width: double.infinity,
//              margin: EdgeInsets.only(left: 15, right: 15),
//              color: Colors.black26,
//            ),
//            SizedBox(
//              height: 20,
//            ),
//            GestureDetector(
//              onTap: () {
//                _service.sendSms('65256250');
//              },
//              child: Container(
//                width: double.infinity,
//                color: Colors.white,
//                padding: EdgeInsets.only(left: 15, right: 15),
//                child: Row(
//                  children: <Widget>[
//                    Icon(
//                      Icons.message,
//                      color: Colors.redAccent,
//                    ),
//                    SizedBox(
//                      width: 5,
//                    ),
//                    Text(
//                      '意见反馈',
//                      style: TextStyle(fontSize: 15),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            SizedBox(
//              height: 20,
//            ),
            Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 3,
                    height: 15,
                    color: Color(0xff2CA687),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '问题类型',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: MyCard(
                  child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 15,top: 3,bottom: 3),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '功能异常',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF4E4E4E)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 14,
                            width: 1,
                            color: Colors.black26,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            '不能正常使用现有功能',
                            style:
                                TextStyle(color: Colors.black26, fontSize: 14),
                          )),
                          Radio(
                              value: 0,
                              activeColor: Colors.redAccent,
                              groupValue:
                                  groupValue, //当value和groupValue一致的时候则选中
                              onChanged: (T) {
                                genderChange(T);
                              }),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Color(0xFFEEEEEE),
                      margin: EdgeInsets.only(left: 15, right: 20),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15,top: 3,bottom: 3),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '使用建议',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF4E4E4E)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 14,
                            width: 1,
                            color: Colors.black26,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            '用的不满意的地方都提出来吧',
                            style:
                                TextStyle(color: Colors.black26, fontSize: 14),
                          )),
                          Radio(
                              value: 1,
                              activeColor: Colors.redAccent,
                              groupValue:
                                  groupValue, //当value和groupValue一致的时候则选中
                              onChanged: (T) {
                                genderChange(T);
                              }),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Color(0xFFEEEEEE),
                      margin: EdgeInsets.only(left: 15, right: 20),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15,top: 3,bottom: 3),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '功能需求',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF4E4E4E)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 14,
                            width: 1,
                            color: Colors.black26,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            '现有功能不能满足',
                            style:
                                TextStyle(color: Colors.black26, fontSize: 14),
                          )),
                          Radio(
                              value: 2,
                              activeColor: Colors.redAccent,
                              groupValue:
                                  groupValue, //当value和groupValue一致的时候则选中
                              onChanged: (T) {
                                genderChange(T);
                              }),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Color(0xFFEEEEEE),
                      margin: EdgeInsets.only(left: 15, right: 20),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15,top: 3,bottom: 3),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '系统闪退',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF4E4E4E)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 14,
                            width: 1,
                            color: Colors.black26,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            'APP意外退出，闪退',
                            style:
                                TextStyle(color: Colors.black26, fontSize: 14),
                          )),
                          Radio(
                              value: 3,
                              activeColor: Colors.redAccent,
                              groupValue:
                                  groupValue, //当value和groupValue一致的时候则选中
                              onChanged: (T) {
                                genderChange(T);
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 3,
                    height: 15,
                    color: Color(0xff2CA687),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '详细描述',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: MyCard(
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      TextField(
                          onChanged: (val) {},
                          maxLines: 5,
                          controller: _textController,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: '如果您对我们有什么建议、想法和期望，请告诉我们...',
                            hintStyle: TextStyle(fontSize: 12),
                            border: InputBorder.none,
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(
                                  list.length + 1,
                                  (index) => index == 0
                                      ? GestureDetector(
                                          child: loadAssetImage('camera.png',height: 60,width: 60),
                                          onTap: () {
                                            clickIcon();
                                          },
                                        )
                                      : Image.file(
                                          File(list[index - 1]),
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.fill,
                                        )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 3,
                    height: 15,
                    color: Color(0xff2CA687),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '您的电话',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: MyCard(
                child: Container(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 12,bottom: 12),
                  child: Row(
                    children: <Widget>[
                      Text('手机号'),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 14,
                        width: 1,
                        color: Colors.black26,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 25,
                          child: TextField(
                              controller: _phoneController,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter
                                    .digitsOnly, //只输入数字
                                LengthLimitingTextInputFormatter(11) //限制长度
                              ],
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: '方便我们更快向你反馈问题哦',
                                hintStyle: TextStyle(fontSize: 13),
                                contentPadding: EdgeInsets.all(2.0),
                                border: InputBorder.none,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                if (type == '') {
                  Toast.show('请选择问题类型');
                  return;
                } else if (_textController.text == null ||
                    _textController.text == '') {
                  Toast.show('请输入详情描述');
                  return;
                } else if (formData == null) {
                  _updateProposal();
                } else {
                  updateImage();
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                padding: EdgeInsets.only(top: 13, bottom: 13),
                decoration: BoxDecoration(
                    color: Color(0xFFFD4141), borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  '立即提交',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
//      bottomSheet: GestureDetector(
//        child: Container(
//          height: 45,
//          alignment: Alignment.center,
//          color: Color(0xff2CA687),
//          child: Text(
//            '立即提交',
//            style: TextStyle(color: Colors.white, fontSize: 18),
//          ),
//        ),
//        onTap: () {
//          if (type == '') {
//            Toast.show('请选择问题类型');
//            return;
//          } else if (_textController.text == null ||
//              _textController.text == '') {
//            Toast.show('请输入详情描述');
//            return;
//          } else if (formData == null) {
//            _updateProposal();
//          } else {
//            updateImage();
//          }
//        },
//      ),
    );
  }

  genderChange(val) {
    this.setState(() {
      groupValue = val;
      if (groupValue == 0) {
        type = 'GNYC';
      } else if (groupValue == 1) {
        type = 'SYJY';
      } else if (groupValue == 2) {
        type = 'GNXQ';
      } else if (groupValue == 3) {
        type = 'XTST';
      }
    });
  }

  FormData formData;

  clickIcon() async {
    var arr = new Map();
    List<UploadFileInfo> files = [];
    try {
      List<Asset> resultList =
          await MultiImagePicker.pickImages(maxImages: 9, enableCamera: true);
      if (resultList.length > 0) {
        formData = new FormData.from({});
        for (int i = 0; i < resultList.length; i++) {
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
          var file = new UploadFileInfo(
              imageFile, '${path}originalImage_$uuid.png',
              contentType: ContentType.parse("image/png"));
          arr['file$i'] = file;
          print("file$i");
          formData["file$i"] = file;
        }
        ;
//        formData = new FormData.from(arr);
//        print("formData:${json.encode(arr)}");
      } else {}
    } catch (e) {
      print(e.message);
    }
  }

  updateImage() {
    DioUtils.instance.requestNetwork<ImageUrl>(Method.post, Api.UPLOADIMAGE,
        params: formData, isList: true, onSuccessList: (data) {
      setState(() {
        for (ImageUrl imageUrl in data) {
          imageIdList = imageUrl.id + ',' + imageIdList;
        }
        imageIdList = imageIdList.substring(0, imageIdList.length - 1);
        print('上传图片成功!');
        _updateProposal();
      });
    }, onError: (code, msg) {
      setState(() {
        print('上传图片失败!');
      });
    });
  }

  _updateProposal() {
    print(
        'content:${_textController.text};imageIdList:${imageIdList};type:$type;phone:${_phoneController.text}');
    DioUtils.instance.requestNetwork<String>(Method.post, Api.SAVESUGGESTION,
        queryParameters: {
          'content': _textController.text,
          'imageIdList': imageIdList,
          'type': type,
          'phone': _phoneController.text
        }, onSuccess: (data) {
      Toast.show('上传建议成功!');
    }, onError: (code, msg) {
      Toast.show('上传建议失败!');
    });
  }
}
