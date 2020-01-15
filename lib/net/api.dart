class Api {

  //搜索
  static const String SEARCH = "/api/search.do?search";

  //获取首页公告
  static const String GETANNOUNCEMENT = "/api/homePage.do?getAnnouncement";

  //资讯顶部栏目
  static const String GETAllCOlUMN = "/api/information.do?getAllColumn";

  //获取栏目内容
  static const String GETAllCOlUMNINFO = "/api/information.do?getColumnInfo";

  //获取第一个栏目的内容
  static const String GETDEFAUTLTCOLUMNINFO = "/api/information.do?getDefaultColumnInfo";

  //获取文章详情
  static const String GETARTICLECONTENT = "/api/article.do?getArticleContent";

  //获取专题包含的文章
  static const String GETARTICLETOPIC = "/api/topic.do?getArticleOfTopic";

  //查询点赞状态
  static const String GRTLIKESTATUS = "/api/article.do?getSocialActionStatus";

  //获取活动列表
  static const String GETACTIVITIES = "/api/activity.do?getAllActivity";

  //获取活动详情
  static const String GETACTIVITIEDETAIL = "/api/activity.do?getActivityInfo";

  //获取地区列表
  static const String GETREGIONLIST = "/api/activity.do?getRegionList";

  //根据地区获取活动
  static const String GETBYREGION = "/api/activity.do?getActivityByRegion";

  //活动报名
  static const String SIGNUPACTIVITY = "/api/activity.do?signUp";

  //获取还未开始的活动列表
  static const String GRTACTIVITYNOTSTART = "/api/activity.do?getActivityNotStart";

  //获取进行中的活动列表
  static const String GETACTIVITYINPROGRESS = "/api/activity.do?getActivityInProgress";

  //获取已结束的活动列表
  static const String GETACTIVITYFINISHED = "/api/activity.do?getActivityFinished";

  //获取服务中心列表
  static const String GETSERVICECENTERLIST = "/api/psyConsult.do?getServiceCenterList";

  //创建心理咨询订单
  static const String GREATEORDER = "/api/psyConsult.do?createOrder";

  //获取所有歌单
  static const String GETAllMUSICLIST = "/api/music.do?getAllMusicList";

  //获取所有Tag
  static const String GETMUSICTAG = "/api/music.do?getAllTag";

  //记录播放数量
  static const String ADDPLAYCOUNT = "/api/music.do?addPlayCount";

  //获取某个歌单的所有音乐
  static const String GETMUSICLIST = "/api/music.do?getSongOfMusicList";

  //获取包含某个Tag的所有歌单
  static const String GETMUSICLISTBYTAG = "/api/music.do?getMusicListByTag";

  //获取歌曲详情
  static const String GETSONGDETAIL = "/api/music.do?getSongDetail";

  //轮播图
  static const String BANNER = "/api/homePage.do?getBanner";

  //课程接口
  static const String PSYCOURSE = "/api/psyCourse.do?getPsyCourse";

  //获取心理课程接口
  static const String GETALLCOUTSE = "/api/psyCourse.do?getAllCourse";

  //获取即将发布的课程
  static const String GETUPCOMINGCOURSE = "/api/psyCourse.do?getUpcomingCourse";

  //获取心理课程获取TAG列表
  static const String GETTAGLIST = "/api/psyCourse.do?getAllCategory";

  //根据tag获取课程列表
  static const String GETBYTAGNAME = "/api/psyCourse.do?getByCategory";

  //心理课程详情1
  static const String COURSEDETAIL1 = "/api/psyCourse.do?getCouserDetail&id=1";

  //心理课程详情2
  static const String COURSEDETAIL2 = "/api/psyCourse.do?getCouserDetail&id=2";

  //心理课程目录1
  static const String PSYCOURSECATELOG = "/api/psyCourse.do?getPsyCourseCatalog&courseId=1";

  //心理共读
  static const String CoReading = "/api/psyCoreading.do?getPsyCoReading";

  //心理共读TAG
  static const String CoReadingTag = "/api/psyCoreading.do?getTagList";

  //心理共读类别
  static const String CoReadingKind = "/api/psyCoreading.do?getPsyCoReadingByCategoryId";

  //心理共读点赞

  static const String CoReadingLike = "/api/psyCoreading.do?getPsyCoReadingDetail";

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
  static const String CREATEORDER = "/api/chunyu.do?createTuwenOrder";

  //获取最后一次交互的内容
  static const String GETLASTINTERACTIONCONTENT = "/api/chunyuTuwen.do?getLastInteractionContent";

  //用户提问
  static const String USERASK = "/api/chunyu.do?tuwenAsk";

  //获取医生信息
  static const String GETDOCTERINFO = "/api/chunyu.do?getDoctorInfo";

  //获取正在进行中的图文订单的数量
  static const String ORDERCOUNT = "/api/chunyu.do?countTuwenOrderInprogress";

  //上传音频
  static const String UPLOADAUDIO = "/api/attachment.do?uploadAudio";

  //上传图片
  static const String UPLOADIMAGE = "/api/image.do?uploadImage";

  //获取历史订单
  static const String GETALLORDER = "/api/chunyu.do?getHistoryOrder";

  //创建快捷电话订单接口
  static const String CREATEFASTPHONEORDER = "/api/chunyu.do?createFastphoneOrder";

  //获取春雨医生开通快捷电话的科室信息
  static const String GETFASTPHONEINFO = "/api/chunyu.do?getClinicInfo";

  //评价图文订单
  static const String POSTACCESSINFO = "/api/chunyu.do?assessTuwenOrder";

  //获取订单的所有内容
  static const String GETALLCONTENT = "/api/chunyu.do?getAllContent";

  //获取进行中的订单
  static const String GETORDERINPROGRESS = "/api/chunyu.do?getOrderInProgress";

  //获取快捷电话医生总结内容
  static const String GETFASTPHONEREPLYCONTENT = "/api/chunyuFastphone.do?getFastphoneReplyContent";

  //教官列表
  static const String PsyTeacherList = "/api/psyTeacher.do?getPsyTeacherList";

  //本单位教官
  static const String PsyTeacherLocal = "/api/psyTeacher.do?getPsyTeacherByOrgId";

  //教官列表最美教官
  static const String PsyTeacherBest = "/api/psyTeacher.do?getPsyTeacherBest";

  //教官点赞
  static const String PsyTeacherLike = "/api/psyTeacher.do?getPsyTeacherLike";

  //每日一测TAG
  static const String PsyDailyTAG = "/api/psyDailyTest.do?getTagList";

  //每日一测
  static const String PsyDailyTest = "/api/psyDailyTest.do?getPsyDailyTestByTag";

  //每日一测已测
  static const String PsyDailyTested = "/api/psyDailyTest.do?getPsyDailyTestRecord";

  //每日一测阅读人数
  static const String PsyDailyTestedLike = "/api/psyDailyTest.do?getPsyDailyTestDetail";

  //心理课程详情1
  static const String PsyCourseDetail = "/api/psyCourse.do?getCouserDetail&id=1";

  //服务中心列表
  static const String GETPSYSERVICECENTERLIST = "/api/psyServiceCenter.do?getPsyServiceCenterList";

  //服务中心直属单位
  static const String GETPSYSERVICECENTERUNIT = "/api/psyServiceCenter.do?getPsyServiceCenterByCatalog";

  //获取地区列表
  static const String GETREGIONLIST2 = "/api/psyServiceCenter.do?getRegionList";

  //服务中心详情
  static const String GETPSYSERVICECENTERDETAIL = "/api/psyServiceCenter.do?getPsyServiceCenterDetail";

  //按地区查找
  static const String GETPSYSERVICECENTERBYLOCATION = "/api/psyServiceCenter.do?getPsyServiceCenterByLocation";

  //按地区查找
  static const String GETPSYSERVICECENTERBYCATALOG = "/api/psyServiceCenter.do?getPsyServiceCenterByCatalog";

  //获取课程详情
  static const String GETCOURSTEDETAIL = "/api/psyCourse.do?getCourseDetail";

  //获取一个课程内的章节进度
  static const String GETCOURSERECORD = "/api/psyCourse.do?getStudyRecord";

  //获取书签
  static const String GETBOOKMARK = "/api/psyCourse.do?getBookMark";

  //上传课程书签
  static const String SAVEBOOKMARK = "/api/psyCourse.do?saveBookMark";

  //记录课程进度
  static const String SAVESTUDYRECORDER = "/api/psyCourse.do?saveStudyRecord";

  //用户阅读行为记录
  static const String USEREADINGLOG = "/api/article.do?userReadingLog";

  //体检报告列表
  static const String GETYEARLIST = "/api/exam.do?getYearList";

  //保存用户意见
  static const String SAVESUGGESTION = "/api/suggestion.do?saveSuggestion";

  //门诊信息
  static const String CLINICINFO = "/api/clinicInfo.do?getClinicInfo";


  //记录或更新步数
  static const String UPDATESTEPTCOUNT = "/api/step.do?saveOrUpdateStepCount";

  //获取用户步数排名
  static const String GRTSTEPRANKING = "/api/step.do?getStepRanking";

  //获取步数排名列表
  static const String GETRANKINGLIST = "/api/step.do?getRankingList";

  //用户信息
  static const String USERINFOR = "/api/auUser.do?getAuUser";

  //收藏
  static const String COLLECTION = "/api/article.do?getAction&action=SC";
}
