import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/pages/selfhelp/daily_recording/circlarchart/animated_circular_chart.dart';
import 'package:flutter_first/pages/selfhelp/daily_recording/circlarchart/entry.dart';
import 'package:flutter_first/pages/selfhelp/daily_recording/datetime_picer/flutter_datetime_picker.dart';
import 'package:flutter_first/res/styles.dart';

class SleepRecordsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SleepRecordsPageState();
}

class SleepRecordsPageState extends State<SleepRecordsPage> {
  final Color normalBarColor = Color(0xff53fdd7);
  final Color lessBarColor = Color(0xffff5182);
  final Color moreBarColor = Color(0xFF4688FA);
//  final Color rightBarColor = Color(0xffff5182);
  final double width = 15;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final _chartSize1 = const Size(100.0, 100.0);
  final _chartSize2 = const Size(80.0, 80.0);
  StreamController<BarTouchResponse> barTouchedResultStreamController;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 12, 15);
    final barGroup2 = makeGroupData(1, 15, 16);
    final barGroup3 = makeGroupData(2, 12, 5);
    final barGroup4 = makeGroupData(3, 17, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 20, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;

    barTouchedResultStreamController = StreamController();
    barTouchedResultStreamController.stream
        .distinct()
        .listen((BarTouchResponse response) {
      if (response == null) {
        return;
      }

      if (response.spot == null) {
        setState(() {
          touchedGroupIndex = -1;
          showingBarGroups = List.of(rawBarGroups);
        });
        return;
      }

      touchedGroupIndex =
          showingBarGroups.indexOf(response.spot.touchedBarGroup);

      setState(() {
        if (response.touchInput is FlLongPressEnd) {
          touchedGroupIndex = -1;
          showingBarGroups = List.of(rawBarGroups);
        } else {
          showingBarGroups = List.of(rawBarGroups);
          if (touchedGroupIndex != -1) {
            double sum = 0;
            for (BarChartRodData rod
                in showingBarGroups[touchedGroupIndex].barRods) {
              sum += rod.y;
            }
            double avg =
                sum / showingBarGroups[touchedGroupIndex].barRods.length;

            showingBarGroups[touchedGroupIndex] =
                showingBarGroups[touchedGroupIndex].copyWith(
              barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                return rod.copyWith(y: avg);
              }).toList(),
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            '睡眠记录',
            style: new TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      color: Color(0xFFEEEEEE),
                      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '本周睡眠时长',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 320,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      '小时',
                                      style: TextStyle(
                                        color: const Color(0xff7589a2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: FlChart(
                                          chart: BarChart(BarChartData(
                                            maxY: 20,
                                            barTouchData: BarTouchData(
                                              touchTooltipData:
                                                  TouchTooltipData(
                                                      tooltipBgColor:
                                                          Colors.grey,
                                                      getTooltipItems: (spots) {
                                                        return spots.map(
                                                            (TouchedSpot spot) {
                                                          return null;
                                                        }).toList();
                                                      }),
                                              touchResponseSink:
                                                  barTouchedResultStreamController
                                                      .sink,
                                            ),
                                            titlesData: FlTitlesData(
                                              show: true,
                                              bottomTitles: SideTitles(
                                                showTitles: true,
                                                textStyle: TextStyle(
                                                    color:
                                                        const Color(0xff7589a2),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                                margin: 10,
                                                getTitles: (double value) {
                                                  switch (value.toInt()) {
                                                    case 0:
                                                      return '一\n9.10';
                                                    case 1:
                                                      return '二\n9.11';
                                                    case 2:
                                                      return '三\n9.12';
                                                    case 3:
                                                      return '四\n9.13';
                                                    case 4:
                                                      return '五\n9.14';
                                                    case 5:
                                                      return '六\n9.15';
                                                    case 6:
                                                      return '七\n9.16';
                                                  }
                                                },
                                              ),
                                              leftTitles: SideTitles(
                                                showTitles: true,
                                                textStyle: TextStyle(
                                                    color:
                                                        const Color(0xff7589a2),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                                margin: 20,
                                                reservedSize: 14,
                                                getTitles: (value) {
                                                  if (value == 0) {
                                                    return '0';
                                                  } else if (value == 4) {
                                                    return '2';
                                                  } else if (value == 8) {
                                                    return '4';
                                                  } else if (value == 12) {
                                                    return '6';
                                                  } else if (value == 16) {
                                                    return '8';
                                                  } else if (value == 20) {
                                                    return '10';
                                                  } else {
                                                    return '';
                                                  }
                                                },
                                              ),
                                            ),
                                            borderData: FlBorderData(
                                              show: false,
                                            ),
                                            barGroups: showingBarGroups,
                                          )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 18,
                                  height: 4.5,
                                  color: Color(0xffff5182),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('睡眠不足'),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  width: 18,
                                  height: 4.5,
                                  color: Color(0xff53fdd7),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('睡眠充足'),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  width: 18,
                                  height: 4.5,
                                  color: Color(0xFF4688FA),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('睡眠过多')
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              '示例范围：7小时以内睡眠不足；7-9小时内为睡眠充足；9小时以上为睡眠过多',
                              style: TextStyle(fontSize: 9),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                  Gaps.vGap20,
                  Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 50),
                      color: Color(0xFFEEEEEE),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '周平均值统计',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                color: Colors.white,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      _getchildWidget('平均入睡统计','23：25', Color(0xFF4688FA) , 95.55),
                                      _getchildWidget('综合得分','88',Color(0xff53fdd7) , 88.05),
                                      _getchildWidget('平均睡眠时长','08h00min', Color(0xffff5182), 35.25)
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '同上周对比',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                color: Colors.white,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      _getAnimatedCircularChart('2', Colors.orange , 95.55,2),
                                      Text('睡眠时长'),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      _getAnimatedCircularChart('稳定', Colors.purpleAccent , 66.6,2),
                                      Text('入睡时间'),
                                    ],
                                  ),
                                )),
                          ])),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height: 40,
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.orange,
                  child: Text(
                    '添加睡眠记录',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () {
                    DatePicker.showTimePicker(context, showTitleActions: true,
                        onChanged: (date) {
                          print('change $date in time zone ' +
                              date.timeZoneOffset.inHours.toString());
                        }, onConfirm: (date) {
                          print('confirm $date');
                        }, currentTime: DateTime.now());

                  },
                ),
              ),
            )
          ],
        ));
  }

  _getchildWidget(String title,String num,Color color,double percent) {
    return Column(
      children: <Widget>[
        _getAnimatedCircularChart(num,color,percent,1),
        Text(title),
      ],
    );
  }

  _getAnimatedCircularChart(String num,Color color,double percent,int where) {
    return AnimatedCircularChart(
      size: where == 1? _chartSize1 : _chartSize2 ,
      initialChartData: <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            new CircularSegmentEntry(
              100.00 - percent,
              Colors.grey[100],
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              percent,
              color,
              rankKey: 'remaining',
            ),
          ],
          rankKey: 'progress',
        ),
      ],
      chartType: CircularChartType.Radial,
      percentageValues: true,
      holeLabel: num,
      labelStyle: new TextStyle(
        color: Colors.blueGrey[600],
        fontWeight: FontWeight.bold,
        fontSize: where == 1? 15.0:12.0,
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: y1 < 14 ? lessBarColor:(y1 >= 14 && y1 <= 18)? normalBarColor : moreBarColor,
        width: width,
        isRound: true,
      ),
//      BarChartRodData(
//        y: y2,
//        color: rightBarColor,
//        width: width,
//        isRound: true,
//      ),
    ]);
  }
}
