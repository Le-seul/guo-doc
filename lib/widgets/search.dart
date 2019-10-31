import 'package:flutter/material.dart';
import 'package:flutter_first/util/image_utils.dart';

///文本搜索框
class SearchTextFieldWidget extends StatelessWidget {
  final ValueChanged<String> onSubmitted;
  final VoidCallback onTab;
  final String hintText;
  final EdgeInsetsGeometry margin;
  final bool isborder;
  final Color color;
  SearchTextFieldWidget({Key key, this.hintText, this.onSubmitted, this.onTab, this.margin,this.isborder,this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin == null ? EdgeInsets.all(0.0) : margin,
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 30.0,
      decoration: BoxDecoration(
          color: color==null? Color.fromARGB(255, 237, 236, 237):color,
          border: Border.all(color: isborder?Colors.black12:Colors.white, width: 1),
          borderRadius: BorderRadius.circular(24.0)),
      child: TextField(
        onSubmitted: onSubmitted,
        onTap: onTab,
        cursorColor: Color.fromARGB(255, 0, 189, 96),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: 17, color: Color.fromARGB(255, 192, 191, 191)),
            prefixIcon: Container(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              child: loadAssetImage('search.png'),
            )),
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
