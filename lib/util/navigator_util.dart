import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lark/routers/application.dart';

class NavigatorUtil {
  // 带参数的返回
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

  // 路由返回指定页面
  static void popAndPushNamed(BuildContext context, String title) {
    Navigator.of(context).popAndPushNamed(title);
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// 跳转到 转场动画 页面 ， 这边只展示 inFromLeft ，剩下的自己去尝试下，
  /// 框架自带的有 native，nativeModal，inFromLeft，inFromRight，inFromBottom，fadeIn，custom
  static Future jump(BuildContext context, String title) {
    return Application.router
        .navigateTo(context, title, transition: TransitionType.native);
  }
}
