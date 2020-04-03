import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/common/date_info.dart';
import 'package:lark/model/doc_detail.dart';
import 'package:lark/model/publish.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/navigator_util.dart';
import 'package:notus/convert.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class CreateDocBodyPage extends StatefulWidget {
  final String bookId;

  const CreateDocBodyPage({Key key, this.bookId}) : super(key: key);

  @override
  CreateDocBodyPageState createState() => CreateDocBodyPageState(bookId);
}

class CreateDocBodyPageState extends State<CreateDocBodyPage> {
  CreateDocBodyPageState(this.bookId);

  ZefyrController _controller;
  FocusNode _focusNode;
  final String bookId;

  @override
  void initState() {
    super.initState();
    Delta delta = Delta()..insert('\n');
    _controller = ZefyrController(NotusDocument.fromDelta(delta));
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    var dataInfo = Provider.of<DataInfo>(context);
    print(json.encode(dataInfo.publish));
    return Scaffold(
      appBar: AppBar(
        title: Text("创建文档"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                var body = notusMarkdown.encode(_controller.document.toDelta());
                Publish publish = dataInfo.publish;
                DioUtil.request(ConstURL.createDoc(bookId),
                        data: {
                          'title': publish.title,
                          'slug': publish.slug,
                          'public': publish.public,
                          'body': body,
                        },
                        method: DioUtil.POST)
                    .then((map) {
                  DocDetail docDetail = DocDetail.fromJson(map['data']);
                  NavigatorUtil.pop(context);
                  NavigatorUtil.popAndPushNamed(context,
                      '${Routes.reader}?bookId=${docDetail.bookId}&id=${docDetail.id}');
                  BotToast.showText(text: '发布成功');
                });
              }),
        ],
      ),
      body: ZefyrScaffold(
        child: ZefyrEditor(
          padding: EdgeInsets.all(16),
          controller: _controller,
          focusNode: _focusNode,
        ),
      ),
    );
  }
}
