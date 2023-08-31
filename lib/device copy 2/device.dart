import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crypto/crypto.dart';
import '../api/api.dart';

class Device extends StatefulWidget {
  const Device({super.key});

  @override
  State<Device> createState() => _Device();
}

class _Device extends State<Device> {
  bool _obscureText = true;
  String phone = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            // autofocus: true,
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
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              child: const Text("登录"),
              style: ButtonStyle(),
              onPressed: () async {
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
                  var data = FetchData.authLogin(context, {
                    "userAccount": phone,
                    "pwd": pwMd5,
                    "platformId": 12,
                  });
                  // Fluttertoast.showToast(
                  //     backgroundColor: Colors.white12,
                  //     msg: "登录成功",
                  //     gravity: ToastGravity.CENTER);
                  print(data.toString());
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
