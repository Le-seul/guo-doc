import 'package:flutter/material.dart';

class Healthyconsultation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('医疗咨询'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
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
          ),
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
          ),
        ],
      ),
    );
  }
}
