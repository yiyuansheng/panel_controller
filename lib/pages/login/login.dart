import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_picker/flutter_picker.dart';
import '../../api/api.dart';

import 'package:get/get.dart';
import 'package:panel_controller/store/store.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  bool _obscureText = true;
  String phone = "13650973336";
  String password = "123456";
  var tree = [];
  var buildings = [];
  var floors = [];
  var rooms = [];
  var selectedBuilding = 0;
  var selectedFloor = 0;
  var selectedRoom = 0;

  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 使用TextEditingValue设置默认值
    controller.value = TextEditingValue(text: phone);
    controller2.value = TextEditingValue(text: password);
  }

  @override
  Widget build(BuildContext context) {
    final Controller _controller = Get.find();

    void showPicker(BuildContext context) {
      var pickerData = [
        buildings.map((m) => m["name"]).toList(),
        floors.map((m) => m["name"]).toList(),
        rooms.map((m) => m["name"]).toList()
      ];
      print(pickerData);
      Picker(
          adapter: PickerDataAdapter<String>(
            pickerData: pickerData,
            isArray: true,
          ),
          title: const Text('选择房间'),
          changeToFirst: true,
          hideHeader: false,
          cancelText: '取消',
          confirmText: '确认',
          columnPadding: const EdgeInsets.all(8.0),
          onConfirm: (Picker picker, List value) {
            print(value);
          }).showModal(context);
    }

    // 登录方法
    void _login() async {
      if (phone == '') {
        Fluttertoast.showToast(
            backgroundColor: Colors.white12,
            msg: "请输入手机号",
            gravity: ToastGravity.CENTER);
      } else if (password == '') {
        Fluttertoast.showToast(
            backgroundColor: Colors.white12,
            msg: "请输入密码",
            gravity: ToastGravity.CENTER);
      } else {
        // 生成MD5加密
        var content = new Utf8Encoder().convert(password);
        var digest = md5.convert(content);
        // 加密结果转换为16进制字符串
        String pwMd5 = digest.toString();
        FetchData.authLogin(context, {
          "userAccount": phone,
          "pwd": pwMd5,
          "platformId": 12,
        }).then((value) {
          // print(value);
          _controller.userInfo(value);

          FetchData.productSpaceTree(
            context,
          ).then((data) {
            setState(() {
              tree = data;
              buildings = data;
              floors = buildings[0]['children'];
              rooms = floors[0]['children'];
            });
            // Fluttertoast.showToast(
            //     backgroundColor: Colors.white12,
            //     msg: "登录成功",
            //     gravity: ToastGravity.CENTER);

            // print(data.toString());
            showPicker(context);
          }).catchError((e) {
            print(e.toString());
          });
        }).catchError((e) {});
      }
    }

    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            // autofocus: true,
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                labelText: "账号",
                hintText: "请输入手机号",
                prefixIcon: Icon(Icons.person)),
            onChanged: (value) {
              setState(() {
                phone = value;
              });
            },
          ),
          TextField(
            controller: controller2,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                labelText: "密码",
                hintText: "请输入密码",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ))),
            obscureText: _obscureText,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            onSubmitted: (value) {
              _login();
            },
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              style: ButtonStyle(),
              onPressed: () {
                _login();
              },
              child: const Text("登录"),
            ),
          )
        ],
      ),
    ));
  }
}
