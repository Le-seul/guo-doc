import 'package:flutter/material.dart';
import 'package:flutter_first/mock_request.dart';


class notice extends StatefulWidget {
  @override
  _noticeState createState() => _noticeState();
}

class _noticeState extends State<notice> {

  String showtext='22222';
  @override
  void initState(){requestNotice();}

  Widget build(BuildContext context) {
    return Text(showtext,overflow: TextOverflow.ellipsis,maxLines: 1,);
  }
  void requestNotice() async{
//    var _request= MockRequest();
    var result=await MockRequest().get('Notice');
    showtext=result['text'];

    setState(() {

    });
  }
}
