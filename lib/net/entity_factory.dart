import 'package:flutter_first/bean/consultation_columns_entity.dart';
import 'package:flutter_first/bean/consultation_columnsinfo_entity.dart';
import 'package:flutter_first/bean/consultattion_detail_entity.dart';


class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ConsulationColumns") {
      return ConsulationColumns.fromJson(json) as T;
    } else if (T.toString() == "ConsulationColumnsInfo") {
      return ConsulationColumnsInfo.fromJson(json) as T;
    } else if (T.toString() == "ConsulationDetail") {
      return ConsulationDetail.fromJson(json) as T;
    } else {
      return null;
    }
  }
}