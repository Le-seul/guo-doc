import 'package:flutter/material.dart';
import 'package:flutter_first/bean/course.dart';
import 'package:flutter_first/pages/home/home_widgets/course/bottom_player%20bar.dart';
import 'package:flutter_first/pages/home/home_widgets/course/course_detail_page.dart';
import 'package:flutter_first/util/navigator_util.dart';

class CourseChild extends StatefulWidget {

  List<Course> courseList ;
  CourseChild(@required this.courseList);

  @override
  _CourseChildState createState() => _CourseChildState();
}

class _CourseChildState extends State<CourseChild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15,right: 15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.courseList.length,
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
            crossAxisCount: 2,
            //纵轴间距
            mainAxisSpacing: 5.0,
            //横轴间距
            crossAxisSpacing: 15.0,
            //子组件宽高长度比例
            childAspectRatio: 1),
        itemBuilder: (context, index) => _buildItem(index),),
    );
  }

  _buildItem(int index){
    return GestureDetector(
      onTap: (){
        NavigatorUtil.pushPage(context,CourseDetailPage(courseId: widget.courseList[index].id,));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 11/6,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.courseList[index].coverImage,
                  fit: BoxFit.fill,
                )),
          ),
          SizedBox(height: 10,),
          Text('【${widget.courseList[index].name}】',style: TextStyle(fontSize: 14,),),
          SizedBox(height: 8,),
          Text('课程时长：10讲',style: TextStyle(color: Color(0xff909090),fontSize: 12),)
        ],
      ),
    );
  }
}
