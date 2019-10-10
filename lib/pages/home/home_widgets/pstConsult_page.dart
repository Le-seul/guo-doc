import 'package:flutter/material.dart';
import 'package:flutter_first/pages/home/home_widgets/VideoPlayer_Page.dart';
import 'package:flutter_first/util/dialog.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/search.dart';

class PsychologicalConcult extends StatefulWidget {
  @override
  _PsychologicalConcultState createState() => _PsychologicalConcultState();
}

class _PsychologicalConcultState extends State<PsychologicalConcult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('心理咨询'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white10,
          child: Column(
            children: <Widget>[

              Container(
                margin: EdgeInsets.only(top: 10,bottom: 10),
                child: SearchTextFieldWidget(
                  hintText: '搜索你感兴趣的内容/咨询师',
                  margin: const EdgeInsets.only(
                      left: 15.0, right: 15.0),
                  onTab: () {},
                ),
              ),
              VideoPlayer(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                      child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 80,
                      color: Colors.yellow,
                      child: FlatButton(
                          onPressed: () {}, child: Text('为什么要进行心理咨询')),
                    ),
                  )),
                  Expanded(
                      child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 80,
                      color: Colors.green,
                      child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            '怎样进行第一次心理咨询',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                  )),
                  Expanded(
                      child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(60)),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: 80,
                      color: Colors.lightBlueAccent,
                      child: FlatButton(onPressed: () {}, child: Text('服务条款')),
                    ),
                  )),
                ],
              ), //心理咨询
              Row(
                children: <Widget>[
                  Expanded(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.deepOrange,
                      child: Text("线上申请",style: TextStyle(fontSize: 12),),
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/changjiantou-you.png',
                    ),
                  ),
                  Expanded(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Text("线下审核",style: TextStyle(fontSize: 12),),
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/changjiantou-you.png',
                    ),

                  ),
                  Expanded(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Text("线下沟通",style: TextStyle(fontSize: 12),),
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/changjiantou-you.png',
                    ),

                  ),
                  Expanded(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: Text("安排预约",style: TextStyle(fontSize: 12),),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      resizeToAvoidBottomPadding: false,
      bottomSheet:
         Row(children: <Widget>[
           Expanded(child: Container(
             height: 45,
             child: RaisedButton(
               onPressed:(){
                 MyDialog.showMyMaterialDialog(context);
               },
               child: Text('咨询',style: TextStyle(fontSize: 17),),
               color: Colors.blue,),
           ),)
         ],
         )

    );
  }
}
