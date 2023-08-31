import 'package:flutter/material.dart';
import 'package:panel_controller/pages/home/components/my_button.dart';
import '../../../api/api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
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
                          const Text(
                            "15:57",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          ),
                          const Text("8月16日 周三",
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.white))
                        ],
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
                        left: 8, bottom: 8, top: 8, right: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                  backgroundColor:
                                      Color.fromRGBO(31, 31, 31, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              // 事件
                              onPressed: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                    ),
                                    child: Image.asset(
                                      "images/light.png",
                                      width: 64,
                                      height: 64,
                                    ),
                                  ),
                                  const Text(
                                    "按键1",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Opacity(
                                    opacity: 0.7,
                                    child: Container(
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(66, 66, 66, 1),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 2,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4))),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                  backgroundColor:
                                      Color.fromRGBO(31, 31, 31, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Image.asset(
                                      "images/light.png",
                                      width: 64,
                                      height: 64,
                                    ),
                                  ),
                                  const Text(
                                    "按键2",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Opacity(
                                    opacity: 0.7,
                                    child: Container(
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(66, 66, 66, 1),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 2,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4))),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
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
                              onPressed: () {},
                              name: "睡眠模式",
                              src: 'images/sleep.png'),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: MyButton(
                              onPressed: () {},
                              name: "起床模式",
                              src: 'images/sun.png'),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: MyButton(
                              onPressed: () {},
                              name: "电影模式",
                              src: 'images/movie.png'),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: MyButton(
                              onPressed: () {},
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
