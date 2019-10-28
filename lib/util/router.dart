import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_first/music/page_playing.dart';
import 'package:flutter_first/pages/consultation/clinic_information_page.dart';
import 'package:flutter_first/pages/consultation/consultation_child_page.dart';
import 'package:flutter_first/pages/consultation/consultation_detail_page.dart';
import 'package:flutter_first/pages/consultation/instructor_demeanor_detail_page.dart';
import 'package:flutter_first/pages/consultation/instructor_demeanor_page.dart';
import 'package:flutter_first/pages/consultation/psyCenter/center_detail_page.dart';
import 'package:flutter_first/pages/consultation/psyCenter/psychological_service_center.dart';
import 'package:flutter_first/pages/consultation/topic_page.dart';
import 'package:flutter_first/pages/container_page.dart';
import 'package:flutter_first/pages/exit_login_page.dart';
import 'package:flutter_first/pages/home/doctor/doctor_chunyu_home_page.dart';
import 'package:flutter_first/pages/home/doctor/doctor_page.dart';
import 'package:flutter_first/pages/home/doctor/evaluation_page.dart';
import 'package:flutter_first/pages/home/doctor/graphic_consuitation.dart';
import 'package:flutter_first/pages/home/doctor/history_record.dart';
import 'package:flutter_first/pages/home/doctor/search_hospital.dart';
import 'package:flutter_first/pages/home/doctor/search_hospital_detail.dart';
import 'package:flutter_first/pages/home/doctor/talk_page.dart';
import 'package:flutter_first/pages/home/doctor/telephone_consultation.dart';
import 'package:flutter_first/pages/home/home_widgets/eating_page.dart';
import 'package:flutter_first/pages/home/home_widgets/images_page.dart';
import 'package:flutter_first/pages/home/home_widgets/pstConsult_page.dart';
import 'package:flutter_first/pages/home/home_widgets/psyTest_page.dart';
import 'package:flutter_first/pages/home/home_widgets/coreading/coreading_course_page.dart';
import 'package:flutter_first/pages/home/home_widgets/coreading/coreading_page.dart';
import 'package:flutter_first/pages/home/home_widgets/course/catalog_detail_page.dart';
import 'package:flutter_first/pages/home/home_widgets/course/course_catalog_page.dart';
import 'package:flutter_first/pages/home/home_widgets/course/course_page.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/Forth.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/Second.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/Third.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/everydaytestpage.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/first.dart';
import 'package:flutter_first/pages/home/home_widgets/myself_page.dart';
import 'package:flutter_first/pages/home/home_widgets/relatives_page.dart';
import 'package:flutter_first/pages/home/home_widgets/music_list_page.dart';
import 'package:flutter_first/pages/home/home_widgets/music_page.dart';
import 'package:flutter_first/pages/home/home_widgets/music_sort_page.dart';
import 'package:flutter_first/pages/login_page.dart';
import 'package:flutter_first/pages/mine/Report/bodyreport.dart';
import 'package:flutter_first/pages/mine/Report/reportlist.dart';
import 'package:flutter_first/pages/mine/sport/step_ranking_page.dart';
import 'package:flutter_first/pages/selfhelp/daily_recording/diet_records_page.dart';
import 'package:flutter_first/pages/selfhelp/daily_recording/movement_clock_page.dart';
import 'package:flutter_first/pages/selfhelp/daily_recording/sleep_records_page.dart';
import 'package:flutter_first/pages/service/servicenext/consultation_detail.dart';
import 'package:flutter_first/pages/service/servicenext/healthyconsultation_page.dart';
import 'package:flutter_first/pages/service/servicenext/initiateconsultation_page.dart';
import 'package:flutter_first/pages/service/servicenext/activity.dart';
import 'package:flutter_first/pages/service/servicenext/activity2.dart';
import 'package:flutter_first/pages/service/servicenext/relatives_information_page.dart';
import 'package:flutter_first/pages/sms_login_page.dart';
import 'package:flutter_first/util/web_view_page.dart';

