import 'package:flutter/material.dart';

class Relatives extends StatefulWidget {
  @override
  _RelativesState createState() => _RelativesState();
}

class _RelativesState extends State<Relatives> {
  bool _checkboxSelected1=false;
  bool _checkboxSelected2=false;
  bool _checkboxSelected3=false;
  bool _checkboxSelected4=false;
  bool _checkboxSelected5=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('亲属资料填写'),
        backgroundColor: Color(0xff2CA687),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15, 10,15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('与本人的关系:'),
                Row(
                  children: <Widget>[
                    //SizedBox(width: 20,),
                    Checkbox(
                      value: _checkboxSelected1,
                      activeColor: Colors.greenAccent,
                      onChanged: (value){
                        setState(() {
                          _checkboxSelected1=value;
                        });
                      },
                    ),
                    Text("子女"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _checkboxSelected2,
                      activeColor: Colors.greenAccent,
                      onChanged: (value){
                        setState(() {
                          _checkboxSelected2=value;
                        });
                      },
                    ),
                    Text("父母"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _checkboxSelected3,
                      activeColor: Colors.greenAccent,
                      onChanged: (value){
                        setState(() {
                          _checkboxSelected3=value;
                        });
                      },
                    ),
                    Text("配偶"),
                  ],
                ),

              ],
            ),
          ),
          Container(margin: EdgeInsets.fromLTRB(15, 15, 15,0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('您的姓名:'),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2,color: Colors.black),
                                borderRadius:BorderRadius.all(Radius.circular(10))
                            )
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('您的性别:'),
                    Checkbox(
                      value: _checkboxSelected4,
                      activeColor: Colors.greenAccent,
                      onChanged: (value){
                        setState(() {
                          _checkboxSelected4=value;
                        });
                      },
                    ),
                    Text('男'),
                    Checkbox(
                      value: _checkboxSelected5,
                      activeColor: Colors.greenAccent,
                      onChanged: (value){
                        setState(() {
                          _checkboxSelected5=value;
                        });
                      },
                    ),
                    Text('女'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('出生年月:'),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 2),
                                borderRadius:BorderRadius.all(Radius.circular(10))
                            )
                        ),
                      ),
                    )

                  ],
                ),
              ],
            ),),
          SizedBox(
            height: 130,
            ),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(onPressed: null,color: Colors.blue,child: Text('提交'),),
              )
            ],
          ),
        ],
      ),

    );
  }
}
