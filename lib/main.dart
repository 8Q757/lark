import 'package:bot_toast/bot_toast.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lark/common/date_info.dart';
import 'package:lark/page/home.dart';
import 'package:lark/page/login.dart';
import 'package:lark/routers/application.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/sp_util.dart';
import 'package:provider/provider.dart';

void main() {
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  runApp(ChangeNotifierProvider(
    create: (context) => DataInfo(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataInfo = Provider.of<DataInfo>(context);
    if (dataInfo.token == null) {
      SpUtil.getString('token').then((token) {
        dataInfo.initToken(token);
      });
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '云雀',
      theme: dataInfo.dark
          ? ThemeData.dark()
          : ThemeData(primarySwatch: Colors.teal),
      home: BotToastInit(
          child: dataInfo.token == null ? LoginPage() : HomePage()),
      onGenerateRoute: Application.router.generator,
    );
  }
}
