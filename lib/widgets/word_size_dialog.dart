

import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_seekbar/flutter_seekbar.dart' ;
class WordDialog extends Dialog {

  double seekvalue;
  WordDialog({Key key,@required this.seekvalue})
      : super(key: key);
  @override
  List<SectionTextModel> sectionTexts = [];

  @override
  void initState() {
    sectionTexts.add(
        SectionTextModel(position: 0, text: 'bad', progressColor: Colors.red));
    sectionTexts.add(SectionTextModel(
        position: 2, text: 'good', progressColor: Colors.yellow));
    sectionTexts.add(SectionTextModel(
        position: 4, text: 'great', progressColor: Colors.green));
  }
  Widget build(BuildContext context) {
    return Center(
      child: new Material(
        ///背景透明
        color: Colors.transparent,
        ///保证控件居中效果
        child: new Center(
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
                    '字体大小'
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: SeekBar(
                        progresseight: 10,
                        backgroundColor: Colours.bg_green,
                        max: 4,
                        min: 1,
                        value:seekvalue,
                        sectionCount:6,
                        sectionRadius: 6,
                        showSectionText: true,
                        sectionTexts: sectionTexts,
                        sectionTextMarginTop: 2,
                        sectionDecimal: 1,
                        sectionTextColor: Colors.black,
                        sectionSelectTextColor: Colors.red,
                        sectionTextSize: 14,
                        hideBubble: false,
                        bubbleRadius: 14,
                        bubbleColor: Colours.bg_green,
                        bubbleTextColor: Colors.white,
                        bubbleTextSize: 14,
                        bubbleMargin: 4,
                        afterDragShowSectionText: false,
                      onValueChanged: ( e){
                          seekvalue = e.value;
                          saveWordSize(e.value);
                          print('这个值是$seekvalue');
                      },
                    ),
                  ),
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
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  static saveWordSize(double Size) async {
    StorageManager.sharedPreferences.setDouble(Constant.word_size, Size);
  }
}

