import 'package:flutter/material.dart';
import 'package:flutter_first/bean/psyteacherlist.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/number.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class instructor_demeanor_detail extends StatefulWidget {
  PsyTeacherList list;
  instructor_demeanor_detail({Key key, @required this.list})
      : super(key: key);
  @override
  _instructor_demeanor_detailState createState() => _instructor_demeanor_detailState();
}

class _instructor_demeanor_detailState extends State<instructor_demeanor_detail> {
  List<PsyTeacherList> Testlist = List();
  bool ShowState = true ;
  @override
  void _Rank(String id) {
    DioUtils.instance.requestNetwork<PsyTeacherList>(
        Method.get, Api.PsyTeacherList,
        queryParameters: {"id": int.parse(id)},
        isList: true,
        onSuccessList: (data) {
          Testlist = data;
       //   widget.list.state = Testlist[0].state;
          widget.list.likeCount = Testlist[0].likeCount;
        },
        onError: (code, msg) {
          print("sssss");
        });
  }

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);

    return Scaffold(
      backgroundColor: Colours.line,
      appBar: AppBar(
        title: Text('教官风采',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black,size: 32),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            height: ScreenUtil().setHeight(18),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Expanded(flex: 2,
                child:InkWell(
                  child:  Container(
                    margin: EdgeInsets.fromLTRB(20,25,20,25),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage(widget.list.imgId))
                    ),

                  ),
                  onTap: (){
                    showPhoto(context, widget.list.imgId, 0,widget.list.name);
                  },
                ),),
                Expanded(flex: 3,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(

                      child: Text(widget.list.name,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500 ),),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.list.pqc,style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,),
                          SizedBox(height: 5),
                          Text(widget.list.orgId,style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13
                          ),),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    ),
                  ],
                )),
              InkWell(
                child:
                  ShowState==true? Container(
                        margin: EdgeInsets.only(right: 20),
                        height: 36,
                        width:100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(18),right: Radius.circular(18)),
                          border: Border.all(
                            color: Colors.orange,
                            width: 0.5
                          )
                        ),
                  child: Container(
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/consultation/心.png',height: 23,width: 23,color: Colors.orange,),
                          SizedBox(width: 10,),
                          Text('赞',style: TextStyle(color: Colors.orange,fontSize: 16 ),)
                        ],
                      ),
                    )
                  ):Container(
                    margin: EdgeInsets.only(right: 20),
                    height: 36,
                    width:100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(18),right: Radius.circular(18)),
                      color: Colors.orange,
                    ),
                    child: Container(
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/images/consultation/赞.png',height: 23,width: 23,color: Colors.white,),
                          SizedBox(width: 10,),
                          Text( Number(widget.list.likeCount),style: TextStyle(color: Colors.white,fontSize: 16 ),)
                        ],
                      ),
                    ),
                  ),
                onTap: (){
                  setState(() {
                    ShowState = false;
                   // _Rank(widget.list.id);
                  });
                },
                      ),

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.only(left: 20),
            height: ScreenUtil().setHeight(14),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('心理服务格言',style: TextStyle(fontSize: 16)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:Text(widget.list.slogan,style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.only(left: 20),
            height: ScreenUtil().setHeight(14),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('特长.专长(研究方向.教学方向)',style: TextStyle(fontSize: 16)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:Text(widget.list.major,style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13
                    ),),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.only(left: 20),
            height: ScreenUtil().setHeight(37),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('风采展示',style: TextStyle(fontSize: 16)),
                  ),
                ),
                Expanded(
                  flex:3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      //physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.list.showImg.length,
                      itemBuilder: (context,index){
                      return widget.list.showImg[index].showId ==null? Container(
                        ): InkWell(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          height: ScreenUtil().setHeight(20),
                          width: ScreenUtil().setHeight(20),
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(widget.list.showImg[index].showId)),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                        ),
                        onTap: (){
                          showPhoto(context, widget.list.showImg[index].showId, index, widget.list.name);
                        },
                      );

                      },
                  )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.only(left: 20),
            height: ScreenUtil().setHeight(20),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex:1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('参与培训及服务情况',style: TextStyle(fontSize: 16)),
                  ),
                ),
                Expanded(
                  flex:2,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child:Text(widget.list.shortDesc,maxLines: 5,overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13
                    ),),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20,top: 10),
          color: Colors.white,
          child: Text('心理足迹',style: TextStyle(fontSize: 16),),),
          GestureDetector(
            child:Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 1),
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), 15, ScreenUtil().setWidth(5), 15),
              height: ScreenUtil().setHeight(20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/consultation/中心1.png',fit: BoxFit.fill),
                    height: ScreenUtil().setHeight(13),
                    width: ScreenUtil().setHeight(18),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 13),),
                          SizedBox(height: 5,),
                          Container(
                            child:Text('心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 12,color: Colors.grey),softWrap: true,maxLines: 3,),
                          )
                        ],
                      ),
                    ),)

                ],
              ),
            ),
            onTap: (){Router.push(context, 'http://news.cpd.com.cn/n18151/201910/t20191030_862809.html',{"title":'时事新闻'});},
          ),
          GestureDetector(
            child:Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 1),
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), 15, ScreenUtil().setWidth(5), 15),
              height: ScreenUtil().setHeight(20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/consultation/中心2.png',fit: BoxFit.fill),
                    height: ScreenUtil().setHeight(13),
                    width: ScreenUtil().setHeight(18),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 13),),
                          SizedBox(height: 5,),
                          Container(
                            child:Text('心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 12,color: Colors.grey),softWrap: true,maxLines: 3,),
                          )
                        ],
                      ),
                    ),)

                ],
              ),
            ),
            onTap: (){Router.push(context, 'http://news.cpd.com.cn/n18151/201910/t20191030_862812.html',{"title":'时事新闻'});},
          ),
          GestureDetector(
            child:Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 1),
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(5), 15, ScreenUtil().setWidth(5), 15),
              height: ScreenUtil().setHeight(20),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/consultation/中心3.png',fit: BoxFit.fill),
                    height: ScreenUtil().setHeight(13),
                    width: ScreenUtil().setHeight(18),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 13),),
                          SizedBox(height: 5,),
                          Container(
                            child:Text('心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结心理健康服务中心为民警解开心结',style: TextStyle(fontSize: 12,color: Colors.grey),softWrap: true,maxLines: 3,),
                          )
                        ],
                      ),
                    ),)

                ],
              ),
            ),
            onTap: (){Router.push(context, 'http://news.cpd.com.cn/n18151/201910/t20191030_862813.html',{"title":'时事新闻'});},
          ),
        ],
      )
    );

  }
}
void showPhoto(BuildContext context,f,index,name) {
  Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
              title: Text('${name}')
          ),
          body: SizedBox.expand(
            child: Hero(
              tag: index,
              child: new Photo(url:f),
            ),
          ),
        );
      }
  ));
}
class Photo extends StatefulWidget {
  const Photo({Key key, this.url}) : super(key: key);
  final url;
  @override
  State<StatefulWidget> createState() {
    return PhotoState();
  }
}

class PhotoState extends State<Photo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;
  double _kMinFlingVelocity = 600.0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      setState(() {
        _offset = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    // widget的屏幕宽度
    final Offset minOffset = Offset(size.width, size.height) * (1.0 - _scale);
    // 限制他的最小尺寸
    return Offset(
        offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));

  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      // 计算图片放大后的位置
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 3.0);
      // 限制放大倍数 1~3倍
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
      // 更新当前位置
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity) return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    // 计算当前的方向
    final double distance = (Offset.zero & context.size).shortestSide;
    // 计算放大倍速，并相应的放大宽和高，比如原来是600*480的图片，放大后倍数为1.25倍时，宽和高是同时变化的
    _animation = _controller.drive(Tween<Offset>(
        begin: _offset, end: _clampOffset(_offset + direction * distance)));
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      child: ClipRect(
        child: Transform(
          transform: Matrix4.identity()..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: Image.network(widget.url,fit: BoxFit.cover,),
        ),
        // child: Image.network(widget.url,fit: BoxFit.cover,),
      ),
    );
  }
}