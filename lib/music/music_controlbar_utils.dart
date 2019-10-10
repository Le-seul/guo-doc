

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/bean/music.dart';
import 'package:marquee/marquee.dart';

import 'cached_image.dart';

class MusicControlBar {
  static OverlayEntry tinyControlbar;
  static OverlayEntry controlBar;
  static  double dx,dy;
  static bool hide = false;
  static String _positonText="00:00";

  static showTinyControlbar(BuildContext context) {
    tinyControlbar = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return new Positioned(
        top: dy,
        left: 0,
        child:new Material(
          child: Container(
            height: 50,
            color: Colors.grey,
            child:
            IconButton(
              padding:EdgeInsets.fromLTRB(0, 8, 0, 8),
              icon: Icon(Icons.navigate_next,color: Colors.white70,),onPressed: (){
              tinyControlbar.remove();
              tinyControlbar = null;
              hideControlBar(context);
              print("click close");
            },),
          ),
        ),
      );
    });
    //往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(tinyControlbar);
  }

  static hideControlBar(BuildContext context) {
    hide = false;
    Overlay.of(context).setState((){});
  }

  static removeControlBar() {
      if(controlBar != null) {
        controlBar.remove();
        controlBar = null;
      }
      if(tinyControlbar != null) {
        tinyControlbar.remove();
        tinyControlbar = null;
      }
  }

  static showControlBar(BuildContext context,Music music,String positionText,String durationText) {
    dy = ScreenUtil.getInstance().screenHeight * 0.7;
    dx = 15;
    _positonText = positionText;
    print("show $dx $dy");
    controlBar = new OverlayEntry(builder: (context) {
      //外层使用Positioned进行定位，控制在Overlay中的位置
      return new Positioned(
          top: dy,
          left: dx,
          child: Offstage(
            offstage: hide,
            child: GestureDetector(
              onVerticalDragUpdate:(DragUpdateDetails details){
                final RenderObject box = context.findRenderObject();
                //  获得自定义Widget的大小，用来计算Widget的中心锚点
//            dx = details.globalPosition.dx ;
                dy = details.globalPosition.dy ;
                print("vertical drag $dx $dy");
                Overlay.of(context).setState((){});
              } ,
              onHorizontalDragUpdate: (DragUpdateDetails details){
                final RenderObject box = context.findRenderObject();
                //  获得自定义Widget的大小，用来计算Widget的中心锚点
//            dx = details.globalPosition.dx ;
                if(details.delta.dx < -10) {
                  print("hide action");
                  hide = true;
                  if(tinyControlbar == null) {
                    Overlay.of(context).setState((){});
                    showTinyControlbar(context);
                  }
                }
              },
              child: new Material(
                child: Container(
                  height: 50,
                  constraints: BoxConstraints(minWidth: 300),
                  color: Colors.grey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image(
                          width: 42,
                          height: 42,
                          image: CachedImage(music.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 100,
                        margin: EdgeInsets.only(left:4),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 30,
                              child: Marquee(
                                text:music.name,style: TextStyle(color:Colors.white,fontSize: 16),),
                            ),
                            Expanded(child: Text("$_positonText/$durationText",style: TextStyle(color:Colors.white,fontSize: 13),))
                          ],
                        ),
                      ),
                      IconButton(icon: Icon(Icons.pause,color: Colors.white,),onPressed: ()=>print("click pause"),),
                      IconButton(icon: Icon(Icons.skip_next,color: Colors.white,),onPressed: ()=>print("click next"),),
                      IconButton(icon: Icon(Icons.close,color: Colors.white70,),onPressed: ()=>print("click close"),),
                    ],
                  )
                  ,),
              ),
            ),
          ));
    });
    //往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(controlBar);


  }
}
