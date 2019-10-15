import 'package:flutter/material.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/my_card.dart';

class HistoryRecordWidget extends StatefulWidget {
  @override
  _HistoryRecordWidgetState createState() => _HistoryRecordWidgetState();
}

class _HistoryRecordWidgetState extends State<HistoryRecordWidget>
    with SingleTickerProviderStateMixin {
  TabController mController;
  @override
  void initState() {
    super.initState();

    mController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 38,
          child: TabBar(
            isScrollable: false,
            //是否可以滚动
            controller: mController,
            indicatorColor: Color(0xff2CA687),
            labelColor: Color(0xff2CA687),
            unselectedLabelColor: Color(0xff666666),
            labelStyle: TextStyle(fontSize: 16.0),
            tabs: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('图文咨询'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('电话咨询'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('其他服务'),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: mController,
            children: <Widget>[
              _buildWidget(Router.graphicConsultation),
              _buildWidget(Router.telConsultation),
              _buildWidget(Router.searchHospital),
            ],
          ),
        )
      ],
    );
  }

  _buildWidget(String router) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => _buildItem(index,router),
    );
  }

  _buildItem(int index,String router) {
    return GestureDetector(
      onTap: () {
        Router.pushNoParams(context, router);
      },
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: MyCard(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '春雨儿科专家团',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '10月09日 上午10:30 ',
                      style: TextStyle(color: Colors.black26),
                    ),
                  ],
                ),
                Text('已关闭',style: TextStyle(color: Colors.black26),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
