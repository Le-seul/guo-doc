import 'package:flutter/material.dart';
import 'package:flutter_first/widgets/my_card.dart';
class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('季洪菊医生',style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF9F9F9),
        child: ListView(
          physics: ClampingScrollPhysics(),
          padding: EdgeInsets.only(left: 15,top: 15,right: 15),
          children: <Widget>[
            MyCard(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25.0,
                        backgroundImage:
                        AssetImage('assets/images/beijing2.jpg'),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '季洪菊',
                            style: TextStyle(fontSize: 16,),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text('产科  副主任医师',style: TextStyle(color: Colors.black54),),
                          SizedBox(
                            height: 5,
                          ),
                          Text('徐州医学院附属第三医院',style: TextStyle(color: Colors.black54),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
             SizedBox(height: 15,),
             MyCard(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('擅长及诊所介绍',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                      SizedBox(height: 5,),
                      Container(height: 1,color: Colors.black12,),
                      SizedBox(height: 15,),
                      Text('妇科常见疾病多发病的身段治疗及产科检查，产后恢复，孕期保健，高位妊娠诊断处理',
                        strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5),
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(height: 15,),
                      Text('医学教育背景介绍',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                      SizedBox(height: 5,),
                      Container(height: 1,color: Colors.black12,),
                      SizedBox(height: 15,),
                      Text('大学本科毕业，学士学位，并参加研究合生学习，同时参加高校教育工作。',
                        strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5),
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(height: 15,),
                      Text('学术研究成果、获奖介绍',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                      SizedBox(height: 5,),
                      Container(height: 1,color: Colors.black12,),
                      SizedBox(height: 15,),
                      Text('无',style: TextStyle(color: Colors.black54),),
                      SizedBox(height: 15,),
                      Text('医生寄语',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                      SizedBox(height:5,),
                      Container(height: 1,color: Colors.black12,),
                      SizedBox(height: 15,),
                      Text('您好，感谢您信任我，我将尽最大努力为你解决问题，希望我的努力帮助到你。',
                        strutStyle: StrutStyle(forceStrutHeight: true, height: 1.5),
                        style: TextStyle(color: Colors.black54),
                      ),
                      SizedBox(height: 15,),

                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
