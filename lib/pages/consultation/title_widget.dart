import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/psyCenter/psychological_service_center.dart';
import 'package:flutter_first/util/router.dart';
typedef TapCallback = void Function();

///《书影业》顶部四个TAB
class TitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( top: 10.0, bottom: 10.0,left: 15.0,right: 15.0),
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _TextImgWidget(
            '心理服务中心',
            'assets/images/psychological_subcenter.png',
            tabCallBack: () {
              Router.pushNoParams(context, Router.service_center);
            },
          ),
          _TextImgWidget(
            '教官风采',
            'assets/images/instructor_demeanor.png',
            tabCallBack: () {
              Router.pushNoParams(context, Router.instructor_demeanorPage);
            },
          ),
          _TextImgWidget(
            '门诊信息',
            'assets/images/outpatient_information.png',
            tabCallBack: () {
              Router.pushNoParams(context, Router.clinic_informationPage);
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
