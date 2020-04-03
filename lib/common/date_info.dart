import 'package:flutter/material.dart';
import 'package:lark/model/publish.dart';
import 'package:lark/model/user.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/sp_util.dart';

class DataInfo with ChangeNotifier {
  bool dark = true;
  User user;
  String token;
  Publish publish;

  changeTheme() {
    if (dark) {
      dark = false;
    } else {
      dark = true;
    }
    notifyListeners();
  }

  initToken(token) {
    this.token = token;
    DioUtil.createInstanceWithToken(token);
    SpUtil.setString('token', token);
    notifyListeners();
  }

  initUserInfo(var user) {
    this.user = user;
    notifyListeners();
  }

  post(var publish) {
    this.publish = publish;
    notifyListeners();
  }

  logout() {
    this.user = null;
    this.token = null;
    SpUtil.clear();
    notifyListeners();
  }
}
