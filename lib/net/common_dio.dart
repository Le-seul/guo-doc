import 'package:flutter_first/net/api.dart';
import 'package:flutter_first/net/dio_utils.dart';
import 'package:flutter_first/util/toast.dart';

class CommonRequest {
  static void UserReadingLog(String resourceId, String type, String action) {
    DioUtils.instance.requestNetwork<String>(Method.post, Api.USEREADINGLOG,
        queryParameters: {
          'resourceId': resourceId,
          'type': type,
          'action': action,
        }, onSuccess: (data) {
      if (action == 'DZ') {
        Toast.show('点赞成功！');
      } else if (action == 'QD') {
        Toast.show('取消点赞！');
      } else if (action == 'SC') {
        Toast.show('收藏成功！');
      } else if (action == 'QS') {
        Toast.show('取消收藏！');
      }
      print('上传$action成功!');
    }, onError: (code, msg) {
      print('上传$action失败!');
    });
  }
}
