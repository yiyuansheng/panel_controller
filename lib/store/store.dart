// import 'package:flutter/material.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'store.dart';

class Controller extends GetxController {
  late SharedPreferences _prefs;
  var token = "".obs;
  var userInfo = {}.obs;
  var toast = "".obs;
  var visibleToast = false.obs;
  Timer? timer;

  var count = 0.obs;
  increment() => count++;

  // 保存token
  setToken(value) {
    token.value = value;
    _prefs.setString("token", value);
  }

  // 展示提示
  showToast(msg) {
    toast.value = msg;
    visibleToast.value = true;
    timer?.cancel();
    timer = Timer(const Duration(seconds: 2), () {
      visibleToast.value = false;
      toast.value = "";
    });
  }

  Controller() {
    // 初始化缓存器
    init();
  }

  init() async {
    _prefs = await SharedPreferences.getInstance();
    token.value = _prefs.getString("token") ?? '';
  }
}
