import "package:flutter/material.dart";
import 'package:panel_controller/pages/home/home.dart';
import 'package:flutter/services.dart';
import 'package:panel_controller/store/store.dart';
import 'package:get/get.dart';

void main() async {
  // 设置全屏
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  Get.put(Controller());

  runApp(const GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 定义一个共享的ColorScheme
    // ColorScheme colorScheme = ColorScheme.fromSeed(
    //   seedColor: Colors.blue,
    //   primary: Colors.blue,
    //   secondary: Color.fromARGB(255, 142, 197, 223),
    // );
    return MaterialApp(
      title: '中控面板',
      theme: ThemeData.dark(),
      // theme: ThemeData(
      //   brightness: Brightness.dark,
      //   colorScheme: colorScheme,
      //   buttonTheme: ButtonThemeData(
      //     colorScheme: colorScheme,
      //   ),
      //   // useMaterial3: true,
      // ),
      home: const Home(),
    );
  }
}
