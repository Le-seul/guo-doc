import 'package:flutter/material.dart';
import 'package:flutter_first/util/image_utils.dart';

///文本搜索框
class SearchTextFieldWidget extends StatefulWidget {
  final ValueChanged<String> onSubmitted;
  final VoidCallback onTab;
  final String hintText;
  TextEditingController controller = TextEditingController();
  final EdgeInsetsGeometry margin;
  final bool isborder;
  final Color color;
  SearchTextFieldWidget(
      {Key key,
      this.hintText,
      this.onSubmitted,
      this.onTab,
      this.margin,
      this.isborder,
      this.color,
      this.controller})
      : super(key: key);

  @override
  _SearchTextFieldWidgetState createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  bool _isShowDelete = true;

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {
        _isShowDelete = widget.controller.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8,right: 8),
      margin: widget.margin == null ? EdgeInsets.all(0.0) : widget.margin,
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 30.0,
      decoration: BoxDecoration(
          color: widget.color == null
              ? Colors.white
              : widget.color,
          border: Border.all(
              color: widget.isborder ? Colors.black12 : Colors.white,
              width: 1),
          borderRadius: BorderRadius.circular(24.0)),
      child: Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(5),
              child: loadAssetImage('search.png' ,)),
          Expanded(
            child: TextField(
              onSubmitted: widget.onSubmitted,
              onTap: widget.onTab,
              controller: widget.controller,
              cursorColor: Color.fromARGB(255, 0, 189, 96),
              onChanged: (val) {},
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 5,bottom: 5,left: 0,right: 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 192, 191, 191)),
                 ),
              style: TextStyle(fontSize: 17),
            ),
          ),
          Offstage(
            offstage: _isShowDelete,
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.all(5),
                child: loadAssetImage(
                  "login/qyg_shop_icon_delete.png",
                  width: 15.0,
                  height: 15.0,
                ),
              ),
              onTap: () {
                setState(() {
                  widget.controller.text = "";
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
