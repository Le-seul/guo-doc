import 'package:flutter/material.dart';

class MovementList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        itemExtent: 76.0,
        itemBuilder: (context, index) => _buildItem(index),
      ),
    );
  }

  _buildItem(int index){
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.only(left: 15,right: 15),
      child: Column(
        children: <Widget>[
          Text('快跑',textAlign: TextAlign.left),
          Text('30分钟/175大卡',textAlign: TextAlign.left),
          Container(
            color: Colors.black54,
            height: 1,
          )
        ],
      ),
    );
  }
}
