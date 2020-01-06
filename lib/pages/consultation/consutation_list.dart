import 'package:flutter/material.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/common_dio.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/pages/consultation/consultation_detail_page.dart';
import 'package:flutter_first/pages/consultation/topic_page.dart';
import 'package:flutter_first/res/colors.dart';
import 'package:flutter_first/util/navigator_util.dart';
import 'package:flutter_first/util/toast.dart';

class ConsutationList extends StatefulWidget {
  @override
  _ConsutationListState createState() => _ConsutationListState();
}

class _ConsutationListState extends State<ConsutationList> {
  List<ConsulationColumnsInfo> columnsInfoList = List();
  String defaultImage =
      'https://www.aireading.club/phms_resource_base/image_base/BJ_YaJianKang_02.jpg';
  @override
  void initState() {
    _getColumnsInfo();
  }
  void _getColumnsInfo() {
    DioUtils.instance.requestNetwork<ConsulationColumnsInfo>(
      Method.get,
      Api.GETDEFAUTLTCOLUMNINFO,
      queryParameters: {"columnId": 1, "pageSize": 10, "pageNumber": 1},
      isList: true,
      onSuccessList: (data) {
        setState(() {
          columnsInfoList.addAll(data);
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
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        backgroundColor: Color(0xff2CA687),
        title: Text(
          '资讯',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          itemCount: columnsInfoList.length,
          itemBuilder: (context, index) => _buildItem(index)),
    );
  }
  _buildItem(int index) {
    return GestureDetector(
      child: (columnsInfoList[index].cover2 == null ||
          columnsInfoList[index].cover3 == null)
          ? getContentItem(columnsInfoList[index], index)
          : getThreeImagItem(columnsInfoList[index]),
      onTap: () {
        if (columnsInfoList[index].type == 'T') {
          NavigatorUtil.pushPage(context, TopicPage(columnsInfoList[index].id));
          CommonRequest.UserReadingLog(
              columnsInfoList[index].id, columnsInfoList[index].type, 'DJ');
        } else {
          NavigatorUtil.pushPage(
              context,
              ConsultationDetailPage(
                id: columnsInfoList[index].id,
                imgurl: columnsInfoList[index].cover1,
              ));
          CommonRequest.UserReadingLog(
              columnsInfoList[index].id, columnsInfoList[index].type, 'YD');
        }
      },
    );
  }
  getContentItem(ConsulationColumnsInfo item, int index) {
    return Column(
      children: <Widget>[
        Container(
            height: 90,
            color: Colors.white,
            padding: EdgeInsets.only(
                left: 5.0, right: 10.0, bottom: 10.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 3),
                            child: Text(
                              item.title,
                              style: TextStyle(fontSize: 15),
                              strutStyle: StrutStyle(height: 1.5),
                            ),
                          ),
                          Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '中国健康网',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 11),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '12小时前',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 11),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Image.network(
                    item.cover1 ?? defaultImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )),
        Container(
          color: Colours.line,
          height: 1,
          margin: EdgeInsets.only(left: 10, right: 10),
        )
      ],
    );
  }

  getThreeImagItem(ConsulationColumnsInfo item) {
    return Container(
        height: 135,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 5.0),
        padding:
        const EdgeInsets.only(left: 10.0, right: 10.0, top: 5, bottom: 5.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 2,
              color: Colors.black12,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(item.title),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Image.network(
                    item.cover1 ?? defaultImage,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    item.cover2 ?? defaultImage,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Image.network(
                    item.cover3 ?? defaultImage,
                    height: 85,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )
          ],
        ));
  }


}
