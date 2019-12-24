import 'package:flutter/material.dart';
import 'package:flutter_first/bean/collection.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/res/styles.dart';
import 'package:flutter_first/util/toast.dart';
import 'package:flutter_first/widgets/loading_widget.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List<Collection> CollectionList = List();
  bool isShowLoading = true;
  void initState() {

    _getCollection();
  }
  void _getCollection() {
    DioUtils.instance.requestNetwork<Collection>(
      Method.get,
      Api.COLLECTION,
      isList: true,
      onSuccessList: (data) {
        setState(() {
          CollectionList.addAll(data);
          isShowLoading = false;
          print('获取成功');
        });
      },
      onError: (code, msg) {
        setState(() {
          Toast.show('请求失败');
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '收藏',
        ),
        centerTitle: true,
        backgroundColor: Colours.bg_green,
        elevation: 0,
      ),
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : (CollectionList.isEmpty)
          ? Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('暂无数据'),
      )
          :ListView.builder(
          itemCount: CollectionList.length,
          itemBuilder: (context,index){
            return Container(
                height: 93,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 5.0),
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(CollectionList[index].title,style: TextStyle(fontSize: 15,color: Colors.black87),strutStyle: StrutStyle(
                              height: 1.5
                          ),),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '中国健康网',
                                  style: TextStyle(color: Colors.grey,fontSize: 11),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/consultation/查看.png',
                                      height: 9,
                                    ),
                                    Text(' ${CollectionList[index].readCount}',
                                      style: TextStyle(color: Colors.grey,fontSize: 11),
                                    ),
                                    Gaps.hGap8,
                                    Image.asset(
                                      'assets/images/consultation/点赞.png',
                                      height: 11,
                                    ),
                                    Text(' ${CollectionList[index].likeCount}',
                                      style: TextStyle(color: Colors.grey,fontSize: 11),
                                    ),
                                    Gaps.hGap8,
                                    Image.asset(
                                      'assets/images/consultation/分享.png',
                                      height: 11,
                                      color: Colors.grey,
                                    ),
                                    Text(' ${CollectionList[index].transmitCount}',
                                      style: TextStyle(color: Colors.grey,fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Image.network(
                            CollectionList[index].cover1 ,
                            height: 90,
                            fit: BoxFit.fill,
                          ),
                        )
                    )
                  ],
                ));
          }),
    );
  }
}
