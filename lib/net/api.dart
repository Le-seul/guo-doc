class Api{
  //资讯顶部栏目
  static const String GETAllCOlUMN = "/api/information.do?getAllColumn";
  //获取栏目内容
  static const String GETAllCOlUMNINFO = "/api/information.do?getColumnInfo";
  //获取活动列表
  static const String GETACTIVITIES = "/api/activity.do?getAllActivity";
  //获取活动详情
  static const String GETACTIVITIEDETAIL = "/api/activity.do?getActivity";

  //获取服务中心列表
  static const String GETSERVICECENTERLIST = "/api/psyConsult.do?getServiceCenterList";
  //创建心理咨询订单
  static const String GREATEORDER = "/api/psyConsult.do?createOrder";
  //获取所有歌单
  static const String GETAllMUSICLIST = "/api/music.do?getAllMusicList";
  //获取所有Tag
  static const String GETMUSICTAG = "/api/music.do?getAllTag";
  //获取某个歌单的所有音乐
  static const String GETMUSICLIST = "/api/music.do?getSongOfMusicList";
  //获取包含某个Tag的所有歌单
  static const String GETMUSICLISTBYTAG = "/api/music.do?getMusicListByTag";
  //获取歌曲详情
  static const String GETMUSICDETAIL = "/api/music.do?getSongDetail";
  //轮播图
  static const String BANNER = "/api/homepage.do?getBanner";
  //课程接口
  static const String PSYCOURSE = "/api/psycourse.do?getPsyCourse";
  //心理课程详情1
  static const String COURSEDETAIL1 = "/api/psycourse.do?getCouserDetail&id=1";
  //心理课程详情2
  static const String COURSEDETAIL2 = "/api/psycourse.do?getCouserDetail&id=2";
  //心理课程目录1
  static const String PSYCOURSECATELOG = "/api/psycourse.do?getPsyCourseCatalog&courseId=1";
  //简单共读
  static const String Togetheread = "/api/psycoreading.do?getPsyCoReading";
  //简单共读目录
  static const String CoReadingCatalog = "/api/psycoreading.do?getPsyCoReadingCatalog&courseId=1";
  //每日一测
  static const String PsyDailyTest = "/api/psydailytest.do?getPsyDailyTest";

}