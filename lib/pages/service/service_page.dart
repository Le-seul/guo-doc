import 'package:flutter/material.dart';
import 'package:flutter_first/util/router.dart';


class ServicePage extends StatelessWidget {
  const ServicePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.black54,
          height: 23,
          alignment: Alignment.center,
          child: Text('服务',style: TextStyle(fontSize: 18,color: Colors.white),
          ),
        ),//服务
        SizedBox(
          height: 9,
          child: Container(
            color: Colors.grey[200],
          ),
        ),
        Container(
          height: 30,
          child: Row(
            children: <Widget>[
              Text('  心灵之约'),
              SizedBox(width: 75,),
              Container(

                width: 80,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child:Row(
                    children: <Widget>[
                      Image.asset('assets/images/jiahao.png',color: Colors.grey),
                      Text('发起咨询',style: TextStyle(fontSize: 12,color: Colors.grey),)
                    ],
                  ),
                  onPressed: (){},
                ),
              ),//发起咨询
              Container(

                width: 80,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child:Row(
                    children: <Widget>[
                      Image.asset('assets/images/dianhua.png',color: Colors.black54,),
                      Text('咨询热线',style: TextStyle(fontSize: 12),)
                    ],
                  ),
                  onPressed: (){},
                ),
              ),//咨询热线
              Container(

                width: 60,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child:(
                      Text('更多',style: TextStyle(fontSize: 12,color: Colors.grey),)

                  ),
                  onPressed: (){},
                ),
              )//更多
            ],
          ),
        ) , //心灵之约
        SizedBox(
          height: 2,
          child: Container(
            color: Colors.grey[200],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: 100,
          child: Row(
            children: <Widget>[
              Expanded(

                flex: 3,
                child: Image.network(
                  'http://image.uczzd.cn/793049627461073302.jpg',
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                flex: 9,
                child: Container(
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('2018年全局高位冠心病患者越来越多',style: TextStyle(fontSize: 15),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '       2019-06-23',
                              style: TextStyle(fontSize: 13, color: Colors.black26),
                              textAlign: TextAlign.left,
                            ),
                            Text('等待审核',style: TextStyle(color: Colors.green),)
                          ],
                        )

                      ],
                    )),
              ),
              Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_forward_ios)
              ),

            ],
          ),
        ),  // 新闻一
        SizedBox(
          height: 2,
          child: Container(
            color: Colors.grey[200],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: 100,
          child: Row(
            children: <Widget>[
              Expanded(

                flex: 3,
                child: Image.network(
                  'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=445686649,1913530531&fm=26&gp=0.jpg',
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                flex: 9,
                child: Container(
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('经常失眠,工作不好,这可咋整啊!',style: TextStyle(fontSize: 15),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '       2019-06-23',
                              style: TextStyle(fontSize: 13, color: Colors.black26),
                              textAlign: TextAlign.left,
                            ),
                            Text('已结束',style: TextStyle(color: Colors.black54),)
                          ],
                        )

                      ],
                    )),
              ),
              Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_forward_ios)
              ),

            ],
          ),
        ),  //新闻二
        SizedBox(
          height: 9,
          child: Container(
            color: Colors.grey[200],
          ),
        ),
        Container(
          height: 30,
          child: Row(
            children: <Widget>[
              Text('  健康咨询'),
              SizedBox(width: 115,),
              Container(

                width: 90,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child:Row(
                    children: <Widget>[
                      Image.asset('assets/images/jiahao.png',color: Colors.blue,),
                      Text('发起咨询',style: TextStyle(fontSize: 12,color: Colors.blue,),)
                    ],
                  ),
                  onPressed: (){
                    Router.pushNoParams(context, Router.healthyconsultation);
                  },
                ),
              ),//发起咨询
              SizedBox(width: 30,),
              Container(

                width: 60,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child:(
                      Text('更多',style: TextStyle(fontSize: 12,color: Colors.grey),)

                  ),
                  onPressed: (){},
                ),
              )//更多
            ],
          ),
        ) , //健康咨询
        SizedBox(
          height: 2,
          child: Container(
            color: Colors.grey[200],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: 100,
          child: Row(
            children: <Widget>[
              Expanded(

                flex: 3,
                child: Image.network(
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1565148151&di=61e65806b8e90b29b3c5a722b06f1bb6&imgtype=jpg&er=1&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn17%2F300%2Fw600h500%2F20180427%2F1a85-fzrwiaz0412254.jpg',
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(width: 20,
                child: Center(child: Icon(Icons.brightness_1,color: Colors.red,size:17,),),),
              Expanded(
                flex: 9,
                child: Container(
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('最近总是便秘,怎么解决?',style: TextStyle(fontSize: 15),softWrap: false,),
                        Text('早起喝一杯凉白开,做深深的蹲坑运动',style: TextStyle(fontSize: 15,color: Colors.red),softWrap:false,overflow:TextOverflow.ellipsis ,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '       2019-06-23',
                              style: TextStyle(fontSize: 13, color: Colors.black26),
                              textAlign: TextAlign.left,
                            ),
                            Text('等待审核',style: TextStyle(color: Colors.green),)
                          ],
                        )

                      ],
                    )),
              ),
              Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_forward_ios)
              ),

            ],
          ),
        ),  // 新闻一
        SizedBox(
          height: 2,
          child: Container(
            color: Colors.grey[200],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: 100,
          child: Row(
            children: <Widget>[
              Expanded(

                flex: 3,
                child: Image.network(
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564553493056&di=1598d39733d59a1b20eb0e605f6301f3&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_70%2Cc_zoom%2Cw_640%2Fimages%2F20180618%2F82502d45499248f481417604fc2206fc.jpeg',
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                flex: 9,
                child: Container(
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('舌苔发黄,很厚,食欲不振,口气贼大',style: TextStyle(fontSize: 15),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '       2019-06-23',
                              style: TextStyle(fontSize: 13, color: Colors.black26),
                              textAlign: TextAlign.left,
                            ),
                            Text('已结束',style: TextStyle(color: Colors.black54),)
                          ],
                        )

                      ],
                    )),
              ),
              Expanded(
                  flex: 1,
                  child: Icon(Icons.arrow_forward_ios)
              ),

            ],
          ),
        ),  //新闻二
        SizedBox(
          height: 9,
          child: Container(
            color: Colors.grey[200],
          ),
        ),
        Container(
          height: 30,
          child: Row(
            children: <Widget>[
              Text('  活动参与'),
              SizedBox(width: 235,),

              Container(

                width: 60,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  child:(
                      Text('更多',style: TextStyle(fontSize: 12,color: Colors.grey),)

                  ),
                  onPressed: (){},
                ),
              )//更多
            ],
          ),
        ) , //活动参与
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 9),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: FlatButton(
                            onPressed:(){
                               Router.pushNoParams(context, Router.serviceActivity1);
                            },
                            child: Image.network('http://s.114study.com/images/admin_xly_upload/upload/xly/big/20180408181106136040.jpg'),))
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 13,
                          child: Text('808心理服务中心亲子夏令营',style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text('  40人报名  40人参与',style: TextStyle(fontSize: 10,color: Colors.grey),),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('  进行中  ',style: TextStyle(fontSize: 10,color: Colors.green) ,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 9),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: FlatButton(onPressed:(){Router.pushNoParams(context, Router.serviceActivity2);}, child: Image.network('http://jyj.jl.gov.cn/tpxw/201903/W020190318527359045201.jpg'),))
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 13,
                          child: Text('监管总队心血管病防治讲座',style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text('  40人报名  40人参与',style: TextStyle(fontSize: 10,color: Colors.grey),),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('  进行中  ',style: TextStyle(fontSize: 10,color: Colors.green) ,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 9),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: FlatButton(onPressed:(){}, child: Image.network('http://m.kgvtd.cn/koucai/picture/xlsz-list1.png'),))
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 13,
                          child: Text('心理健康培训',style: TextStyle(fontWeight: FontWeight.w600),),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text('  40人报名  40人参与',style: TextStyle(fontSize: 10,color: Colors.grey),),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('  进行中  ',style: TextStyle(fontSize: 10,color: Colors.green) ,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2,
                child: Container(
                  color: Colors.grey[200],
                ),
              ),

            ],
          ),
        ), //活动

      ],
    );




  }
}


