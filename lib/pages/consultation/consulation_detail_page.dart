import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/health_adv.dart';
import 'package:flutter_first/event/login_event.dart';

//主页，显示一个列表
class ConsulationDetailPage extends StatelessWidget {

  HealthAdv healthAdv;
  ConsulationDetailPage({Key key,@required this.healthAdv}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: <Widget>[
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.black,),
                title: Text('资讯',style: new TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w600,),),
                centerTitle: true,
                pinned: true,
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
                  color: Color(0xffe5e5e5),
                ),
                Container(
                  height: 40,
                  color: Color(0xFFF6F6F6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.feedback),
                      ),
                      IconButton(
                        icon: Icon(Icons.star_border),
                      ),
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                      )
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
