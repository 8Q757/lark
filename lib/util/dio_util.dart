import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

class DioUtil {
  static Dio dio;

  static const String API_PREFIX = 'https://www.yuque.com/api';
  static const int CONNECT_TIMEOUT = 50000;
  static const int RECEIVE_TIMEOUT = 3000;

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static Future<Map> request(String url, {data, method}) async {
    data = data ?? {};
    method = method ?? 'GET';

    data.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });

    print('请求地址：【' + method + '  ' + url + '】');
    print('请求参数：' + data.toString());

    dio = createInstance();
    var result;

    try {
      Response response = await dio.request(url,
          data: data, options: new Options(method: method));

      result = response.data;

      /// 打印响应相关信息
      print('响应数据：' + response.toString());
    } on DioError catch (e) {
      BotToast.showText(text: "请求异常");

      /// 打印请求失败相关信息
      print('请求出错：' + e.toString());
    }

    return result;
  }

  /// 创建 dio 实例对象
  static Dio createInstance() {
    if (dio == null) {
      /// 全局属性：请求前缀、连接超时时间、响应超时时间
      dio = Dio();
      dio.options.baseUrl = API_PREFIX;
      dio.options.connectTimeout = CONNECT_TIMEOUT;
      dio.options.receiveTimeout = RECEIVE_TIMEOUT;
    }
    return dio;
  }

  static createInstanceWithToken(String token) {
    /// 全局属性：请求前缀、连接超时时间、响应超时时间
    dio = Dio();
    dio.options.baseUrl = API_PREFIX;
    dio.options.connectTimeout = CONNECT_TIMEOUT;
    dio.options.receiveTimeout = RECEIVE_TIMEOUT;
    dio.options.headers['X-Auth-Token'] = token;
  }

  /// 清空 dio 对象
  static clear() {
    dio = null;
  }
}
