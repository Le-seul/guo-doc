import 'package:flutter/material.dart';
import 'package:flutter_first/pages/home/home_widgets/VideoPlayerPage.dart';
import 'package:flutter_first/util/dialog.dart';

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
              TextField(
                decoration: InputDecoration(hintText: "输入搜索内容"),
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
      bottomSheet:
         Row(children: <Widget>[
           Expanded(child: Container(
             height: 60,
             child: RaisedButton(
               onPressed:(){
                 showDialog(
                   context: context,
                 builder: (context){
                    return AlertDialog(
                      title:Text('提示') ,
                      content: Text('请确定与本人的关系'),
                      actions: <Widget>[
                         Container(
                          color: Colors.yellow,
                          child: FlatButton(onPressed:(){}, child: Text('本人',style: TextStyle(color: Colors.black),)),
                        ),

                          Container(
                          color: Colors.green,
                          child: FlatButton(onPressed:(){}, child: Text('家属',style: TextStyle(color: Colors.black))),
                        ),
                      ],
                    );
                 },);},
               child: Text('咨询',style: TextStyle(fontSize: 17),),
               color: Colors.blue,),
           ),)
         ],
         )

    );

  }
}
