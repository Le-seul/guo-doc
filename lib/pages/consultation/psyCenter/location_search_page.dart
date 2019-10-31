import 'package:flutter/material.dart';
import 'package:flutter_first/res/colors.dart';

class LocationSearch extends StatefulWidget {
  @override
  _LocationSearchState createState() => _LocationSearchState();
}
var list = [
{
"image":'https://gss2.bdstatic.com/-fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=c4e946962d738bd4d02cba63c0e2ecb3/8b13632762d0f7038fd2ac970bfa513d2697c51c.jpg',
  "location":"东城"
},
{
"image":'https://gss3.bdstatic.com/7Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike72%2C5%2C5%2C72%2C24/sign=ced9cf62b251f819e5280b18bbdd2188/30adcbef76094b365b6452a4a1cc7cd98c109d81.jpg',
"location":"西城"
},
{
"image":'https://gss0.bdstatic.com/94o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=a9d0a80c75ec54e755e1124cd851f035/574e9258d109b3de146dc15ac2bf6c81800a4c35.jpg',
"location":"朝阳"
},
{
"image":'https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=11bc13d36cd9f2d3341c2cbdc885e176/9c16fdfaaf51f3dedec795569aeef01f3a29798e.jpg',
"location":"丰台"
},
{
"image":'https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=b026b989034f78f0940692a118586130/d439b6003af33a87a29b27c7c65c10385243b57c.jpg',
"location":"石景山"
},
{
"image":'https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=682b678ab60e7bec37d70bb34e47d25d/dc54564e9258d109e2f4da37df58ccbf6c814d1b.jpg',
"location":"海淀"
},
{
"image":'https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=1e49fd199316fdfacc61cebcd5e6e731/f636afc379310a550abfd8c6b94543a98226106c.jpg',
"location":"门头沟"
},
{
"image":'https://gss0.bdstatic.com/94o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=189c93a6fcf2b211f0238d1cabe90e5d/fd039245d688d43f8f3064277a1ed21b0ff43b4d.jpg',
"location":"房山"
},
{
"image":'https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=1fe8490413950a7b613846966bb809bc/4ec2d5628535e5ddb4f1b7ed78c6a7efce1b6226.jpg',
"location":"通州"
},
{
"image":'https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=2e25c011c6fcc3cea0cdc161f32cbded/d01373f082025aafcd3a32f8f5edab64034f1afc.jpg',
"location":"顺义"
},
{
"image":'https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike220%2C5%2C5%2C220%2C73/sign=9b1827ab07f3d7ca18fb37249376d56c/c75c10385343fbf2b12bc6b6bb7eca8065388f1b.jpg',
"location":"昌平"
},
{
"image":'https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=635833f0a3345982d187edc06d9d5ac8/f2deb48f8c5494ee049aa89d23f5e0fe98257efe.jpg',
"location":"大兴"
},
{
"image":'https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike150%2C5%2C5%2C150%2C50/sign=635833f0a3345982d187edc06d9d5ac8/f2deb48f8c5494ee049aa89d23f5e0fe98257efe.jpg',
"location":"怀柔"
},
{
"image":'https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=398a540640fbfbedc8543e2d19999c53/b7003af33a87e950560f36551b385343fbf2b4eb.jpg',
"location":"平谷"
},
{
"image":'https://gss2.bdstatic.com/-fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=dd7c9f3ea81ea8d39e2f7c56f6635b2b/267f9e2f07082838f1b6f491b699a9014d08f1f8.jpg',
"location":"密云"
},
{
"image":'https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=b5c26d3db60e7bec37d70bb34e47d25d/e7cd7b899e510fb383e70ea5d733c895d1430c01.jpg',
"location":"延庆"
},
];
class _LocationSearchState extends State<LocationSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.line,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          '请选择所在区',
          style: new TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body:GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1.8),
          itemCount: 16,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: NetworkImage(list[index]['image']),fit: BoxFit.fill)
              ),
              
              child: Center(
                child: Text(list[index]['location'],style: TextStyle(fontSize: 16,color: Colors.white),),
              ),
            );
          })
    );
  }
}
