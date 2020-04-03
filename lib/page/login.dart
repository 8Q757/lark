import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/common/date_info.dart';
import 'package:lark/util/dio_util.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

void login() async {
  BotToast.showLoading();
  var url = ConstURL.loginURL;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw '未知错误';
  }
}

void callBack(DataInfo dataInfo) async {
  var requestServer =
      await HttpServer.bind(InternetAddress.loopbackIPv4, 51314);
  print('监听 localhost地址，端口号为${requestServer.port}');

  //监听请求
  await for (HttpRequest request in requestServer) {
    var code = request.uri.queryParameters['code'];
    if (code != null) {
      DioUtil.request('${ConstURL.accessToken}?code=$code').then((data) {
        dataInfo.initToken(data['data']);
        request.response
          ..write('授权成功，请返回APP。')
          ..close();
        BotToast.closeAllLoading();
      });
    }
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var dataInfo = Provider.of<DataInfo>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 80.0,
                    width: 80.0,
                    child: Image.asset('assets/icon/icon.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.5),
                    child: Text('云雀',
                        style: TextStyle(
                          fontSize: 36.0,
                          color: Colors.teal,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.5),
                    child: Text(
                      '语雀第三方APP',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7.5),
                    child: RaisedButton(
                      child: Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                      color: Colors.greenAccent[700],
                      shape: CircleBorder(),
                      onPressed: () {
                        callBack(dataInfo);
                        login();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
