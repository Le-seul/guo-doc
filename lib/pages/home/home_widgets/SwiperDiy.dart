import 'package:flutter/material.dart';
import 'package:flutter_first/pages/home/home_widgets/images_page.dart';
import 'package:flutter_first/util/navigator_util.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_first/mock_request.dart';


class swiperDiy extends StatefulWidget {
  swiperDiy({Key key}) : super(key: key);

  _swiperDiyState createState() => _swiperDiyState();
}

class _swiperDiyState extends State<swiperDiy> {
 var testList = [];


  @override
  void initState(){requestLunBoTu();}

  Widget build(BuildContext context) {
    return Container(
       width: MediaQuery.of(context).size.width,
          height: 200,
          child: Swiper(
            
            itemBuilder:(BuildContext context,int index){
                   return Image.network(
                     this.testList[index],
                     fit: BoxFit.fill,
                   );
            },
            itemCount: testList.length,
            pagination:  SwiperPagination(              
            ),
            
            control:SwiperControl(
              size:0,
            ),  
            onTap: (int index){
              NavigatorUtil.pushPage(context,ImagesPage(indext: index));

            },
            scrollDirection: Axis.horizontal,
            autoplay: true,
          ),
          
    );
  }
  void requestLunBoTu() async{
//    var _request= MockRequest();
  var numb = 0;
    var result=await MockRequest().get('Swiper',params: {'pageNume':numb});
     //tu1 = result['subject'][0]['rating'];
     String tu0 = result['tu1'][0]['image'];
     String tu1 = result['tu1'][1]['image'];
     String tu2 = result['tu1'][2]['image'];
     testList.add(tu0);
     testList.add(tu1);
     testList.add(tu2);
      setState(() {
      });
  }

}

