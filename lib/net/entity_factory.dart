import 'package:flutter_first/bean/CoreadingCatelog.dart';
import 'package:flutter_first/bean/CoreadingDetail.dart';
import 'package:flutter_first/bean/banner.dart';
import 'package:flutter_first/bean/activity_detail_entity.dart';
import 'package:flutter_first/bean/music.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/bean/consultation_columns_entity.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';

import 'package:flutter_first/bean/coursedetail.dart';
import 'package:flutter_first/bean/psycourse.dart';
import 'package:flutter_first/bean/psycourse_detail.dart';
import 'package:flutter_first/bean/psycoursecatelog.dart';
import 'package:flutter_first/bean/psydailytest.dart';
import 'package:flutter_first/bean/psyteacherbest.dart';
import 'package:flutter_first/bean/psyteacherlist.dart';
import 'package:flutter_first/bean/service_activity_entity.dart';
import 'package:flutter_first/bean/service_center.dart';
import 'package:flutter_first/bean/service_center_model.dart';
import 'package:flutter_first/bean/coreading.dart';
import 'package:flutter_first/bean/user_entity.dart';
import 'package:flutter_first/common/common.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ConsulationColumns") {
      return ConsulationColumns.fromJson(json) as T;
    } else if (T.toString() == "ConsulationColumnsInfo") {
      return ConsulationColumnsInfo.fromJson(json) as T;
    } else if (T.toString() == "ServiceActivity") {
      return ServiceActivity.fromJson(json) as T;
    }else if (T.toString() == "BannerImage") {
      return BannerImage.fromJson(json) as T;
    } else if (T.toString() == "ActivityDetail") {
      return ActivityDetail.fromJson(json) as T;
    } else if (T.toString() == "SeviceLocation") {
      return SeviceLocation.fromJson(json) as T;
    }else if (T.toString() == "GetAllMusic") {
      return GetAllMusic.fromJson(json) as T;
    }else if (T.toString() == "MusicTag") {
      return MusicTag.fromJson(json) as T;
    } else if (T.toString() == "Music") {
      return Music.fromJson(json) as T;
    }else if (T.toString() == "Psycourse") {
      return Psycourse.fromJson(json) as T;
    } else if (T.toString() == "PsyCourseDetail") {
      return PsyCourseDetail.fromJson(json) as T;
    } else if (T.toString() == "Psycoursecatelog") {
      return Psycoursecatelog.fromJson(json) as T;
    }else if (T.toString() == "CoReading") {
      return CoReading.fromJson(json) as T;
    }else if (T.toString() == "CoreadingCatelog") {
      return CoreadingCatelog.fromJson(json) as T;
    }else if (T.toString() == "CoreadingDetail") {
      return CoreadingDetail.fromJson(json) as T;
    }else if (T.toString() == "PsyDailyTest") {
      return PsyDailyTest.fromJson(json) as T;
    }else if (T.toString() == "Token") {
      return Token.fromJson(json) as T;
    }else if (T.toString() == "User") {
      return User.fromJson(json) as T;
    }else if (T.toString() == "PsyServiceCenter") {
      return PsyServiceCenter.fromJson(json) as T;
    }else if (T.toString() == "PsyServiceCenterByType") {
      return PsyServiceCenter.fromJson(json) as T;
    }else if (T.toString() == "PsyTeacherList") {
      return PsyTeacherList.fromJson(json) as T;
    }else if (T.toString() == "PsyTeacherBest") {
      return PsyTeacherBest.fromJson(json) as T;
    }else {
      return null;
    }
  }
}