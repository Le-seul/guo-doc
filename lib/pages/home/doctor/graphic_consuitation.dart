import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/imageUrl.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class GraphicConsultation extends StatefulWidget {
  @override
  _GraphicConsultationState createState() => _GraphicConsultationState();
}

class _GraphicConsultationState extends State<GraphicConsultation> {
  bool offstage = false;
  List<String> list = List();


  @override
  void initState() {

  }


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
//                    Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: list),
//                      SizedBox(
//                        width: 10,
//                      ),
//                      Offstage(
//                          offstage: offstage,
//                          child: Container(
//                            width: MediaQuery.of(context).size.width - 80,
//                            child: Text(
//                              '图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述图片描述',
//                            ),
//                          )),
                )
              ],
            ),
          )
        ],
      ),
      bottomSheet: GestureDetector(
        child: Container(
          height: 40,
          color: Colors.green,
          alignment: Alignment.center,
          child: Text(
            '立即提交',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        onTap: (){
          updateImage();
        },
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
  FormData formData;
  clickIcon() async {

    List<UploadFileInfo> files = [];
    try {
      List<Asset> resultList = await MultiImagePicker.pickImages(
          maxImages: 9,
          enableCamera: true
      );
      if (resultList.length > 0) {
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
          files.add(file);
          formData = new FormData.from({
            'file': file
          });
        };

      } else {

      }
    } catch (e) {
      print(e.message);
    }
  }

  updateImage(){
    DioUtils.instance
        .requestNetwork<ImageUrl>(Method.post, Api.UPLOADIMAGE,params: formData,
        onSuccess: (data) {
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
