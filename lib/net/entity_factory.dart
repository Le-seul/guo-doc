import 'package:flutter_first/bean/activity_detail_entity.dart';
import 'package:flutter_first/bean/music_entity.dart';
import 'package:flutter_first/bean/consultation_columns_entity.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/bean/music_model.dart';
import 'package:flutter_first/bean/psycourse.dart';
import 'package:flutter_first/bean/service_activity_entity.dart';
import 'package:flutter_first/bean/service_center_model.dart';


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
    } else if (T.toString() == "Psycourse") {
      return Psycourse.fromJson(json) as T;
    } else if (T.toString() == "ActivityDetail") {
      return ActivityDetail.fromJson(json) as T;
    } else if (T.toString() == "SeviceLocation") {
      return SeviceLocation.fromJson(json) as T;
    }else if (T.toString() == "GetAllMusic") {
      return GetAllMusic.fromJson(json) as T;
    }else if (T.toString() == "MusicTag") {
      return MusicTag.fromJson(json) as T;
    } else if (T.toString() == "MusicList") {
      return MusicList.fromJson(json) as T;
    }else if (T.toString() == "Music") {
      return Music.fromJson(json) as T;
    }else {
      return null;
    }
  }
}