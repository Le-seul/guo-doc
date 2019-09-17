import 'package:flutter/material.dart';
import 'package:flutter_first/bean/psycourse.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/loading_widget.dart';

class Curriculum extends StatefulWidget {
  Curriculum({Key key}) : super(key: key);

  @override
  _CurriculumState createState() => _CurriculumState();
}

class _CurriculumState extends State<Curriculum> {
  bool isShowLoading = true;
  List<Psycourse> psycourselist = List();
  List<Psycourse> mycourselist = List(); //我的课程
  List<Psycourse> emotionlist = List(); //情绪调节
  @override
  void initState() {
    _requestPsycourse1();
  }

  void _requestPsycourse1() {
    DioUtils.instance.requestNetwork<Psycourse>(
        Method.get,
        Api.PSYCOURSE,
        isList: true,
        onSuccessList: (data) {
          setState(() {
            psycourselist = data;
            isShowLoading = false;
            for(Psycourse index in psycourselist) {
              if (index.categoryId == "情绪调节") {
                emotionlist.add(index);
              }
              if (index.recmmend == "1") {
                mycourselist.add(index);
              }
            }
          });
          },

        onError: (code, msg) {
          print("sssss");
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('课程'),
          centerTitle: true,
        ),
        body: isShowLoading
            ? LoadingWidget.childWidget()
            : (mycourselist.length == 0 && emotionlist.length == 0)
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Text('暂无数据'),
                  )
                : SingleChildScrollView(
                    child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '我的课程',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Icon(Icons.chevron_right),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                                onTap: () {},
                              ),
                              SizedBox(
                                height: 20,
                                child: Text(psycourselist[0].name),
                              ),
                              InkWell(
                                child: Image.network(
                                  mycourselist[0].coverImgId,
                                  height: 150,
                                  width: 450,
                                  fit: BoxFit.fill,
                                ),
                                onTap: () {
                                  Router.pushNoParams(
                                      context, Router.curriculumcatalog1);
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      emotionlist[0].categoryId,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Icon(Icons.chevron_right),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                                onTap: () {},
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 160,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        emotionlist[0].coverImgId),
                                                    fit: BoxFit.fill)),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  emotionlist[0].name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  emotionlist[0].shortDesc,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 1,
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                    children: <Widget>[
                                                      Positioned(
                                                        left: 15,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 10,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/images/aixin.png'),
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 25,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 10,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/images/喇叭.png'),
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 35,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 10,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/images/云.png'),
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${emotionlist[0].learnedUserCount}+人",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ),

                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 160,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        emotionlist[1].coverImgId),
                                                    fit: BoxFit.fill)),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  emotionlist[1].name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  emotionlist[1].shortDesc,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 1,
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                    children: <Widget>[
                                                      Positioned(
                                                        left: 15,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 10,
                                                          child: Image(
                                                            image: NetworkImage(
                                                                'assets/images/aixin.png'),
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 25,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 10,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/images/喇叭.png'),
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 35,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 10,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/images/云.png'),
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${emotionlist[1].learnedUserCount}+人",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ),

                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 160,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        emotionlist[2].coverImgId),
                                                    fit: BoxFit.fill)),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  emotionlist[2].name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  emotionlist[2].shortDesc,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 1,
                                                  child: Stack(
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                    children: <Widget>[
                                                      Positioned(
                                                        left: 15,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 10,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/images/aixin.png'),
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 25,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 10,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/images/喇叭.png'),
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 35,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 10,
                                                          child: Image(
                                                            image: AssetImage(
                                                                'assets/images/云.png'),
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${emotionlist[2].learnedUserCount}+人",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  ),
                                                ),

                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),

                                ],
                              ),
                            ],
                          )))
                    ],
                  )));
  }
}
