import 'package:flutter/material.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/my_card.dart';
class CurrentConsultation extends StatefulWidget {
  @override
  _CurrentConsultationState createState() => _CurrentConsultationState();
}

class _CurrentConsultationState extends State<CurrentConsultation> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => _buildItem(index),
    );
  }

  _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        Router.pushNoParams(context, Router.talk);
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: MyCard(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: AssetImage('assets/images/beijing2.jpg'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '春雨儿科专家团',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '10月09日 上午10:30 | 儿科',
                      style: TextStyle(color: Colors.black26),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
