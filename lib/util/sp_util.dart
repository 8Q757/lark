import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {
  static final prefs = SharedPreferences.getInstance();

  static Future<String> getString(var key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.get(key);
  }

  static void clear() {
    prefs.then((sp) => sp.clear());
  }

  static void setString(var key, var value) {
    prefs.then((sp) => sp.setString(key, value));
  }

  static void remove(var key) {
    prefs.then((sp) => sp.remove(key));
  }

  static Future<List<String>> getJsonList(var key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }

  static void setJsonList(var key, var value) {
    var list;
    prefs.then((sp) {
      list = sp.getStringList(key) ?? List<String>();
      list.insert(0, json.encode(value));
      var set = list.toSet();
      print(set);
      sp.setStringList(key, set.toList());
    });
  }
}
