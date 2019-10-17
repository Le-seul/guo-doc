import 'package:flutter/material.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class instructor_demeanor extends StatefulWidget {
  @override
  _instructor_demeanorState createState() => _instructor_demeanorState();
}

class _instructor_demeanorState extends State<instructor_demeanor> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('教官风采',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black,size: 32),
      ),
      backgroundColor: Colours.line,
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
             childAspectRatio: 0.8
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context,int index){
            return InkWell(
              child: Container(
                margin: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 6,child:
                      Container(decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2250972642,639062800&fm=26&gp=0.jpg'),fit: BoxFit.fill)
                    ),)),
                    Expanded(flex: 2,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                        flex:2,
                        child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('王警官',style: TextStyle(fontWeight:FontWeight.w600 ),),
                              alignment: Alignment.centerLeft,
                            )),
                            Expanded(
                                flex:3,child: Container(
                              padding: EdgeInsets.only(left: 10,bottom: 5),
                              alignment: Alignment.topLeft,
                              child: Text('山东你好大股东对公付获得感动肝火熬更好大地飞歌鬼地方个的噢更好地',style: TextStyle(fontSize: 11,color: Colors.grey),maxLines: 2,overflow:TextOverflow.ellipsis ,),)),

                          ],
                        )
                    ),

                  ],
                ),
              ),
              onTap: (){
                Router.pushNoParams(context, Router.instructor_demeanor_detailPage);
              },
            );
          }),
    );
  }
}
