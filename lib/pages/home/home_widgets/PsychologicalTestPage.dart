import 'package:flutter/material.dart';

class PsychologicalTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('压力测试'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Image.network('http://www.btestsky.cn/lstp/181110/1-1Q1101Q151433.jpg'),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('压力水平测试',style: TextStyle(fontSize: 25,fontWeight:FontWeight.w200 ),),
                Text('提示: 共63道题,用时8分钟'),
                Text('简介: 适度的压力也许能成为你的帮手,但是过度的压力会成为拖垮你的敌人,会让我们的健康状况极不稳定,甚至严重影响我们的工作和生活'
                    '本测验将对您近一个月来的压力情况进行测查,以帮助您了解自己目前的压力水平,及时调整'),
                Text('注意:请认真阅读以下标准'),
              ],
            ),
          )
        ],
      ),
      bottomSheet: Row(
        children: <Widget>[
          Expanded(child:Container(
            height: 60,
            child: Column(
              children: <Widget>[
                Icon(Icons.device_hub),
                Text('分享')
              ],
            ),
          )),
          Expanded(child:Container(
            height: 60,
            child: Column(
              children: <Widget>[
                Icon(Icons.favorite_border),
                Text('收藏')
              ],
            ),
          )),
          Expanded(child:Container(
            height: 60,
            color: Colors.blue,
            child:Center(
              child: Text('开始测试',style: TextStyle(fontSize: 17),),
            )


            ),
          ),


        ],
      ),
    );
  }
}
