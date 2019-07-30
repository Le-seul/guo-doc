import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/Information.dart';
import 'package:flutter_first/mock_request.dart';







class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {

  List<Information> informationList = List();
  var aa = 'sss';

  @override
  void initState(){
    requestInformation();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: Row(
            children: <Widget>[
              Expanded(flex: 3,child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Text(InformationList[0].title),
                  //Text(InformationList[0].source+'             '+InformationList[0].date,style: TextStyle(color: Colors.grey,fontSize: 12))

                ],
              ),),
              Expanded(flex: 1,
                child: Image.asset('assets/images/tu1.jpg'),)
            ],
          ),
        ),

        RaisedButton(
          child: Text('111'),
          onPressed:(){
            requestInformation();
            setState(() {
            });
          }
        ),
        Text(informationList[0].date==null?aa:informationList[0].date)
      ],
    );
  }

  void requestInformation() async{
//    var _request= MockRequest();
    var result=await MockRequest().get('Information');
    var resultList= result['information'];
    informationList = resultList.map<Information>((item) => Information.fromMap(item)).toList();

    setState(() {
//      aa=informationList[0].date ;
    });
 }
}

