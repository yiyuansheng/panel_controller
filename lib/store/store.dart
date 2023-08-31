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

  Controller() {
    // 初始化缓存器
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
    }).catchError((e) {
      print(e);
    });
  }
}
