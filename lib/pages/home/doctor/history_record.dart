import 'package:flutter/material.dart';
import 'package:flutter_first/bean/history_order_entity.dart';
import 'package:flutter_first/bean/imageUrl.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/home/doctor/current_consultation.dart';
import 'package:flutter_first/pages/home/doctor/history_record_widget.dart';


class HistoryRecord extends StatefulWidget {
  @override
  _HistoryRecordState createState() => _HistoryRecordState();
}

class _HistoryRecordState extends State<HistoryRecord>
    with SingleTickerProviderStateMixin {
  Color selectColor = Color(0xff2CA687);
  Color unSelectColor = Colors.white;
  bool isChoice1 = true;
  bool isChoice2 = false;
  Widget childWidget;

  @override
  void initState() {
    childWidget = CurrentConsultation();

  }
  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.black,),
              backgroundColor: Colors.white,
              title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                        decoration: BoxDecoration(
                          color: isChoice1 ? selectColor : unSelectColor,
                          border:
                              Border.all(color: Color(0xff2CA687), width: 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0)),
                        ),
                        child: Text(
                          '当前咨询',
                          style: TextStyle(
                            color: isChoice1?Colors.white:Color(0xff2CA687),
                            fontSize: 16
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          isChoice1 = true;
                          isChoice2 = false;
                          childWidget = CurrentConsultation();
                        });
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                        child:
                            Text('历史记录', style: TextStyle(color: isChoice2?Colors.white:Color(0xff2CA687),fontSize: 16)),
                        decoration: BoxDecoration(
                          color: isChoice2 ? selectColor : unSelectColor,
                          border:
                          Border.all(color: Color(0xff2CA687), width: 1),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0)),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          isChoice2 = true;
                          isChoice1 = false;
                          childWidget = HistoryRecordWidget();
                        });
                      },
                    ),
                    SizedBox(width: 50,)
                  ],
                ),

            ),
            preferredSize: Size.fromHeight(56)),
        body: Container(
          child: childWidget,
        ),
    );
  }
}
