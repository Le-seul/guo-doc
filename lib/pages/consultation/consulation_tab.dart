import 'package:flutter/material.dart';
import 'package:flutter_first/pages/consultation/selected_page.dart';

class FlutterTabBarView extends StatelessWidget {
  final TabController tabController;

  FlutterTabBarView({Key key, @required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewList = [
      SelectedPage(key: PageStorageKey<String>('SelectedPage'),),
      Page2(),
      Page3(),
      Page4(),
      Page5(),
      Page6(),
      Page7()
    ];
    return TabBarView(
      children: viewList,
      controller: tabController,
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFFFEBEE),
        child: new Text('Page2'),
      );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text('Page3'),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text('Page4'),
    );
  }
}

class Page5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text('Page5'),
    );
  }
}
class Page6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text('Page6'),
    );
  }
}
class Page7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Text('Page7'),
    );
  }
}

