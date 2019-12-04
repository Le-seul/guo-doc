import 'package:flutter/material.dart';
import 'package:flutter_first/widgets/my_card.dart';

class ActivityList2 extends StatefulWidget {
  @override
  _ActivityList2State createState() => _ActivityList2State();
}

class _ActivityList2State extends State<ActivityList2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFEEEEEE),
        child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) => _buildItem(index),
        ));
  }

  _buildItem(int index) {
    return GestureDetector(
      onTap: () {
//        NavigatorUtil.pushPage(context,MusicListPage(allMusicList: getTagMusicList[index]));
      },
      child: Container(
          padding: EdgeInsets.only(left: 10,right: 10,bottom: 15),
          child: MyCard(
            child: Container(
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              'http://pic.sc.chinaz.com/files/pic/pic9/201811/zzpic15375.jpg',
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Text('北京中日友好医院体检中心大型义诊活动'),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.access_time,
                                    size: 15,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '时间：2019-12-25 09:30:00',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    size: 15,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Text(
                                    '地点：北京市东城区银闸胡同25号',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.perm_identity,
                                    size: 15,
                                    color: Colors.black45,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '负责人：闫吉',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black45,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(height: 2,color: Color(0xFFEEEEEE),),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.check_circle,size: 18,color: Colors.black45,),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: Text('开启活动提醒',style: TextStyle(fontSize: 12),)),
                      Container(
                        padding: EdgeInsets.only(left: 14,right: 14,bottom: 6,top: 6),
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text('我要报名',style: TextStyle(color: Colors.white,fontSize: 12),),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
