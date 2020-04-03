import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lark/page/about.dart';
import 'package:lark/page/about/about_us.dart';
import 'package:lark/page/edit/create_book.dart';
import 'package:lark/page/edit/create_doc_body.dart';
import 'package:lark/page/edit/create_doc_info.dart';
import 'package:lark/page/edit/edit_doc_body.dart';
import 'package:lark/page/group.dart';
import 'package:lark/page/group/group_book.dart';
import 'package:lark/page/history.dart';
import 'package:lark/page/home.dart';
import 'package:lark/page/reader.dart';
import 'package:lark/page/settings.dart';
import 'package:lark/page/user/user_book.dart';
import 'package:lark/page/user/user_doc.dart';

Handler homePage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HomePage();
  },
);
Handler readerPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return DocDetailPage(
        bookId: params['bookId'].first, id: params['id'].first);
  },
);
Handler myBookPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return BookPage(userId: params['userId'].first);
  },
);
Handler myDocPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return DocPage(bookId: params['bookId'].first);
  },
);
Handler groupPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return GroupPage(userId: params['userId'].first);
  },
);
Handler historyPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return HistoryPage();
  },
);
Handler groupBookPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return GroupBookPage(userId: params['userId'].first);
  },
);
Handler settingPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return SettingPage();
  },
);
Handler aboutPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return AboutPage();
  },
);
Handler editorPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return EditorDocBodyPage(
        bookId: params['bookId'].first, id: params['id'].first);
  },
);
Handler creatorDocBobyPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return CreateDocBodyPage(bookId: params['bookId'].first);
  },
);
Handler aboutUsPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return AboutUsPage(slug: params['slug'].first);
  },
);
Handler createDocInfoPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return CreateDocInfoPage(bookId: params['bookId'].first);
  },
);
Handler createBookPage = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    print(params);
    return CreateBookPage(
        userId: params['userId'].first, clazz: params['clazz'].first);
  },
);
