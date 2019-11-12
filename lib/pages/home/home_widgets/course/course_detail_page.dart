import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_first/bean/course_detail.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_first/widgets/loading_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CourseDetailPage extends StatefulWidget {
  String courseId;
  CourseDetailPage({Key key, @required this.courseId}) : super(key: key);

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage>
    with SingleTickerProviderStateMixin {
  TabController mTabController;
  CourseDetail courseDetail = new CourseDetail();
  bool isShowLoading = true; //课程目录
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;
  double slider_current_position = 0.0;
  double max_duration = 1.0;
  String _playerTxt = '00:00:00';
  String _maxTxt = '00:00:00';
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
    initializeDateFormatting();
    _requestPsycourse();
    mTabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
  }

  void _requestPsycourse() {
    DioUtils.instance.requestNetwork<CourseDetail>(
        Method.get, Api.GETCOURSTEDETAIL,
        queryParameters: {
          'courseId': widget.courseId,
        }, onSuccess: (data) {
      setState(() {
        isShowLoading = false;
        courseDetail = data;
        print("获取课程详情成功！");
      });
    }, onError: (code, msg) {
      print("获取课程详情失败！");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          '心理课程',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : courseDetail == null
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text('暂无数据'),
                )
              : Container(
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        courseDetail.image,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        height: 60,
                        child: TabBar(
                          isScrollable: false,
                          //是否可以滚动
                          controller: mTabController,
                          labelPadding: EdgeInsets.only(left: 5, right: 5),
                          indicatorColor: Color(0xff2CA687),
                          labelColor: Color(0xff2CA687),
                          unselectedLabelColor: Color(0xff666666),
                          unselectedLabelStyle: TextStyle(fontSize: 16),
                          labelStyle: TextStyle(fontSize: 16.0),
                          tabs: <Widget>[
                            Text('课程详情'),
                            Text('课程目录'),
                          ],
                        ),
                      ),
                      Flexible(
                        child: TabBarView(
                          controller: mTabController,
                          children: <Widget>[
                            Detail(
                              Detailurl: courseDetail.detailDescription,
                            ),
                            itemWidget2(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      bottomSheet: Container(
        height: 65,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 55,
                color: Color(0xFF75C2E0),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 22.0,
                        backgroundImage: NetworkImage(
                            'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1572450655242&di=f0409d79fb8bd4a4daa803137ad3f2a2&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201806%2F27%2F20180627170925_nsPVv.thumb.700_0.jpeg'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                '你猜我在想什么？',
                                style: TextStyle(color: Colors.white),
                              ))),
                      GestureDetector(
                        onTap: (){
                          if(_isPlaying == false){
                            startPlayer();
                          }else{
                            pausePlayer();
                          }
                          setState(() {
                            _isPlaying = !_isPlaying;
                          });

                        },
                        child: Container(
                            padding: EdgeInsets.only(top: 10, right: 10),
                            child: Icon(
                              _isPlaying?Icons.pause_circle_outline:Icons.play_circle_outline,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: <Widget>[
                      Text(_playerTxt),
                      Expanded(
                        child: Container(
                          height: 3,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.white, //进度条滑块左边颜色
                              inactiveTrackColor: Colors.black26, //进度条滑块右边颜色
                              thumbShape: RoundSliderThumbShape(
                                //可继承SliderComponentShape自定义形状
                                disabledThumbRadius: 5, //禁用是滑块大小
                                enabledThumbRadius: 5, //滑块大小
                              ),
                              //提示进度的气泡的背景色
                              //滑块中心的颜色
                              thumbColor: Colors.white,
                            ),
                            child: Slider(
                              value: slider_current_position,
                              onChanged: (double value) async {
                                await flutterSound.seekToPlayer(value.toInt());
                              },
                              min: 0.0,
                              max: max_duration,
                            ),
                          ),
                        ),
                      ),
                      Text(_maxTxt),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void startPlayer() async {
    String path = await flutterSound.startPlayer('http://dn-chunyu.qbox.me/@/media/audios/2016/08/24/b444f575d0ac.3gp.mp3');
    print('傻子吧');
//    File file= await new File(path);
//    List contents = await file.readAsBytesSync();

    // return print("file文件：$contents");
    await flutterSound.setVolume(1.0);
    print('startPlayer: $path');

    try {
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          slider_current_position = e.currentPosition;
          print('当下位置：$slider_current_position');
          max_duration = e.duration;

          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt(),
              isUtc: true);
          DateTime date2 = new DateTime.fromMillisecondsSinceEpoch(
              e.duration.toInt(),
              isUtc: true);
          String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
          String txt2 = DateFormat('mm:ss:SS', 'en_GB').format(date2);
          this.setState(() {
            this._playerTxt = txt.substring(3, 8);
            this._maxTxt = txt2.substring(3,8);
          });
        }
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void stopPlayer() async {
    try {
      String result = await flutterSound.stopPlayer();
      print('stopPlayer: $result');
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }

      this.setState(() {
        this._isPlaying = false;
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void pausePlayer() async {
    String result = await flutterSound.pausePlayer();
  }

  itemWidget2() {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: ListView(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Text(
                '如何利用时间',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 10,
              ),
              Text('共16讲', style: TextStyle(color: Colors.black26))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: courseDetail.chapterList.length,
            itemBuilder: (context, index) =>
                _buildItem(courseDetail.chapterList[index], index),
          ),
        ],
      ),
    );
  }

  _buildItem(ChapterList chapterList, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if(_isPlaying == false){
            startPlayer();
          }else{
            pausePlayer();
          }
          setState(() {
            _isPlaying = !_isPlaying;
          });
        });

//        Router.push(context, Router.catalogdetail,chapterList.detailDescription);
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 1,
            color: Colors.black26,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Text('${index + 1}.', style: TextStyle(fontSize: 18)),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  child:
                      Text(chapterList.name, style: TextStyle(fontSize: 16))),
              _isPlaying?Icon(Icons.pause_circle_outline):Icon(Icons.play_circle_outline),
            ],
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class Detail extends StatefulWidget {
  String Detailurl;
  Detail({
    Key key,
    @required this.Detailurl,
  }) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return WebView(
      initialUrl: widget.Detailurl,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
