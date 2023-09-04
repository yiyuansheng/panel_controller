import 'dart:async';

import 'package:flutter/material.dart';
import 'package:panel_controller/pages/home/components/my_button.dart';
import '../../../api/api.dart';
import 'package:get/get.dart';
import 'package:panel_controller/store/store.dart';
import 'package:intl/intl.dart'; // 导入 intl 包

class MyHomePage extends StatefulWidget {
  final List deviceList;
  final List sceneList;
  final VoidCallback refresh;
  const MyHomePage(
      {super.key,
      required this.deviceList,
      required this.sceneList,
      required this.refresh});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Controller _controller = Get.find();

  DateTime _currentTime = DateTime.now();
  Timer? _timer;

  var week = {
    "1": "周一",
    "2": "周二",
    "3": "周三",
    "4": "周四",
    "5": "周五",
    "6": "周六",
    "7": "周日",
  };

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });

    // print(_currentTime.weekday);
  }

  // 执行场景
  void doScene(String name) {
    Map<String, dynamic>? result = widget.sceneList
        .firstWhere((map) => map['name'] == name, orElse: () => null);
    if (result != null) {
      FetchData.productIotSpaceControlScene({"ruleId": result['id']})
          .then((value) {
        _controller.showToast("已执行$name");

        widget.refresh();
      }).catchError((e) {});
    } else {
      _controller.showToast("该模式未配置");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel(); // 取消定时器
  }

  // @override
  // void didUpdateWidget(covariant MyHomePage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print('哈哈 ${widget.list[1]}');
  // }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy年-MM月-dd日');

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            // 背景色
            Container(
              color: Colors.black,
              width: double.infinity,
              height: double.infinity,
            ),
            // 背景图
            Positioned(
                left: -200,
                bottom: -140,
                child: Image.asset(
                  "images/earth.jpeg",
                  width: 375,
                  height: 500,
                )),

            Row(
              children: [
                // 左边
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          // 天气
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "images/sun.png",
                                  width: 32,
                                  height: 32,
                                ),
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "广州市 32℃",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text("晴",
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          ),
                          Text(
                              "${dateFormat.format(_currentTime)}  ${week[_currentTime.weekday.toString()]}",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Colors.white,
                              ))
                        ],
                      ),
                      // Obx：将整个部件树包裹在 Obx 中，当包裹的可观察变量发生变化时，整个 Obx 部件树将被重建。
                      // GetBuilder：仅将特定部件包裹在 GetBuilder 中，当包裹的可观察变量发生变化时，只有 GetBuilder 包裹的部件会被重建，其他部件保持不变。
                      Obx(
                        () => Visibility(
                            visible: _controller.visibleToast.value,
                            child: Text(
                              _controller.toast.value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 24,
                              spreadRadius: 16,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("室内 28℃ | 湿度35%",
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
                // 中间
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, bottom: 8, top: 0, right: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (Map item in widget.deviceList)
                          // 按键1
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(0),
                                      backgroundColor:
                                          Color.fromRGBO(31, 31, 31, 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  // 事件
                                  onPressed: () {
                                    if (item['id'] == 0) {
                                      return;
                                    }
                                    var value =
                                        item['props']?['status'] == 1 ? 0 : 1;

                                    FetchData.productIotSpaceControlDevice({
                                      'deviceId': item['id'],
                                      'properties': [
                                        {
                                          'name': "status",
                                          'value': value,
                                        },
                                      ],
                                    }).then((res) {
                                      widget.refresh();
                                      _controller.showToast(
                                          value == 0 ? '已开启' : '已关闭');
                                    }).catchError((e) {});
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8,
                                        ),
                                        child: Image.asset(
                                          item['props']?['status'] == 1
                                              ? "images/light.png"
                                              : 'images/light-dark.png',
                                          width: 64,
                                          height: 64,
                                        ),
                                      ),
                                      Text(
                                        item['deviceName'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: item['props']?['status'] == 1
                                                ? const Color.fromRGBO(
                                                    249, 242, 139, 1)
                                                : Colors.white),
                                      ),
                                      Opacity(
                                        opacity: 0.7,
                                        child: Container(
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: item['props']?['status'] == 1
                                                ? const Color.fromRGBO(
                                                    66, 66, 66, 1)
                                                : const Color.fromRGBO(
                                                    66, 66, 66, 0.5),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(10.0),
                                              bottomRight:
                                                  Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Center(
                                            child: Container(
                                              width: 2,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                  color: item['props']
                                                              ?['status'] ==
                                                          1
                                                      ? Colors.green
                                                      : Colors.black38,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(4))),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // 右边-情景模式
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 4, top: 8, right: 8, bottom: 8),
                    child: Column(
                      children: [
                        Expanded(
                          child: MyButton(
                              onPressed: () {
                                doScene('睡眠模式');
                              },
                              name: "睡眠模式",
                              src: 'images/sleep.png'),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: MyButton(
                              onPressed: () {
                                doScene('起床模式');
                              },
                              name: "起床模式",
                              src: 'images/sun.png'),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: MyButton(
                              onPressed: () {
                                doScene('电影模式');
                              },
                              name: "电影模式",
                              src: 'images/movie.png'),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: MyButton(
                              onPressed: () {
                                doScene('阅读模式');
                              },
                              name: "阅读模式",
                              src: 'images/read.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
