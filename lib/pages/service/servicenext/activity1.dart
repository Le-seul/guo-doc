import 'package:flutter/material.dart';


class ServiceActivity1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('亲子夏令营'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Image.network('http://s.114study.com/images/admin_xly_upload/upload/xly/big/20180408181106136040.jpg'),
          SizedBox(height: 20,),
          Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('        活动时间: 2019.07.15  -  2019.08.20',style: TextStyle(fontSize: 16),),
                Text('        活动地点: 808心理服务分中心',style: TextStyle(fontSize: 16),),
                Text('        报名人数: 30人   先到先得',style: TextStyle(fontSize: 16),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.people),
                    Text("1人已报名    ")
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
