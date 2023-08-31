import 'package:flutter/material.dart';

class Device extends StatefulWidget {
  const Device({super.key});

  @override
  State<Device> createState() => _Device();
}

class _Device extends State<Device> {
  String phone = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: const Text(''),
    ));
  }
}
