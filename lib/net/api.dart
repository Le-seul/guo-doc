class Api{
  //资讯顶部栏目
  static const String GETAllCOlUMN = "/api/information.do?getAllColumn";
  //获取栏目内容
  static const String GETAllCOlUMNINFO = "/api/information.do?getColumnInfo";
  //获取活动列表
  static const String GETACTIVITIES = "/api/activity.do?getAllActivity";
  //获取活动详情
  static const String GETACTIVITIEDETAIL = "/api/activity.do?getActivity";
  //课程接口
  static const String PSYCOURSE = "/api/psycourse.do?getPsyCourse";
  //获取服务中心列表getServiceCenterList
  static const String GETSERVICECENTERLIST = "/api/psyConsult.do?getServiceCenterList";
  //创建心理咨询订单
  static const String GREATEORDER = "/api/psyConsult.do?createOrder";
}