import 'package:flutter/material.dart';

import '../../utils/dio.dart';

export 'api.dart';

class FetchData {
  static DioApi dioApi = DioApi();
  // 登录接口 http://192.168.1.222:3000/project/11/interface/api/19
  static Future<dynamic> authLogin(data) {
    return dioApi.post('/api/auth/login', data: data);
  }

  // 获取空间树形结构 http://yapi.wanrun.pro/project/13/interface/api/954
  static Future<dynamic> productSpaceTree() {
    return dioApi.get('/api/product/space/tree');
  }

//通过空间Id获取设备列表 http://yapi.wanrun.pro/project/13/interface/api/976
  static Future<dynamic> productIotSpaceDevices(params) {
    return dioApi.get('/api/product/iot/space/devices', params: params);
  }

  //控制设备  http://192.168.1.222:3000/project/13/interface/api/1012
  static Future<dynamic> productIotSpaceControlDevice(data) {
    return dioApi.post('/api/product/iot/space/control/device', data: data);
  }
}
