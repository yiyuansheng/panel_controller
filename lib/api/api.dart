import 'package:flutter/material.dart';

import '../../utils/dio.dart';

export 'api.dart';

class FetchData {
  static DioApi dioApi = DioApi();
  // 登录接口 http://192.168.1.222:3000/project/11/interface/api/19
  static Future<dynamic> authLogin(BuildContext context, data) {
    return dioApi.post(context, '/api/auth/login', data: data);
  }

  // 获取空间树形结构 http://yapi.wanrun.pro/project/13/interface/api/954
  static Future<dynamic> productSpaceTree(BuildContext context) {
    return dioApi.get(context, '/api/product/space/tree');
  }
}
