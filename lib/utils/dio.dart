import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:panel_controller/store/store.dart';

export 'dio.dart';

class DioApi {
  final Controller _controller = Get.find();
  // static const String baseUrl = 'https://test-miniapp.wanrun.pro';
  static const String baseUrl = 'http://192.168.1.94:9999';
  late Dio _dio;

  DioApi() {
    // 基本配置项
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {'wr-payload': "", "platform-id": 12},
        connectTimeout: const Duration(milliseconds: 6000),
        receiveTimeout: const Duration(milliseconds: 6000),
      ),
    );
    // 添加响应拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
        // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
        options.headers['Wr-Payload'] = _controller.token();
        // print(options.headers);
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
        // 初始化
        if (response.headers['wr-payload'] != null) {
          _controller.token.value = response.headers['wr-payload']![0];
        }
        // print(response.data.toString());
        return handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
        e.printError();
        return handler.next(e);
      },
    ));
    // 日志拦截器
    // _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  // get请求
  Future<dynamic> get(
    BuildContext context,
    String path, {
    Map<String, dynamic>? params,
  }) async {
    final Response response;
    try {
      response = await _dio.get(
        path,
        queryParameters: params,
      );
      // print("$path ${params.toString()}");
    } on DioException catch (e) {
      // e.printInfo();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("提示"),
              content: Text(e.response?.data?['msg'] ?? '请求异常'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('确定'),
                )
              ],
            );
          });

      return Future.error(e);
    }

    return response.data;
  }

  // post请求
  Future<dynamic> post(
    BuildContext context,
    String path, {
    Map<String, dynamic>? data,
  }) async {
    final Response response;
    try {
      response = await _dio.post(
        path,
        data: data,
      );
    } on DioException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("提示"),
              content: Text(e.response?.data?['msg'] ?? '请求异常'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('确定'),
                )
              ],
            );
          });

      return Future.error(e);
    }

    return response.data;
  }

  // Future<Map<String, dynamic>> _handleResponse(Response response) async {

  //   if (response.statusCode == 200 ||
  //       response.statusCode == 201 ||
  //       response.statusCode == 204) {
  //     return response.data;
  //   } else {
  //     AlertDialog(
  //         title: const Text("提示"), content: response.data?.msg | '请求异常');
  //     return {
  //       "statusCode": response.statusCode,
  //       "statusMessage": response.statusMessage
  //     };
  //   }
  // }
}
