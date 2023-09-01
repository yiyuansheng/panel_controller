// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'store.dart';

class Controller extends GetxController {
  late SharedPreferences _prefs;
  var token = "".obs;
  var userInfo = {}.obs;

  var count = 0.obs;
  increment() => count++;

  // 保存token
  setToken(value) {
    token.value = value;
    _prefs.setString("token", value);
  }

  Controller() {
    // 初始化缓存器
    init();
    // SharedPreferences.getInstance().then((value) {
    //   _prefs = value;
    // }).catchError((e) {
    //   print(e);
    // });
  }

  init() async {
    _prefs = await SharedPreferences.getInstance();
    token.value = _prefs.getString("token") ?? '';
  }
}
