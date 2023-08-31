import 'package:flutter/material.dart';
import 'package:panel_controller/pages/home/components/my_button.dart';

class Scene extends StatefulWidget {
  const Scene({super.key});

  @override
  State<Scene> createState() => _Scene();
}

class _Scene extends State<Scene> {
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
              Image.asset(
                "images/highway.jpg",
                width: 190,
                fit: BoxFit.cover,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.black, boxShadow: [
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
                          children: [
                            MyButton(
                                onPressed: () {},
                                name: "睡眠模式",
                                src: 'images/sleep.png'),
                            MyButton(
                                onPressed: () {},
                                name: "起床模式",
                                src: 'images/sun.png'),
                            MyButton(
                                onPressed: () {},
                                name: "睡眠模式",
                                src: 'images/sleep.png'),
                            MyButton(
                                onPressed: () {},
                                name: "起床模式",
                                src: 'images/sun.png'),
                            MyButton(
                                onPressed: () {},
                                name: "睡眠模式",
                                src: 'images/sleep.png'),
                            MyButton(
                                onPressed: () {},
                                name: "起床模式",
                                src: 'images/sun.png'),
                            MyButton(
                                onPressed: () {},
                                name: "睡眠模式",
                                src: 'images/sleep.png'),
                            MyButton(
                                onPressed: () {},
                                name: "起床模式",
                                src: 'images/sun.png'),
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
