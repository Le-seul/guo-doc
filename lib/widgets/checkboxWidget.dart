import 'package:flutter/material.dart';
class CheckBoxWidget extends StatefulWidget {
  String title;
  String subTitle;
  CheckBoxWidget(this.title,this.subTitle );
  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {

  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        children: <Widget>[
          Text(widget.title,style: TextStyle(fontSize: 14),),
          SizedBox(width: 10,),
          Text(widget.subTitle,style: TextStyle(color: Colors.black26,fontSize: 14),),
        ],
      ),
      value: isSelect,
      onChanged: (bool value) {
        setState(() {
          this.isSelect = !this.isSelect;
        });
      },
    );
  }
}
