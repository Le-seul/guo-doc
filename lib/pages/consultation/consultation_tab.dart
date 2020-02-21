import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_columns_entity.dart';
import 'package:flutter_first/pages/consultation/consultation_child_page.dart';

import 'workdynamics/work_dynamics_page.dart';

class FlutterTabBarView extends StatelessWidget {
  final TabController tabController;
  final List<ConsulationColumns> columnsList;

  FlutterTabBarView({Key key, @required this.tabController,@required this.columnsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> viewList = [];
    int num = columnsList.length;
    for(int i = 1; i <= num ; i++){
      if(i == 1){
        viewList.add(ChildPage(false,columnsList[i-1].id,false));
      }else{
        if(columnsList[i-1].name=='工作动态'){
          viewList.add(WorkDynamics());
        }else{
          viewList.add(ChildPage(true,columnsList[i-1].id,false));
        }

      }
    }
    return TabBarView(
      children: viewList,
      controller: tabController,
    );
  }
}

