
import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/storage_manager.dart';
//import 'package:flutter_seekbar/flutter_seekbar.dart' ;

class WordDialog extends Dialog  {
  double seekvalue;
  WordDialog({Key key,@required this.seekvalue})
      : super(key: key);
  @override

  Widget build(BuildContext context) {
    return Center(
      child: new Material(
        ///背景透明
        color: Colors.transparent,
        ///保证控件居中效果
        child:  Seekbar(seekvalue: seekvalue,),
      ),
    );
  }

}



class Seekbar extends StatefulWidget {
  double seekvalue;

  Seekbar({Key key,@required this.seekvalue})
      : super(key: key);
  @override
  _SeekbarState createState() => _SeekbarState();
}

class _SeekbarState extends State<Seekbar> {
  double seekvalue2;
//  List<SectionTextModel> sectionTexts = [];

  @override
  void initState() {
    super.initState();
//    sectionTexts.add(SectionTextModel(position: 0, text: '小', progressColor: Colors.blue));
//    sectionTexts.add(SectionTextModel(position: 1, text: '', progressColor: Colors.blue));
//    sectionTexts.add(SectionTextModel(position: 2, text: '标准', progressColor: Colors.blue));
//    sectionTexts.add(SectionTextModel(position: 3, text: '', progressColor: Colors.blue));
//    sectionTexts.add(SectionTextModel(position: 4, text: '大', progressColor: Colors.blue));
//    sectionTexts.add(SectionTextModel(position: 5, text: '', progressColor: Colors.blue));
//    sectionTexts.add(SectionTextModel(position: 6, text: '超大', progressColor: Colors.blue));
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        GestureDetector(onTap:(){
          Navigator.pop(context);
        }),
        Center(
          ///弹框大小
          child: new SizedBox(
            width: 300.0,
            height: 120.0,
            child: new Container(
              ///弹框背景和圆角
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '字体大小',
                    style: TextStyle(
                        fontSize: 10+(seekvalue2==null?widget.seekvalue:seekvalue2)*2
                    ),
                  ),
//                  Container(
//                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
//                    child: SeekBar(
//                      progresseight: 10,
//                      backgroundColor: Colours.bg_green,
//                      max: 7,
//                      min: 1,
//                      value:seekvalue2==null?widget.seekvalue:seekvalue2,
//                      sectionCount:6,
//                      sectionRadius: 6,
//                      showSectionText: true,
////                      sectionTexts: sectionTexts,
//                      sectionTextMarginTop: 2,
//                      sectionDecimal: 1,
//                      sectionTextColor: Colors.black,
//                      sectionSelectTextColor: Colors.red,
//                      sectionTextSize: 14,
//                      hideBubble: true,
//                      bubbleRadius: 14,
//                      bubbleColor: Colours.bg_green,
//                      bubbleTextColor: Colors.white,
//                      bubbleTextSize: 14,
//                      bubbleMargin: 4,
//                      afterDragShowSectionText: false,
//                      onValueChanged: ( e){
//                        setState(() {
//                          seekvalue2 = e.value;
//                          print('这个值是$seekvalue2');
//                        });
//                      },
//                    ),
//                  ),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: InkWell(
                      child: Container(
                        child: new Text(
                          "确定",
                        ),
                      ),
                      onTap: () {
                        saveWordSize(seekvalue2);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  static saveWordSize(double Size) async {
    StorageManager.sharedPreferences.setDouble(Constant.word_size, Size);
  }
}

