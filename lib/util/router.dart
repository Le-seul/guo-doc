import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_first/pages/consultation/consulation_detail_page.dart';
import 'package:flutter_first/pages/consultation/psychological_service_center.dart';
import 'package:flutter_first/pages/container_page.dart';
import 'package:flutter_first/pages/home/home_widgets/EatingPage.dart';
import 'package:flutter_first/pages/home/home_widgets/ImagesPage.dart';
import 'package:flutter_first/pages/home/home_widgets/PsychologicalConcultPage.dart';
import 'package:flutter_first/pages/home/home_widgets/PsychologicalTestPage.dart';
import 'package:flutter_first/pages/login_page.dart';
import 'package:flutter_first/pages/service/servicenext/HealthyconsultationPage.dart';
import 'package:flutter_first/pages/service/servicenext/activity1.dart';
import 'package:flutter_first/pages/service/servicenext/activity2.dart';
import 'package:flutter_first/util/web_view_page.dart';

class Router {
  static const loginPage = 'app://LoginPage';
  static const containerPage = 'app://ContainerPage';
  static const psychologicalServiceCenterPage = 'app://PsychologicalServiceCenterPage';
  static const consulationDetailPage = 'app://ConsulationDetailPage';
  static const imagesPage = 'app://ImagesPage';
  static const psychologicalConcult = 'app://PsychologicalConcult';
  static const eating = 'app://eating';
  static const healthyconsultation = 'app://Healthyconsultation';
  static const psychologicalTest = 'app://PsychologicalTest';
  static const serviceActivity1 = 'app://ServiceActivity1';
  static const serviceActivity2 = 'app://ServiceActivity2';



  Widget _getPage(String url, dynamic params) {
    if (url.startsWith('https://') || url.startsWith('http://')) {
      return WebViewPage(url, params: params);
    } else {
      switch (url) {
        case loginPage:
          return LoginPage();
        case containerPage:
          return ContainerPage();
        case psychologicalServiceCenterPage:
          return PsychologicalServiceCenterPage();
        case consulationDetailPage:
          return ConsulationDetailPage(healthAdv: params);
        case imagesPage:
          return ImagesPage(indext: params);
        case psychologicalConcult:
          return PsychologicalConcult();
        case eating:
          return Eating();
        case healthyconsultation:
          return Healthyconsultation();
        case psychologicalTest:
          return PsychologicalTest();
        case serviceActivity1:
          return ServiceActivity1();
        case serviceActivity2:
          return ServiceActivity2();
      }
    }
    return null;
  }

  Router.pushReplacementNamed(BuildContext context, String url){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
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
