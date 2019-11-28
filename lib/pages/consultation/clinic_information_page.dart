import 'package:flutter/material.dart';
import 'package:flutter_first/res/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Clinic_information extends StatefulWidget {
  @override
  _Clinic_informationState createState() => _Clinic_informationState();
}

class _Clinic_informationState extends State<Clinic_information> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text('门诊信息',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black,size: 32),
      ),
      backgroundColor: Colours.line,
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context,int index){
            return InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 6,child:
                    Container(decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1571473312&di=371b527aa619c775e08a0f00720da054&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201808%2F24%2F20180824191229_qycvp.jpg'),fit: BoxFit.fill)
                    ),)),
                    Expanded(flex: 2,
                        child: Column(
                          children: <Widget>[
                            Expanded(child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text('李医生',style: TextStyle(fontWeight:FontWeight.w600 ),),
                                  SizedBox(width:ScreenUtil().setWidth(3),),
                                  Text('神经外科主任医师',style: TextStyle(fontSize: 11),)
                                ],
                              ),
                              alignment: Alignment.centerLeft,
                            )),
                            Expanded(child: Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.topLeft,
                              child: Text('出诊时间:周一上午',style: TextStyle(fontSize: 11,color: Colors.grey),maxLines: 2,overflow:TextOverflow.ellipsis ,),)),

                          ],
                        )
                    ),

                  ],
                ),
              ),
              onTap: (){
              },
            );
          }),
    );
  }
}
