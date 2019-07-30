import 'package:flutter/material.dart';
typedef TapCallback = void Function();

///《书影业》顶部四个TAB
class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( top: 5.0, bottom: 5.0),
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _TextImgWidget(
            '心理分中心',
            'assets/images/psychological_subcenter.jpeg',
            tabCallBack: () {

            },
          ),
          _TextImgWidget(
            '教官风采',
            'assets/images/instructor_demeanor.jpeg',
            tabCallBack: () {

            },
          ),
          _TextImgWidget(
            '门诊信息',
            'assets/images/outpatient_information.jpeg',
            tabCallBack: () {

            },
          ),
        ],
      )
    );
  }
}

class _TextImgWidget extends StatelessWidget {
  final String text;
  final String imgAsset;
  final TapCallback tabCallBack;

  _TextImgWidget(
    this.text,
    this.imgAsset, {
    Key key,
    this.tabCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (tabCallBack != null) {
          tabCallBack();
        }
      },
      child: Column(

        children: <Widget>[
          CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage(imgAsset),
            backgroundColor: Colors.white,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(
                  255,
                  128,
                  128,
                  128,
                )),
          )
        ],
      ),
    );
  }
}
