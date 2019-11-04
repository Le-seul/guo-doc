import 'package:flutter/material.dart';
import 'package:flutter_first/widgets/my_card.dart';
class TelConsultationPage extends StatefulWidget {
  @override
  _TelConsultationPageState createState() => _TelConsultationPageState();
}

class _TelConsultationPageState extends State<TelConsultationPage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: MyCard(
          child:Container(
            height: double.infinity,
            margin: EdgeInsets.all(10.0),
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) => _buildItem(index),),
          )

      ),
      color: Colors.black12,
      padding: EdgeInsets.all(15.0),
    );
  }
  _buildItem(int index) {
    return Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image.network(
                'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2350302849,3323337377&fm=26&gp=0.jpg',
                height: 80,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 10,top: 10
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('春雨儿科专家团'),

                      Text(
                        '10月9日：儿科',
                        style: TextStyle(color: Colors.black12, fontSize: 12),
                      ),
                      Container(
                        height: 2,
                        color: Colors.black12,
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
