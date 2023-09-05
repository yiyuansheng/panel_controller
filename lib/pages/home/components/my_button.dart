import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final VoidCallback onPressed;
  // final List<Widget> children;
  final String name;
  final String src;

  const MyButton({
    required this.onPressed,
    // required this.children,
    required this.name,
    required this.src,
  });

  @override
  _MyButton createState() => _MyButton();
}

class _MyButton extends State<MyButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(31, 31, 31, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: widget.onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              widget.src,
              width: 32,
              height: 32,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ));
  }
}


// // 使用
// AnimatedButton(
//   onPressed: () {
//     // 点击处理
//   },
//   children: [
//     Text("Text1"),
//     Expanded(
//       child: Container(
//         color: Colors.red,
//         child: Center(
//           child: Text("Text2"),
//         ),
//       ),
//     ),
//     Text("Text3"),
//   ],
// )