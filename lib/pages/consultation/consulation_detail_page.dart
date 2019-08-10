
import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_first/bean/health_adv.dart';

import 'package:flutter_first/res/colors.dart';

//主页，显示一个列表
class ConsulationDetailPage extends StatefulWidget {
  HealthAdv healthAdv;
  ConsulationDetailPage({Key key, @required this.healthAdv}) : super(key: key);
  _ConsulationDetailPageState createState() => _ConsulationDetailPageState(healthAdv);
}


class _ConsulationDetailPageState extends State<ConsulationDetailPage>{

  HealthAdv healthAdv;
  bool isSupport = false;
  bool isFavor = false;
  _ConsulationDetailPageState(this.healthAdv);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
//                floating: true, //不随着滑动隐藏标题
                pinned: false, //不固定在顶部
                iconTheme: IconThemeData(color: Colors.black,),
                title: Text('资讯',style: new TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w600,),),
                centerTitle: true,
                backgroundColor: Colors.white,
              ),
              SliverToBoxAdapter(
                child:Padding(
                  padding: const EdgeInsets.only(bottom: 10.0,top: 10.0,left: 5.0,right: 5.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 200,
                          child: Text(
                              healthAdv.title,
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontWeight: FontWeight.w600,)
                          ),
                        ),
                      ),
                      Align(
                        child:Container(
                          margin: const EdgeInsets.only(
                              top: 30.0),
                          child: Text(healthAdv.time ),
                        ),
                        alignment: Alignment.bottomLeft,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Image.network(healthAdv.images.small,fit: BoxFit.fill,),
                          )
                        ],
                      ),
                      Container(
                        padding:const EdgeInsets.only(bottom: 10.0,top: 10.0),
                        child: Text(
                          healthAdv.content,
                          textAlign: TextAlign.justify,
                          style: new TextStyle(
                            height: 1.4,
                          ),),
                      )

                    ],

                  ),
                ),
              ),
            ],
          ),
          Align(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 1.0,
                  color: Colours.line,
                ),
                Container(
                  height: 40,
                  color: Color(0xFFF6F6F6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     IconButton(
                          icon: Icon(Icons.share,color: Colors.black26,size: 20),
                          onPressed: ()async{
                            Share.text('my text title', '${healthAdv.title}:\nhttps://www.baidu.com/index.php?tn=02049043_6_pg', 'text/plain');
                          },
                        ),
                      GestureDetector(
                        child:IconButton(
                          icon: Icon(isFavor?Icons.star:Icons.star_border,size: 24,),
                        ),
                        onTap: () {
                          setState(() {
                            isFavor = !isFavor;
                          });

                        },
                      ),
                      GestureDetector(
                        child:IconButton(
                          icon: Icon(isSupport?Icons.favorite:Icons.favorite_border,size: 20),
                        ),
                        onTap: () {
                          setState(() {
                            isSupport = !isSupport;
                          });

                        },
                      ),

                    ],
                  ),
                ),
              ],
            ),
            alignment: FractionalOffset.bottomCenter,
          )
        ],
      ),
    );
  }
}

  
 