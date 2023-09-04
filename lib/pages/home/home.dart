import 'package:flutter/material.dart';
import 'package:panel_controller/pages/home/components/index.dart';
import 'package:panel_controller/pages/home/components/scene.dart';
import 'package:panel_controller/pages/home/components/login.dart';
import '../../../api/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final PageController _pageController = PageController(initialPage: 1);

  List<dynamic> deviceList = [
    {
      'id': 0,
      "deviceName": "",
      "props": {"status": 0}
    },
    {
      'id': 0,
      "deviceName": "",
      "props": {"status": 0}
    }
  ];
  var sceneList = [];

  // 登录完成请求数据
  void loginOk() {
    _pageController.jumpToPage(1);
    loadData();
  }

  // 加载设备列表
  void loadData() {
    loadDevice();
    loadScene();
  }

  void loadDevice() {
    FetchData.productIotSpaceDevices({"spaceId": "1691638827033137153"})
        .then((value) {
      List<dynamic> filteredList = value
          .where((item) => item['categoryId'] == '1592379263808442370')
          .toList()
          .take(2)
          .toList();
      setState(() {
        deviceList = filteredList;
      });
    }).catchError((e) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white12,
          msg: "请重新登录",
          gravity: ToastGravity.CENTER);
    });
  }

  // 加载场景
  void loadScene() {
    FetchData.productIotSpaceIndexScence({'spaceRootId': '1691638707281563649'})
        .then((value) {
      setState(() {
        sceneList = value.toList();
      });
    }).catchError((e) {
      Fluttertoast.showToast(
          backgroundColor: Colors.white12,
          msg: "请重新登录",
          gravity: ToastGravity.CENTER);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        Scene(sceneList: sceneList, refresh: loadData),
        MyHomePage(
            deviceList: deviceList, sceneList: sceneList, refresh: loadData),
        Login(loginOk: loginOk)
      ],
    );
  }
}
