import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class GraphicConsultation extends StatefulWidget {
  @override
  _GraphicConsultationState createState() => _GraphicConsultationState();
}

class _GraphicConsultationState extends State<GraphicConsultation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black,),
          title: Text('快速提问',style: new TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w600,),),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
      body: Column(
        children: <Widget>[
          Container(
            height: 60,
            color: Color(0xFFFFEBEE),
            alignment: Alignment.center,
          child:  Text('重要通知：文字描述文字描述文字描述文字描述',style: TextStyle(color: Colors.red),),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 15),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                TextField(
                    onChanged: (val) {

                    },
                    maxLines: 10,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: '请简要描述需要咨询的内容，以及期待达到的咨询效果。',
                      contentPadding: EdgeInsets.all(0.0),
                      border: InputBorder.none,
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: list
                )



              ],
            ),
          )

        ],
      ),
      bottomSheet: Container(
        height: 40,
        color: Colors.green,
        alignment: Alignment.center,
        child: Text('立即提交',style: TextStyle(color: Colors.white,fontSize: 18),),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
List<Widget> list = <Widget>[];
  void getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        list.add(new Image.file(image,height: 60,width: 60,fit: BoxFit.fill,));
        list.add(SizedBox(width: 10,));
      });

    }
  }

  @override
  void initState() {
    list.add(GestureDetector(
                child: Image.asset('assets/images/add.png',height: 60,width: 60,fit: BoxFit.fill,),
                onTap: (){
                  getImage();
                },
              ),);
  }
}
