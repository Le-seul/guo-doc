import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_first/music/page_playing.dart';
import 'package:flutter_first/pages/consultation/consultation_child_page.dart';
import 'package:flutter_first/pages/consultation/consultation_detail_page.dart';
import 'package:flutter_first/pages/consultation/psychological_service_center.dart';
import 'package:flutter_first/pages/consultation/topic_page.dart';
import 'package:flutter_first/pages/container_page.dart';
import 'package:flutter_first/pages/exit_login_page.dart';
import 'package:flutter_first/pages/home/home_widgets/EatingPage.dart';
import 'package:flutter_first/pages/home/home_widgets/ImagesPage.dart';
import 'package:flutter_first/pages/home/home_widgets/PsychologicalConcultPage.dart';
import 'package:flutter_first/pages/home/home_widgets/PsychologicalTestPage.dart';
import 'package:flutter_first/pages/home/home_widgets/CoreadingCoursePage.dart';
import 'package:flutter_first/pages/home/home_widgets/SimpleCoreading.dart';
import 'package:flutter_first/pages/home/home_widgets/curriculumCatalogPage1.dart';
import 'package:flutter_first/pages/home/home_widgets/curriculumCatalogPage2.dart';
import 'package:flutter_first/pages/home/home_widgets/curriculumpage.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/Forth.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/Second.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/Third.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytest/first.dart';
import 'package:flutter_first/pages/home/home_widgets/everydaytestpage.dart';
import 'package:flutter_first/pages/home/home_widgets/myselfpage.dart';
import 'package:flutter_first/pages/home/home_widgets/relativespage.dart';
import 'package:flutter_first/pages/home/home_widgets/music_list_page.dart';
import 'package:flutter_first/pages/home/home_widgets/music_page.dart';
import 'package:flutter_first/pages/home/home_widgets/music_sort_page.dart';
import 'package:flutter_first/pages/login_page.dart';
import 'package:flutter_first/pages/mine/Report/bodyreport.dart';
import 'package:flutter_first/pages/mine/Report/reportlist.dart';
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
        case test0:
          return Test0();
        case test1:
          return Test1();
        case test2:
          return Test2();
        case test3:
          return Test3();
        case curriculum:
          return Curriculum();
        case curriculumcatalog1:
          return CurriculumCatalog1();
        case curriculumcatalog2:
          return CurriculumCatalog2();
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
          return MusicListPage(musicListId: params,);
        case playingPage:
          return PlayingPage(songId: params,);
        case exitLoginPage:
          return ExitLoginPage();
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
