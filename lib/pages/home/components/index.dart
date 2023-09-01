import 'package:flutter/material.dart';
import 'package:panel_controller/pages/home/components/my_button.dart';
import '../../../api/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  final List list;
  final VoidCallback refresh;
  const MyHomePage({super.key, required this.list, required this.refresh});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  void loadDeviceList() {
    FetchData.productIotSpaceDevices({"spaceId": "1691638827033137153"})
        .then((value) {
      print(value);
    }).catchError((e) {});
  }

  // @override
  // void didUpdateWidget(covariant MyHomePage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print('哈哈 ${widget.list[1]}');
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
                        left: 8, bottom: 8, top: 0, right: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (Map item in widget.list)
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

                                      Fluttertoast.showToast(
                                          backgroundColor: Colors.black54,
                                          msg: value == 0 ? '已开启' : '已关闭',
                                          gravity: ToastGravity.CENTER);
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
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // 按键2
                        // Expanded(
                        //   child: ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //           padding: EdgeInsets.all(0),
                        //           backgroundColor:
                        //               Color.fromRGBO(31, 31, 31, 1),
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(10))),
                        //       onPressed: () {},
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.stretch,
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.only(top: 8),
                        //             child: Image.asset(
                        //               "images/light.png",
                        //               width: 64,
                        //               height: 64,
                        //             ),
                        //           ),
                        //           const Text(
                        //             '按键2',
                        //             textAlign: TextAlign.center,
                        //             style: TextStyle(color: Colors.white),
                        //           ),
                        //           Opacity(
                        //             opacity: 0.7,
                        //             child: Container(
                        //               height: 20,
                        //               decoration: const BoxDecoration(
                        //                 color: Color.fromRGBO(66, 66, 66, 1),
                        //                 borderRadius: BorderRadius.only(
                        //                   bottomLeft: Radius.circular(10.0),
                        //                   bottomRight: Radius.circular(10.0),
                        //                 ),
                        //               ),
                        //               child: Center(
                        //                 child: Container(
                        //                   width: 2,
                        //                   height: 8,
                        //                   decoration: const BoxDecoration(
                        //                       color: Colors.green,
                        //                       borderRadius: BorderRadius.all(
                        //                           Radius.circular(4))),
                        //                 ),
                        //               ),
                        //             ),
                        //           )
                        //         ],
                        //       )),
                        // ),
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
