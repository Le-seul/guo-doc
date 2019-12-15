

import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class ShareDialog extends Dialog {
  String title;
  String description;
  String thumbnail ='https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577020852&di=5ffa1e446ef7b15a49a323671f8ad0ea&imgtype=jpg&er=1&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F65dc1e295edb3ea37ff9a76b04ad478f8e53d8c418ef-dFDUpd_fw658';
  String webPage;
  ShareDialog({Key key, @required this.title,@required this.description,@required this.webPage, this.thumbnail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Material(
        ///背景透明
        color: Colors.transparent,
        ///保证控件居中效果
        child: new Center(
          ///弹框大小
          child: new SizedBox(
            width: 300.0,
            height: 120.0,
            child: new Container(
              ///弹框背景和圆角
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Image.network('https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2542304542,1875887959&fm=26&gp=0.jpg',fit: BoxFit.fill,),
                        ),
                        onTap: () async {
                          await fluwx.registerWxApi(
                              appId: "wx492f591816c2cd20",
                              doOnAndroid: true,
                              doOnIOS: true,
                              universalLink: 'https://www.aireading.club/phms3/'
                          );
                          await fluwx.shareToWeChat(
                              fluwx.WeChatShareWebPageModel(
                                  webPage:webPage,
                                  title: title,
                                  description: description,
                                  thumbnail: thumbnail,
                                  scene: fluwx.WeChatScene.SESSION
                              ));
                          await Navigator.pop(context);
                        },
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Image.network('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1846534099,2829169951&fm=26&gp=0.jpg',fit: BoxFit.fill,),
                        ),
                        onTap: () async {
                          await fluwx.registerWxApi(
                              appId: "wx492f591816c2cd20",
                              doOnAndroid: true,
                              doOnIOS: true,
                              universalLink: 'https://www.aireading.club/phms3/'
                          );
                          await fluwx.shareToWeChat(
                              fluwx.WeChatShareWebPageModel(
                                  webPage:webPage,
                                  title: title,
                                  description: description,
                                  thumbnail: thumbnail,
                                  scene: fluwx.WeChatScene.TIMELINE
                              ));
                          await Navigator.pop(context);

                        },
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Image.network('https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3566566116,2064301345&fm=26&gp=0.jpg',fit: BoxFit.fill,),
                        ),
                        onTap: () async {
                          await fluwx.registerWxApi(
                              appId: "wx492f591816c2cd20",
                              doOnAndroid: true,
                              doOnIOS: true,
                              universalLink: 'https://www.aireading.club/phms3/'
                          );
                          await fluwx.shareToWeChat(
                              fluwx.WeChatShareWebPageModel(
                                  webPage:webPage,
                                  title: title,
                                  description: description,
                                  thumbnail: thumbnail,
                                  scene: fluwx.WeChatScene.FAVORITE
                              ));
                          await Navigator.pop(context);

                        },
                      ),
                    ],
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: InkWell(
                      child: Container(
                        child: new Text(
                          "取消分享",
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

