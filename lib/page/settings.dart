import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('设置'),
        ),
        body: Container(
            child: ListView(
          children: <Widget>[
            ListTile(
                title: Text(
              '退出登录',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            )),
          ],
        )));
  }
}
