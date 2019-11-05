import 'package:flutter/material.dart';
import 'package:flutter_first/bean/service_location.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/widgets/my_card.dart';
class ServiceChild extends StatefulWidget {
  @override
  _ServiceChildState createState() => _ServiceChildState();
}

class _ServiceChildState extends State<ServiceChild> {

  List<ServiceLocation> list = List();
  bool offstage = true;


  @override
  void initState() {
    list.add(ServiceLocation('刑侦总队心理服务分中心','北京市朝阳区小营北路6号'));
    list.add(ServiceLocation('刑侦总队心理服务分中心','北京市朝阳区小营北路6号'));
    list.add(ServiceLocation('刑侦总队心理服务分中心','北京市朝阳区小营北路6号'));
    list.add(ServiceLocation('刑侦总队心理服务分中心','北京市朝阳区小营北路6号'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => _buildItem(index),));
  }

  _buildItem(index){
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15,top: 15),
      child:MyCard(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Row(
                  children: <Widget>[
                loadAssetImage("icon_police.jpg",height: 40,width: 40),
                    SizedBox(width: 10,),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10,),
                        Text('刑侦总队心理服务分中心'),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on,size: 15,color: Colors.black26,),
                            Text('北京市朝阳区小营北路6号',style: TextStyle(color: Colors.black26),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('心理服务站 3  休闲驿站 2',style: TextStyle(color: Colors.black26)),
                            GestureDetector(
                              child: list[index].offstage?Row(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text('展开'),
                                    Icon(Icons.arrow_drop_down)
                                  ],)
                                ],
                              ):Row(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text('收起'),
                                    Icon(Icons.arrow_drop_up)
                                  ],)
                                ],
                              ),
                              onTap: (){
                                setState(() {
                                  list[index].offstage = !list[index].offstage;
                                });
                              },
                            )
                          ],
                        ),

                      ],
                    ))
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Offstage(
                offstage: list[index].offstage,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(height: 1,color: Colors.black26,),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                        child: Text('北土城站派出所心理服务站')),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on,size: 15,color: Colors.black26,),
                          Text('北京市朝阳区小营北路6号',style: TextStyle(color: Colors.black26),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(height: 1,color: Colors.black26,),
                    SizedBox(height: 10,),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('北土城站派出所心理服务站')),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on,size: 15,color: Colors.black26,),
                          Text('北京市朝阳区小营北路6号',style: TextStyle(color: Colors.black26),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(height: 1,color: Colors.black26,),
                    SizedBox(height: 10,),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('北土城站派出所心理服务站')),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on,size: 15,color: Colors.black26,),
                          Text('北京市朝阳区小营北路6号',style: TextStyle(color: Colors.black26),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],

                ),

              )
            ],
          ),

        ),),
    );

  }
}
