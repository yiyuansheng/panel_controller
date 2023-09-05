import 'dart:async';

import 'package:flutter/material.dart';
import 'package:panel_controller/pages/home/components/my_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../api/api.dart';

class Scene extends StatefulWidget {
  final List sceneList;
  final VoidCallback refresh;
  const Scene({super.key, required this.sceneList, required this.refresh});

  @override
  State<Scene> createState() => _Scene();
}

class _Scene extends State<Scene> {
  var toast = "";
  Timer? timer;
  // 执行场景
  void doScene(String name) {
    Map<String, dynamic>? result = widget.sceneList
        .firstWhere((map) => map['name'] == name, orElse: () => null);
    if (result != null) {
      FetchData.productIotSpaceControlScene({"ruleId": result['id']})
          .then((value) {
        showToast("已执行$name");

        widget.refresh();
      }).catchError((e) {});
    } else {
      showToast("该模式未配置");
    }
  }

  void showToast(String msg) {
    setState(() {
      toast = msg;
    });
    timer?.cancel();
    timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        toast = '';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var rowHeight = screenHeight / 4;

    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/highway.jpg"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 190,
                            child: Text(
                              toast,
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
                            ),
                          ))
                    ],
                  )),
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 24,
                                  spreadRadius: 16,
                                  offset: Offset(-4, 0),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.885,
                              children: [
                                MyButton(
                                    onPressed: () {
                                      doScene('回家模式');
                                    },
                                    name: "回家模式",
                                    src: 'images/in-home.png'),
                                MyButton(
                                    onPressed: () {
                                      doScene('离家模式');
                                    },
                                    name: "离家模式",
                                    src: 'images/out-home.png'),
                                MyButton(
                                    onPressed: () {
                                      doScene('就餐模式');
                                    },
                                    name: "就餐模式",
                                    src: 'images/catering.png'),
                                MyButton(
                                    onPressed: () {
                                      doScene('娱乐模式');
                                    },
                                    name: "娱乐模式",
                                    src: 'images/play.png'),
                                MyButton(
                                    onPressed: () {
                                      doScene('睡眠模式');
                                    },
                                    name: "睡眠模式",
                                    src: 'images/sleep.png'),
                                MyButton(
                                    onPressed: () {
                                      doScene('起床模式');
                                    },
                                    name: "起床模式",
                                    src: 'images/sun.png'),
                                MyButton(
                                    onPressed: () {
                                      doScene('阅读模式');
                                    },
                                    name: "阅读模式",
                                    src: 'images/read.png'),
                                MyButton(
                                    onPressed: () {
                                      doScene('电影模式');
                                    },
                                    name: "电影模式",
                                    src: 'images/movie.png'),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        )
      ],
    ));
  }
}
