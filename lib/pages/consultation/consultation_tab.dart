import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_columns_entity.dart';
import 'package:flutter_first/pages/consultation/consultation_child_page.dart';

class FlutterTabBarView extends StatelessWidget {
  final TabController tabController;
  List<ConsulationColumns> columnsList;

  FlutterTabBarView({Key key, @required this.tabController,@required this.columnsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> viewList = [];
    int num = columnsList.length;
    for(int i = 1; i <= num ; i++){
      if(i == 1){
        viewList.add(ChildPage(false));
      }else{
        viewList.add(ChildPage(true));
      }
    }
    return TabBarView(
      children: viewList,
      controller: tabController,
    );
  }
}

