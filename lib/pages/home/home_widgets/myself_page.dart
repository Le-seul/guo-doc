import 'package:flutter/material.dart';

class Myself extends StatefulWidget {
  @override
  _MyselfState createState() => _MyselfState();
}

class _MyselfState extends State<Myself> {
  List<DropdownMenuItem> getListData(){
    List<DropdownMenuItem> items=new List();
    DropdownMenuItem dropdownMenuItem1=new DropdownMenuItem(
      child:new Text('808心理分服务中心'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2=new DropdownMenuItem(
      child:new Text('西城心理分服务中心'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3=new DropdownMenuItem(
      child:new Text('东城心理分服务中心'),
      value: '3',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4=new DropdownMenuItem(
      child:new Text('海淀心理分服务中心'),
      value: '4',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5=new DropdownMenuItem(
      child:new Text('朝阳心理分服务中心'),
      value: '5',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6=new DropdownMenuItem(
      child:new Text('昌平心理分服务中心'),
      value: '6',
    );
    items.add(dropdownMenuItem6);
    DropdownMenuItem dropdownMenuItem7=new DropdownMenuItem(
      child:new Text('石景山心理分服务中心'),
      value: '7',
    );
    items.add(dropdownMenuItem7);
    DropdownMenuItem dropdownMenuItem8=new DropdownMenuItem(
      child:new Text('丰台心理分服务中心'),
      value: '8',
    );
    items.add(dropdownMenuItem8);
    DropdownMenuItem dropdownMenuItem9=new DropdownMenuItem(
      child:new Text('顺义心理分服务中心'),
      value: '9',
    );
    items.add(dropdownMenuItem9);
    DropdownMenuItem dropdownMenuItem10=new DropdownMenuItem(
      child:new Text('房山心理分服务中心'),
      value: '10',
    );
    items.add(dropdownMenuItem10);
    return items;
  }
  var value;
  bool _checkboxSelected1=false;
  bool _checkboxSelected2=false;
  bool _checkboxSelected3=false;
  bool _checkboxSelected4=false;
  bool _checkboxSelected5=false;
  bool _checkboxSelected6=false;
  bool _checkboxSelected7=false;
  bool _checkboxSelected8=false;
  bool _checkboxSelected9=false;
  bool _checkboxSelected10=false;
  bool _checkboxSelected11=false;
  bool _checkboxSelected12=false;
  bool _checkboxSelected13=false;
  bool _checkboxSelected14=false;
  bool _checkboxSelected15=false;
  bool _checkboxSelected16=false;
  bool _checkboxSelected17=false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('本人心理咨询'),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('                紧急联系人:'),
                Container(
                  child: TextField(
                    decoration: InputDecoration(hintText: "姓名",
                        border:OutlineInputBorder(
                            borderRadius:BorderRadius.all(Radius.circular(10))
                        )),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('紧急联系人联系电话:'),
                Container(
                  child: TextField(
                    decoration: InputDecoration(hintText: "电话",border: OutlineInputBorder(
                        borderRadius:BorderRadius.all(Radius.circular(10))
                    )),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('   咨询内容:',style: TextStyle(fontSize: 19 ),),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected1,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected1=value;
                                  });
                                },
                              ),
                              Text('人际关系'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
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
                              Text('婚姻恋爱'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
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
                              Text('家庭关系'),
                            ],
                          ),
                        ),

                      ]),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected4,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected4=value;
                                  });
                                },
                              ),
                              Text('亲密关系'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected5,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected5=value;
                                  });
                                },
                              ),
                              Text('亲子教育'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected6,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected6=value;
                                  });
                                },
                              ),
                              Text('情绪压力'),
                            ],
                          ),
                        ),

                      ]),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected7,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected7=value;
                                  });
                                },
                              ),
                              Text('行为问题'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected8,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected8=value;
                                  });
                                },
                              ),
                              Text('学业职场'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected9,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected9=value;
                                  });
                                },
                              ),
                              Text('个人成长'),
                            ],
                          ),
                        ),
                      ]),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      maxLength: 300,
                      maxLines: 3,
                      decoration:InputDecoration(
                          hintText: '请简要描述你要咨询的内容',
                          border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  Text('   优选时间:',style: TextStyle(fontSize: 19 ),),
                  SizedBox(height: 5,),
                  Text('   工作日:',style: TextStyle(fontSize: 16),),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected10,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected10=value;
                                  });
                                },
                              ),
                              Text('9:00-12.00'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected11,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected11=value;
                                  });
                                },
                              ),
                              Text('12:00-14.00'),
                            ],
                          ),
                        ),
                      ]),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected12,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected12=value;
                                  });
                                },
                              ),
                              Text('14:00-18.00'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected13,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected13=value;
                                  });
                                },
                              ),
                              Text('18:00-21.00'),
                            ],
                          ),
                        ),
                      ]),
                  Text('   周末:',style: TextStyle(fontSize: 16 ),),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected14,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected14=value;
                                  });
                                },
                              ),
                              Text('9:00-12.00'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected15,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected15=value;
                                  });
                                },
                              ),
                              Text('12:00-14.00'),
                            ],
                          ),
                        ),
                      ]),
                  Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected16,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected16=value;
                                  });
                                },
                              ),
                              Text('14:00-18.00'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: _checkboxSelected17,
                                activeColor: Colors.greenAccent,
                                onChanged: (value){
                                  setState(() {
                                    _checkboxSelected17=value;
                                  });
                                },
                              ),
                              Text('18:00-21.00'),
                            ],
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Text('    地点:     ',style: TextStyle(fontSize: 17),),
                DropdownButton(
                  items: getListData(),
                  hint: Text('请选择你的地点') ,
                  value: value,
                  onChanged: (T){
                    setState(() {
                      value=T;
                    });
                  },
                ),
                Text('详情',style: TextStyle(color: Colors.blue),)
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed:(){
                    } ,
                    child:  Text('提交',style: TextStyle(fontSize: 17),),),
                ),
              ],
            ),
          ],
        ),


    );
  }
}
