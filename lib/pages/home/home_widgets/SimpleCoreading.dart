import 'package:flutter/material.dart';
import 'package:flutter_first/bean/togetheread.dart';
import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/router.dart';
import 'package:flutter_first/widgets/loading_widget.dart';

class SimpleCoreading extends StatefulWidget {
  @override
  _SimpleCoreadingState createState() => _SimpleCoreadingState();
}

class _SimpleCoreadingState extends State<SimpleCoreading> {
List<Togetheread> Togethereadinglist = List();
List<Togetheread> Imagelist = List();
bool isShowLoading = true;
  void initState(){
    _requestImage();
  }

  void _requestImage() {
    DioUtils.instance.requestNetwork<Togetheread>(
        Method.get,
        Api.Togetheread,
        isList: true,
        onSuccessList: (data) {
          setState(() {
            Togethereadinglist = data;
            isShowLoading = false;
            for (Togetheread item in Togethereadinglist){
              for ( int i = 0;i<=Togethereadinglist.length;i++){
                if(item.id == "$i"){
                  Imagelist.add(item);
                }
              }
            }
          });
        },
        onError: (code, msg) {
          print("sssss");
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('简单共读'),
          centerTitle: true,
      ),
      body: isShowLoading
          ? LoadingWidget.childWidget()
          : (Imagelist.length == 0 )
          ? Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: Text('暂无数据'),
      )
          :ListView(
        children: <Widget>[
          Container(
            height: 280,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: InkWell(
                    child: Container(
                      child: Image.network(
                        Imagelist[0].coverImgId,
                        height: 240,
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: (){
                      Router.pushNoParams(context, Router.simplereading);
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: InkWell(
                    child: Image.network(
                      Imagelist[1].coverImgId,
                      height: 100,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 250,
              width: 250,
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Container(
                        child: Image.network(
                          Imagelist[2].coverImgId,
                          fit: BoxFit.fill,
                        ),
                      )),
                  Expanded(
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Image.network(
                              Imagelist[3].coverImgId,
                            ),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    Imagelist[3].shortDesc,
                                    style: TextStyle(color: Colors.grey),),
                                  flex: 3,
                                ),
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text('2019',style: TextStyle(color: Colors.grey),),
                                        flex: 4,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                            onTap: () {},
                                            child: ClipRRect(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 25,
                                                  width: 50,
                                                  child: Text(
                                                    '现在加入',
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                  color: Colors.red,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8))),
                                        flex: 3,
                                      )
                                    ],
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                            flex: 5,
                          ),
                          SizedBox(
                            width: 14,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
