import 'package:flutter_first/bean/CoreadingCatelog.dart';
import 'package:flutter_first/bean/CoreadingDetail.dart';
import 'package:flutter_first/bean/HealthYear.dart';
import 'package:flutter_first/bean/article_detail.dart';
import 'package:flutter_first/bean/article_likestatus.dart';
import 'package:flutter_first/bean/audioUrl.dart';
import 'package:flutter_first/bean/banner.dart';
import 'package:flutter_first/bean/activity_detail_entity.dart';
import 'package:flutter_first/bean/centerdetail_page.dart';
import 'package:flutter_first/bean/chapter_record.dart';
import 'package:flutter_first/bean/clinic_info.dart';
import 'package:flutter_first/bean/course.dart';
import 'package:flutter_first/bean/course_bookmark.dart';
import 'package:flutter_first/bean/course_detail.dart';
import 'package:flutter_first/bean/doctorInfo.dart';
import 'package:flutter_first/bean/fastphone_info.dart';
import 'package:flutter_first/bean/history_order_entity.dart';
import 'package:flutter_first/bean/imageUrl.dart';
import 'package:flutter_first/bean/message.dart';
import 'package:flutter_first/bean/music.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/bean/consultation_columns_entity.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';

import 'package:flutter_first/bean/coursedetail.dart';
import 'package:flutter_first/bean/order_count.dart';
import 'package:flutter_first/bean/progress_order_entity.dart';
import 'package:flutter_first/bean/psycourse.dart';
import 'package:flutter_first/bean/psycourse_detail.dart';
import 'package:flutter_first/bean/psycoursecatelog.dart';
import 'package:flutter_first/bean/psydailytest.dart';
import 'package:flutter_first/bean/psyteacher.dart';
import 'package:flutter_first/bean/psyteacher_like.dart';

import 'package:flutter_first/bean/psyteacherlist.dart';
import 'package:flutter_first/bean/region.dart';
import 'package:flutter_first/bean/service_activity_entity.dart';
import 'package:flutter_first/bean/service_center.dart';
import 'package:flutter_first/bean/service_center2_bean.dart';
import 'package:flutter_first/bean/service_center_bean.dart';
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
    } else if (T.toString() == "BannerImage") {
      return BannerImage.fromJson(json) as T;
    } else if (T.toString() == "Psycourse") {
      return Psycourse.fromJson(json) as T;
    } else if (T.toString() == "ActivityDetail") {
      return ActivityDetail.fromJson(json) as T;
    } else if (T.toString() == "SeviceLocation") {
      return SeviceLocation.fromJson(json) as T;
    } else if (T.toString() == "GetAllMusic") {
      return GetAllMusic.fromJson(json) as T;
    } else if (T.toString() == "MusicTag") {
      return MusicTag.fromJson(json) as T;
    } else if (T.toString() == "Music") {
      return Music.fromJson(json) as T;
    } else if (T.toString() == "Coursedetail") {
      return Coursedetail.fromJson(json) as T;
    } else if (T.toString() == "Psycoursecatelog") {
      return Psycoursecatelog.fromJson(json) as T;
    } else if (T.toString() == "CoReading") {
      return CoReading.fromJson(json) as T;
    } else if (T.toString() == "CoreadingCatelog") {
      return CoreadingCatelog.fromJson(json) as T;
    } else if (T.toString() == "CoreadingDetail") {
      return CoreadingDetail.fromJson(json) as T;
    } else if (T.toString() == "PsyDailyTest") {
      return PsyDailyTest.fromJson(json) as T;
    } else if (T.toString() == "Token") {
      return Token.fromJson(json) as T;
    } else if (T.toString() == "User") {
      return User.fromJson(json) as T;
    } else if (T.toString() == "Autogenerated") {
      return Autogenerated.fromJson(json) as T;
    } else if (T.toString() == "OrderId") {
      return OrderId.fromJson(json) as T;
    } else if (T.toString() == "DoctorInfo") {
      return DoctorInfo.fromJson(json) as T;
    } else if (T.toString() == "OrderCount") {
      return OrderCount.fromJson(json) as T;
    } else if (T.toString() == "ImageUrl") {
      return ImageUrl.fromJson(json) as T;
    } else if (T.toString() == "AudioUrl") {
      return AudioUrl.fromJson(json) as T;
    } else if (T.toString() == "ProgressOrder") {
      return ProgressOrder.fromJson(json) as T;
    } else if (T.toString() == "HistoryOrder") {
      return HistoryOrder.fromJson(json) as T;
    } else if (T.toString() == "FastphoneInfo") {
      return FastphoneInfo.fromJson(json) as T;
    } else if (T.toString() == "Message") {
      return Message.fromJson(json) as T;
    } else if (T.toString() == "PsyServiceCenter") {
      return PsyServiceCenter.fromJson(json) as T;
    } else if (T.toString() == "PsyTeacherList") {
      return PsyTeacherList.fromJson(json) as T;
    } else if (T.toString() == "PsyTeacher") {
      return PsyTeacher.fromJson(json) as T;
    } else if (T.toString() == "PsyTeacherLike") {
      return PsyTeacherLike.fromJson(json) as T;
    } else if (T.toString() == "ServCenter") {
      return ServCenter.fromJson(json) as T;
    } else if (T.toString() == "ServCenter2") {
      return ServCenter2.fromJson(json) as T;
    }else if (T.toString() == "CenterDetail") {
      return CenterDetail.fromJson(json) as T;
    } else if (T.toString() == "Course") {
      return Course.fromJson(json) as T;
    } else if (T.toString() == "CourseDetail") {
      return CourseDetail.fromJson(json) as T;
    } else if (T.toString() == "PsyCourseDetail") {
      return PsyCourseDetail.fromJson(json) as T;
    } else if (T.toString() == "ChapterRecord") {
      return ChapterRecord.fromJson(json) as T;
    } else if (T.toString() == "CourseBookmark") {
      return CourseBookmark.fromJson(json) as T;
    } else if (T.toString() == "HearthYear") {
      return HearthYear.fromJson(json) as T;
    } else if (T.toString() == "ArticleContent") {
      return ArticleContent.fromJson(json) as T;
    }else if (T.toString() == "LikeStatus") {
      return LikeStatus.fromJson(json) as T;
    }else if (T.toString() == "RegionList") {
      return RegionList.fromJson(json) as T;
    }else if (T.toString() == "Clinic") {
      return Clinic.fromJson(json) as T;
    }else {
      return null;
    }
  }
}
