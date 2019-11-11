class Api {
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

  //轮播图
  static const String BANNER = "/api/homePage.do?getBanner";

  //课程接口
  static const String PSYCOURSE = "/api/psyCourse.do?getPsyCourse";

  //获取心理课程接口
  static const String GETALLCOUTSE = "/api/psyCourse.do?getAllCourse";

  //心理课程详情1
  static const String COURSEDETAIL1 = "/api/psyCourse.do?getCouserDetail&id=1";

  //心理课程详情2
  static const String COURSEDETAIL2 = "/api/psyCourse.do?getCouserDetail&id=2";

  //心理课程目录1
  static const String PSYCOURSECATELOG = "/api/psyCourse.do?getPsyCourseCatalog&courseId=1";

  //心理共读
  static const String CoReading = "/api/psyCoreading.do?getPsyCoReading";
  //心理共读类别

  static const String CoReadingKind = "/api/psyCoreading.do?getPsyCoReadingByCategoryId";

  //简单共读目录
  static const String CoReadingCatalog = "/api/psyCoreading.do?getPsyCoReadingCatalog&courseId=1";

  //用户身份验证
  static const String USERAUTHCHECK = "/api/login.do?userAuthCheck";

  //获取验证码
  static const String SENDVCODE = "/api/login.do?sendVerificationCode";

  //验证验证码
  static const String CHECKVCODE = "/api/login.do?checkVerificationCode";

  //上传极光RegistrationID
  static const String UPDATEREGISTRATIONID = "/api/push.do?saveOrUpdateRegistrationID";

  //春雨医生创建订单
  static const String CREATEORDER = "/api/chunyuTuwen.do?createOrder";

  //获取最后一次交互的内容
  static const String GETLASTINTERACTIONCONTENT = "/api/chunyuTuwen.do?getLastInteractionContent";

  //用户提问
  static const String USERASK = "/api/chunyuTuwen.do?ask";

  //获取医生信息
  static const String GETDOCTERINFO = "/api/chunyuTuwen.do?getDoctorInfo";

  //获取正在进行中的图文订单的数量
  static const String ORDERCOUNT = "/api/chunyuTuwen.do?countOrderInProgress";

  //上传音频
  static const String UPLOADAUDIO = "/api/attachment.do?uploadAudio";

  //上传图片
  static const String UPLOADIMAGE = "/api/image.do?uploadImage";

  //获取所有订单
  static const String GETALLORDER = "/api/chunyuFastphone.do?getHistoryOrder";

  //创建快捷电话订单接口
  static const String CREATEFASTPHONEORDER = "/api/chunyuFastphone.do?createFastphoneOrder";

  //获取春雨医生开通快捷电话的科室信息
  static const String GETFASTPHONEINFO = "/api/chunyuFastphone.do?getClinicInfo";

  //评价图文订单
  static const String POSTACCESSINFO = "/api/chunyuTuwen.do?assessOrder";

  //获取订单的所有内容
  static const String GETALLCONTENT = "/api/chunyuTuwen.do?getAllContent";

  //获取进行中的订单
  static const String GETORDERINPROGRESS = "/api/chunyuTuwen.do?getOrderInProgress";

  //获取快捷电话医生总结内容
  static const String GETFASTPHONEREPLYCONTENT = "/api/chunyuFastphone.do?getFastphoneReplyContent";
  //教官列表
  static const String PsyTeacherList = "/api/psyTeacher.do?getPsyTeacherList";
  //教官列表最美教官
  static const String PsyTeacherBest = "/api/psyTeacher.do?getPsyTeacherBest&teacherId=1";
  //每日一测全部
  static const String PsyDailyTest = "/api/psyDailyTest.do?getPsyDailyTest";
  //每日一测已测
  static const String PsyDailyTested = "/api/psyDailyTest.do?getPsyDailyTestRecord";
  //心理课程详情1
  static const String PsyCourseDetail = "/api/psyCourse.do?getCouserDetail&id=1";
  //服务中心列表
  static const String GETPSYSERVICECENTERLIST = "/api/psyServiceCenter.do?getPsyServiceCenterList";
  //服务中心详情
  static const String GETPSYSERVICECENTERDETAIL = "/api/psyServiceCenter.do?getPsyServiceCenterDetail";
  //按地区查找
  static const String GETPSYSERVICECENTERBYLOCATION = "/api/psyServiceCenter.do?getPsyServiceCenterByLocation";

  //获取课程详情
  static const String GETCOURSTEDETAIL = "/api/psyCourse.do?getCourseDetail";



}