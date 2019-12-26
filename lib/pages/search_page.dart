import 'package:flutter/material.dart';
import 'package:flutter_first/common/common.dart';
import 'package:flutter_first/util/storage_manager.dart';
import 'package:flutter_first/widgets/search.dart';
class SesrchPage extends StatefulWidget {
  @override
  _SesrchPageState createState() => _SesrchPageState();
}

class _SesrchPageState extends State<SesrchPage> {

  TextEditingController _SearchController = TextEditingController();
  var textList = new List<String>();

  @override
  void initState() {
    if(StorageManager.sharedPreferences.getStringList(Constant.searchHistory) != null){
      textList = StorageManager.sharedPreferences.getStringList(Constant.searchHistory);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black,),
        backgroundColor: Colors.white,
        title: SearchTextFieldWidget(
          isborder: true,
          onSubmitted: (text) async{
            setState(() {
              textList.insert(0, text);
              print('搜索提交列表:$textList');
            });
            await StorageManager.sharedPreferences
                .setStringList(Constant.searchHistory, textList);
          },
          controller: _SearchController,
          hintText: '搜索课程',
          onTab: () {},
        ),

      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text('搜索历史',style: TextStyle(fontSize: 16),)),
                GestureDetector(
                    onTap: () async{
                      setState(() {
                        textList.removeRange(0, textList.length);
                      });
                      await StorageManager.sharedPreferences.remove(Constant.searchHistory);
                    },
                    child: Text('清空',style: TextStyle(fontSize: 16,color: Colors.black54),))
              ],
            ),
            SizedBox(height: 10,),
           Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                  textList.length,
                      (index) => Container(
                    padding: EdgeInsets.only(
                        left: 12, right: 12, top: 3, bottom: 3),
                    child: Text(textList[index]),
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(18)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
