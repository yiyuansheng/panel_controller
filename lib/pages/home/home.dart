import 'package:flutter/cupertino.dart';
import 'package:panel_controller/pages/home/components/index.dart';
import 'package:panel_controller/pages/home/components/scene.dart';
import 'package:panel_controller/pages/home/components/device.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: PageController(initialPage: 1),
      children: const [Scene(), MyHomePage(), Device()],
    );
  }
}