class Router {
  static const loginPage = 'app://LoginPage';
  static const containerPage = 'app://ContainerPage';
  static const smsLogin = 'app://SMSLogin';
  static const psychologicalServiceCenterPage = 'app://PsychologicalServiceCenterPage';
  static const consulationDetailPage = 'app://ConsulationDetailPage';
  static const imagesPage = 'app://ImagesPage';
  static const psychologicalConcult = 'app://PsychologicalConcult';
  static const eating = 'app://eating';
  static const healthyconsultation = 'app://Healthyconsultation';
  static const psychologicalTest = 'app://PsychologicalTest';
  static const serviceActivity = 'app://ServiceActivity';
  static const serviceActivityPage = 'app://ServiceActivityPagey';
  static const serviceActivity2 = 'app://ServiceActivity2';
  static const dietrecordsPage = 'app://DietrecordsPage';
  static const sleepRecordsPage = 'app://SleepRecordsPage';
  static const movementClockPage = 'app://MovementClockPage';
  static const topicPage = 'app://TopicPage';
  static const curriculum = 'app://Curriculum';
  static const initiateConsultationPage = 'app://InitiateConsultationPage';
  static const relativesInformationPage = 'app://RelativesInformationPage';
  static const psychologicalDetailPage = 'app://PsychologicalDetailPage';
  static const musicPage = 'app://MusicPage';
  static const musicSortPage = 'app://MusicSortPage';
  static const musicListPage = 'app://MusicListPage';
  static const playingPage = 'app://PlayingPage';
  static const curriculumcatalog1 = 'app://CurriculumCatalog1';
  static const curriculumcatalog2 = 'app://CurriculumCatalog2';
  static const test0 = 'app://test0';
  static const test1 = 'app://test1';
  static const test2 = 'app://test2';
  static const test3 = 'app://test3';
  static const simplereading = 'app://SimpleReading';
  static const togethereading = 'app://Togethereading';
  static const everydaytest = 'app://Everydaytest';
  static const myself = 'app://Myself';
  static const relatives = 'app://Relatives';
  static const reporylist = 'app://reporylist';
  static const bodyreport = 'app://bodyreport';
  static const exitLoginPage = 'app://ExitLoginPage';
  static const catalogdetail = 'app://catalogdetail';
  static const talk = 'app://Talk';
  static const telConsultation = 'app://TelConsultation';
  static const graphicConsultation = 'app://CaphicConsultation';
  static const doctorChunyuHomePage = 'app://DoctorChunyuHomePage';
  static const searchHospital = 'app://SearchHospital';
  static const searchHospitalDetail = 'app://SearchHospitalDetail';
  static const historyRecord = 'app://HistoryRecord';
  static const doctorPage = 'app://DoctorPage';
  static const step_ranking = 'app://step_ranking';
  static const center_detail = 'app://center_detail';
  static const instructor_demeanorPage = 'app://instructor_demeanorPage';
  static const instructor_demeanor_detailPage = 'app://instructor_demeanor_detailPage';
  static const clinic_informationPage = 'app://clinic_informationPage';
  static const evaluationPage = 'app://EvaluationPage';


  Widget _getPage(String url, dynamic params) {
    if (url.startsWith('https://') || url.startsWith('http://')) {
      return WebViewPage(url, params: params);
    } else {
      switch (url) {
        case topicPage:
          return TopicPage();
        case reporylist:
          return ReportList();
        case bodyreport:
          return BodyReport();
        case everydaytest:
          return EverydayTest();
        case togethereading:
          return SimpleCoreading();
        case simplereading:
          return SimpleReading();//简单共读
        case loginPage:
          return LoginPage();
        case smsLogin:
          return SMSLogin(user: params,);
        case containerPage:
          return ContainerPage();
        case psychologicalServiceCenterPage:
          return PsychologicalServiceCenterPage();
        case consulationDetailPage:
          return ConsultationDetailPage(consulationColumnsInfo: params,);
        case imagesPage:
          return ImagesPage(indext: params);
        case psychologicalConcult:
          return PsychologicalConcult();
        case eating:
          return Eating();
        case myself:
          return Myself();
        case relatives:
          return Relatives();
        case catalogdetail:
          return CatalogDetail(Detail: params,);
        case test0:
          return Test0();
        case test1:
          return Test1();
        case test2:
          return Test2();
        case test3:
          return Test3();
        case curriculumcatalog1:
          return CurriculumCatalog1();
        case healthyconsultation:
          return Healthyconsultation();
        case psychologicalTest:
          return PsychologicalTest();
        case serviceActivityPage:
          return ServiceActivityPage(offstage: params['offstage'],activityId: params['activityId']);
        case serviceActivity2:
          return ServiceActivity2();
        case dietrecordsPage:
          return DietRecordsPage();
        case sleepRecordsPage:
          return SleepRecordsPage();
        case movementClockPage:
          return MovementClockPage();
        case curriculum:
          return Curriculum();
        case initiateConsultationPage:
          return InitiateConsultationPage('FAMI',name: params['name'],gender: params['gender'],birthday: params['birthday'],relation: params['relation'],);
        case relativesInformationPage:
          return RelativesInformationPage();
        case psychologicalDetailPage:
          return PsychologicalDetailPage();
        case musicPage:
          return MusicPage(num: params['num'],tagId: params['tagId']);
        case musicSortPage:
          return MusicSortPage();
        case musicListPage:
          return MusicListPage(allMusicList: params,);
        case playingPage:
          return PlayingPage(music: params,);
        case exitLoginPage:
          return ExitLoginPage();
        case talk:
          return TalkPage(orderId: params,);
        case telConsultation:
          return TelConsultation();
        case graphicConsultation:
          return GraphicConsultation();
        case doctorChunyuHomePage:
          return DoctorChunyuHomePage();
        case searchHospital:
          return SearchHospital();
        case searchHospitalDetail:
          return SearchHospitalDetail();
        case historyRecord:
          return HistoryRecord();
        case doctorPage:
          return DoctorPage();
        case center_detail:
          return PsyCenterDetail();
        case step_ranking:
          return StepRanking();
        case instructor_demeanorPage:
          return instructor_demeanor();
        case instructor_demeanor_detailPage:
          return instructor_demeanor_detail();
        case clinic_informationPage:
          return Clinic_information();
        case evaluationPage:
          return EvaluationPage(orderId: params);
      }
    }
    return null;
  }

  Router.pushReplacementNamed(BuildContext context, String url, dynamic params){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }


  Router.pushNoParams(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    }));
  }

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }
}
