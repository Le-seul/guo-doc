import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/util/image_utils.dart';
import 'package:flutter_first/widgets/my_card.dart';

class SearchHospitalDetail extends StatefulWidget {
  @override
  _SearchHospitalDetailState createState() => _SearchHospitalDetailState();
}

class _SearchHospitalDetailState extends State<SearchHospitalDetail> {
  var list = ['三级甲等', '全国眼科排名第7', '全国口腔排名第4', '全国产科排名第1'];
  bool offstage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '找医院',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.8,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Container(
              height: 24,
              width: 24,
              margin: EdgeInsets.only(right: 15),
              child: loadAssetImage('share.png'),
            ),
            onTap: () {
              Share.text(
                  '我的分享',
                  '北京协和医院:\nhttps://baike.baidu.com/item/%E5%8C%97%E4%BA%AC%E5%8D%8F%E5%92%8C%E5%8C%BB%E9%99%A2/322752?fr=aladdin',
                  'text/plain');
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: Image.network(
                'https://ss0.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1351023654,3275095724&fm=27&gp=0.jpg',
                fit: BoxFit.fill),
            height: 180,
            width: double.infinity,
          ),
          SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: MyCard(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '北京协和医院',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(
                                list.length,
                                (index) => Container(
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          right: 12,
                                          top: 3,
                                          bottom: 3),
                                      child: Text(list[index]),
                                      decoration: BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                    )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  list.add('全国耳鼻喉科第5');
                                  offstage = true;
                                });
                              },
                              child: Offstage(
                                offstage: offstage,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '查看全部',
                                      style:
                                          TextStyle(color: Color(0xff2CA687)),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xff2CA687),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: MyCard(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('挂号方式',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('1、微信公众号：北京114预约挂号'),
                          SizedBox(
                            height: 5,
                          ),
                          Text('2、网络平台：北京统一挂号平台'),
                          SizedBox(
                            height: 5,
                          ),
                          Text('3、电话：010-114、116114'),
                          SizedBox(
                            height: 5,
                          ),
                          Text('4、APP：北京协和医院'),
                          SizedBox(
                            height: 15,
                          ),
                          Text('挂号难度',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            color: Colors.black12,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('儿科：中等（部分医生号源紧张）'),
                          SizedBox(
                            height: 5,
                          ),
                          Text('妇科：困难（号源较紧张）'),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '查看全部挂号难度',
                                style: TextStyle(color: Color(0xff2CA687)),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff2CA687),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: MyCard(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('医院简介',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              '北京协和医院是一所位于北京市东城区，集医疗、科研、教学为一体的大型综合医院。它隶属于中国协和医科大学(2006年改为北京协和医学院/清华大学医学部)，是其临床医学院，同时也是中国医学科学院的临床医学研究所，中华人民共和国卫生部指定的诊治疑难重症的技术指导中心之一。北京协和医院在中国乃至世界享有盛名。医院成立于1921年。现任院长赵玉沛。北京协和医院是中国最早承担外宾医疗任务的单位，医院专门设立外宾和高干门诊部，开设专门的高干、外宾、特需病区。2006年7月28日被中国奥委会定为“国家队运动员医疗服务指定医院”。'),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                '查看全部',
                                style: TextStyle(color: Color(0xff2CA687)),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xff2CA687),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
