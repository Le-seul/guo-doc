import 'package:flutter/material.dart';
import 'package:flutter_first/bean/course.dart';
import 'package:flutter_first/pages/home/home_widgets/course/bottom_player%20bar.dart';
import 'package:flutter_first/util/router.dart';
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
        Router.push(context, Router.curriculumcatalog1,widget.courseList[index].id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.courseList[index].coverImage,
                height: 90,
                fit: BoxFit.fill,
              )),
          SizedBox(height: 10,),
          Text('【怎么管理情绪】',style: TextStyle(fontSize: 14,),),
          SizedBox(height: 8,),
          Text('课程时长：10讲',style: TextStyle(color: Color(0xff909090),fontSize: 12),)
        ],
      ),
    );
  }
}
