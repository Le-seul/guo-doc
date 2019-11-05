import 'package:flutter/material.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SelfHelpPage extends StatelessWidget {
  const SelfHelpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 100, height: 100)..init(context);
    return Scaffold(
      backgroundColor: Colours.line,
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            height:  ScreenUtil().setHeight(7),
            alignment: Alignment.center,
            child: Text(
              '自助',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ), //自助
          Container(
            padding:EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
            child: Row(
              children: <Widget>[
                Container(
                  color: Colours.bg_green,
                  height: ScreenUtil().setHeight(3),
                  width: ScreenUtil().setWidth(1.2),
                ),
                Text('   趣味自测',style: TextStyle(fontSize: 16.5),)
              ],
            ),),
          Container(
            margin: EdgeInsets.all(10),
            height: ScreenUtil().setHeight(40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                          image: DecorationImage(
                            image: NetworkImage('http://imgsrc.baidu.com/imgad/pic/item/1c950a7b02087bf4269f8fcef8d3572c11dfcfa2.jpg'),fit: BoxFit.fill
                          )
                        )
                    ),
                flex: 4,),
                Expanded(flex: 3,child:
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                    color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15,),
                      Text('    如何做到喜欢自己?',style: TextStyle(fontSize: 18),),
                      SizedBox(height: 10,),
                      Text('     这是内容',style: TextStyle(color: Colors.grey.shade600),)
                    ],
                  ),
                ),)
              ],
            ),
          ),
          Container(
            padding:EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
            child: Row(
              children: <Widget>[
                Container(
                  color: Colours.bg_green,
                  height: ScreenUtil().setHeight(3),
                  width: ScreenUtil().setWidth(1.2),
                ),
                Text('   心理课程',style: TextStyle(fontSize: 16.5),),
                SizedBox(width: ScreenUtil().setWidth(57),),
                Text('更多>',style: TextStyle(fontSize: 13.5),),

              ],
            ),),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  height: ScreenUtil().setHeight(30),
                  width: ScreenUtil().setHeight(23),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('https://ss0.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=556585633,4116924195&fm=26&gp=0.jpg'),fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(8),
                      decoration: BoxDecoration(
                          color: Colors.black54 ,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('    如何调节负面情绪',style: TextStyle(color: Colors.white,fontSize: 13.5),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                            Text('     共16讲    ',style: TextStyle(color: Colors.white,fontSize: 11.5),),
                            Icon(Icons.play_circle_outline,size: 15,color: Colors.white,)
                          ],)


                        ],
                      ),

                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: ScreenUtil().setHeight(30),
                  width: ScreenUtil().setHeight(23),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('https://ss0.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=556585633,4116924195&fm=26&gp=0.jpg'),fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(8),
                      decoration: BoxDecoration(
                          color: Colors.black54 ,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('    如何调节负面情绪',style: TextStyle(color: Colors.white,fontSize: 13.5),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('     共16讲    ',style: TextStyle(color: Colors.white,fontSize: 11.5),),
                              Icon(Icons.play_circle_outline,size: 15,color: Colors.white,)
                            ],)


                        ],
                      ),

                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: ScreenUtil().setHeight(30),
                  width: ScreenUtil().setHeight(23),
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('https://ss0.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=556585633,4116924195&fm=26&gp=0.jpg'),fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(8),
                      decoration: BoxDecoration(
                          color: Colors.black54 ,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),bottomLeft: Radius.circular(5))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('    如何调节负面情绪',style: TextStyle(color: Colors.white,fontSize: 13.5),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('     共16讲    ',style: TextStyle(color: Colors.white,fontSize: 11.5),),
                              Icon(Icons.play_circle_outline,size: 15,color: Colors.white,)
                            ],)


                        ],
                      ),

                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
            child: Row(
              children: <Widget>[
                Container(
                  color: Colours.bg_green,
                  height: ScreenUtil().setHeight(3),
                  width: ScreenUtil().setWidth(1.2),
                ),
                Text('   轻松音乐',style: TextStyle(fontSize: 16.5),)
              ],
            ),),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      height: ScreenUtil().setHeight(23),
                      width: ScreenUtil().setHeight(23),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage('http://imgsrc.baidu.com/imgad/pic/item/c2fdfc039245d6880ee16d70aec27d1ed31b2407.jpg'),fit: BoxFit.fill),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Align(
                        alignment: Alignment(-0.7,0.8),
                        child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('我和我的祖国',style: TextStyle(fontSize: 15),),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.headset,color: Colors.grey,size: 15,),
                          Text('  2518',style: TextStyle(color: Colors.grey,),)
                        ],
                      )
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      height: ScreenUtil().setHeight(23),
                      width: ScreenUtil().setHeight(23),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage('http://imgsrc.baidu.com/imgad/pic/item/c2fdfc039245d6880ee16d70aec27d1ed31b2407.jpg'),fit: BoxFit.fill),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Align(
                        alignment: Alignment(-0.7,0.8),
                        child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('我和我的祖国',style: TextStyle(fontSize: 15),),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.headset,color: Colors.grey,size: 15,),
                            Text('  2518',style: TextStyle(color: Colors.grey,),)
                          ],
                        )
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(10),
                      height: ScreenUtil().setHeight(23),
                      width: ScreenUtil().setHeight(23),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage('http://imgsrc.baidu.com/imgad/pic/item/c2fdfc039245d6880ee16d70aec27d1ed31b2407.jpg'),fit: BoxFit.fill),
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      child: Align(
                        alignment: Alignment(-0.7,0.8),
                        child: Icon(Icons.play_circle_outline,size: 30,color: Colors.white,),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('我和我的祖国',style: TextStyle(fontSize: 15),),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.headset,color: Colors.grey,size: 15,),
                            Text('  2518',style: TextStyle(color: Colors.grey,),)
                          ],
                        )
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ],
            ),
          ),
          Container(
            padding:EdgeInsets.only(top: 15,left:ScreenUtil().setWidth(5),bottom: 15 ),
            child: Row(
              children: <Widget>[
                Container(
                  color: Colours.bg_green,
                  height: ScreenUtil().setHeight(3),
                  width: ScreenUtil().setWidth(1.2),
                ),
                Text('   心理共读',style: TextStyle(fontSize: 16.5),)
              ],
            ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(),
              Container(
                height: ScreenUtil().setHeight(4.5),
                width: ScreenUtil().setHeight(14),
                color: Colors.green.shade200,
                child: Center(
                  child: Text('情绪调节',style: TextStyle(color: Colors.grey.shade600),),
                )
              ),
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(14),
                  color: Colors.orange.shade200,
                  child: Center(
                    child: Text('心灵鸡汤',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(14),
                  color: Colors.red.shade200,
                  child: Center(
                    child: Text('散文诗歌',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),

            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(14),
                  color: Colors.green.shade200,
                  child: Center(
                    child: Text('情绪调节',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(14),
                  color: Colors.orange.shade200,
                  child: Center(
                    child: Text('心灵鸡汤',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),SizedBox(),
              Container(
                  height: ScreenUtil().setHeight(4.5),
                  width: ScreenUtil().setHeight(14),
                  color: Colors.red.shade200,
                  child: Center(
                    child: Text('散文诗歌',style: TextStyle(color: Colors.grey.shade600),),
                  )
              ),
              SizedBox(),

            ],
          ),
          SizedBox(
            height: 13,
          ),
          Container(
            height: ScreenUtil().setHeight(25),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex: 1,child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                        image: DecorationImage(
                        image: NetworkImage('https://ss1.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=328381647,2298442252&fm=26&gp=0.jpg'))
                  ),
                )),
                Expanded(flex: 2,child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Text('如何做到喜欢自己',style: TextStyle(fontSize: 18),),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star,color: Colors.orange,),
                        Text('  205人在读',style: TextStyle(color: Colors.orange),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('这是内容',style: TextStyle(color: Colors.grey.shade600))
                  ],
                ),),

              ],
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(25),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex: 1,child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('http://b-ssl.duitang.com/uploads/item/201610/12/20161012150657_2GTru.thumb.700_0.jpeg'))
                  ),
                )),
                Expanded(flex: 2,child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Text('我和世界爱着你',style: TextStyle(fontSize: 18),),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star,color: Colors.orange,),
                        Text('  205人在读',style: TextStyle(color: Colors.orange),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('这是内容',style: TextStyle(color: Colors.grey.shade600))
                  ],
                ),),

              ],
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(25),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Row(
              children: <Widget>[
                Expanded(flex: 1,child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('http://www.wndhw.com/fengjing/zhaopian/images/zp016t13.jpg'))
                  ),
                )),
                Expanded(flex: 2,child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Text('学会调节情绪',style: TextStyle(fontSize: 18),),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star,color: Colors.orange,),
                        Text('  205人在读',style: TextStyle(color: Colors.orange),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('这是内容',style: TextStyle(color: Colors.grey.shade600))
                  ],
                ),),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
