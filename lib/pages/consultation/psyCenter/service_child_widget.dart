import 'package:flutter/material.dart';
import 'package:flutter_first/widgets/my_card.dart';
class ServiceChild extends StatefulWidget {
  @override
  _ServiceChildState createState() => _ServiceChildState();
}

class _ServiceChildState extends State<ServiceChild> {

  bool offstage = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) => _buildItem(index),));
  }

  _buildItem(index){
    return Container(
      child:MyCard(
        child: Container(
          child: Row(
            children: <Widget>[
              Image.network('https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=2193107247,3686899171&fm=202&src=608&ernie&mola=new&crop=v1'),
              Column(
                children: <Widget>[
                  Text('刑侦总队心理服务分中心'),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      Text('北京市朝阳区小营北路6号'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('心理服务站 3  休闲驿站 2'),
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Row(children: <Widget>[
                              Text('展开'),
                              Icon(Icons.arrow_drop_down)
                            ],)
                          ],
                        ),
                      )
                    ],
                  ),
                  Offstage(
                    offstage: offstage,
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
//                        Container(height: 1,color: Colors.black26,),
//                        Text('北土城站派出所心理服务站'),
//                        Row(
//                          children: <Widget>[
//                            Icon(Icons.location_on),
//                            Text('北京市朝阳区小营北路6号'),
//                          ],
//                        ),
//                        Container(height: 1,color: Colors.black26,),
//                        Text('北土城站派出所心理服务站'),
//                        Row(
//                          children: <Widget>[
//                            Icon(Icons.location_on),
//                            Text('北京市朝阳区小营北路6号'),
//                          ],
//                        ),
//                        Container(height: 1,color: Colors.black26,),
//                        Text('北土城站派出所心理服务站'),
//                        Row(
//                          children: <Widget>[
//                            Icon(Icons.location_on),
//                            Text('北京市朝阳区小营北路6号'),
//                          ],
//                        ),
                        Text('北京市朝阳区小营北路6号'),
                      ],

                    ),

                  )
                ],
              )
            ],
          ),
        ),),
    );

  }
}
