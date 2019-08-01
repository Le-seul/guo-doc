import 'package:flutter/material.dart';

class ServiceActivity2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('心血管病防治讲座'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Image.network('http://jyj.jl.gov.cn/tpxw/201903/W020190318527359045201.jpg'),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.all(15),
            child: Text('照省直机关党工委“关于开展送文化、送健康专家讲座服务活动”的通知要求和局党组指示精神，'
                '3月6日，省监狱管理局举办了心血管疾病健康指导讲座，旨在增强局机关民警的保健意识，树立健康的生活理念，'
                '掌握防治心血管疾病的常识，更好地适应工作和生活需要。讲座由王德惠政委主持，局党组部分成员、'
                '集团公司领导及全体机关民警职工听取讲座。省局特邀国家级专家、主任医师、医学博士、博士生导师、'
                '吉林大学二院心血管病中心主任刘斌教授进行健康指导。刘教授用通俗易懂的语言，丰富的医学经验，'
                '结合大量病例，从心血管疾病的产生、危害、介入治疗、如何预防等几个方面进行了阐述，深受民警欢迎。'
                '培训中，大家认真听讲，精彩之处，或认真记录，或用手机将课件拍照留存。最后，讲座在全体民警热烈的掌声中结束'
                '。本次讲座进一步增强了局机关民警的健康意识，提高了民警对心血管疾病预防保健的知识，大家纷纷表示，受益匪浅，'
                '在今后的工作、生活中，能养成科学、健康的工作、生活习惯，以良好的精神面貌、健康的体魄投入到监狱事业中。'),
          ),
          Text('        活动时间: 2019.07.15 ',style: TextStyle(fontSize: 16),),
          Text('        活动地点: 心理服务分中心',style: TextStyle(fontSize: 16),),
          Text('        报名人数: 140人   先到先得',style: TextStyle(fontSize: 16),),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(Icons.people),
              Text("1人已报名    ")
            ],
          )
        ],
      ),
    );
}

}