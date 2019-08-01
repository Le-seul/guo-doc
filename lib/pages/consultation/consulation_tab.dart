import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/feeling.dart';
import 'package:flutter_first/pages/consultation/health_page.dart';
import 'package:flutter_first/pages/consultation/occupation_page.dart';
import 'package:flutter_first/pages/consultation/physiology_page.dart';
import 'package:flutter_first/pages/consultation/policy_advocacy_page.dart';
import 'package:flutter_first/pages/consultation/relationship_page.dart';
import 'package:flutter_first/pages/consultation/selected_page.dart';

class FlutterTabBarView extends StatelessWidget {
  final TabController tabController;

  FlutterTabBarView({Key key, @required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewList = [
      SelectedPage(),
      PhysiologyPage(),
      PolicyAdvocacyPage(),
      FeelingPage(),
      Occcupation(),
      HealthPage(),
      RelationshipPage()
    ];
    return TabBarView(
      children: viewList,
      controller: tabController,
    );
  }
}

