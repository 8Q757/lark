import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:lark/routers/router_handler.dart';

class Routes {
  static String root = '/';
  static String home = '/home';
  static String reader = '/docDetailPage';
  static String myBook = '/myBook';
  static String docList = '/docList';
  static String group = '/group';
  static String setting = '/setting';
  static String about = '/about';
  static String editor = '/editor';
  static String history = '/history';
  static String groupBook = '/groupBook';
  static String aboutUs = '/aboutUs';
  static String createDocInfo = '/info';
  static String creatorDocBody = '/creatorDoc';
  static String creatorBook = '/creatorBook';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('ERROR====>ROUTE WAS NOT FONUND!!!'); // 找不到路由，跳转404页面
        print('找不到路由，404');
      },
    );

    // 路由页面配置
    router.define(home, handler: homePage);
    router.define(reader, handler: readerPage);
    router.define(myBook, handler: myBookPage);
    router.define(docList, handler: myDocPage);
    router.define(group, handler: groupPage);
    router.define(setting, handler: settingPage);
    router.define(about, handler: aboutPage);
    router.define(editor, handler: editorPage);
    router.define(history, handler: historyPage);
    router.define(groupBook, handler: groupBookPage);
    router.define(aboutUs, handler: aboutUsPage);
    router.define(createDocInfo, handler: createDocInfoPage);
    router.define(creatorDocBody, handler: creatorDocBobyPage);
    router.define(creatorBook, handler: createBookPage);
  }
}
