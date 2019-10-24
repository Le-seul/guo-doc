import 'package:flutter/material.dart';
class GreenBgWidget extends StatelessWidget {
   String name;

  GreenBgWidget({Key key, @required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
      child: Text(name,
          style: TextStyle(
            color: Colors.white,
          )),
      decoration: BoxDecoration(
          color: Color(0xff2CA687), borderRadius: BorderRadius.circular(5)),
    );
  }


}
