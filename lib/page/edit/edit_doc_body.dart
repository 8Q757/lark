import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/model/ability.dart';
import 'package:lark/model/doc_detail.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/navigator_util.dart';
import 'package:notus/convert.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class EditorDocBodyPage extends StatefulWidget {
  final String bookId;
  final String id;

  const EditorDocBodyPage({Key key, this.bookId, this.id}) : super(key: key);

  @override
  EditorDocBodyPageState createState() => EditorDocBodyPageState(bookId, id);
}

class EditorDocBodyPageState extends State<EditorDocBodyPage> {
  ZefyrController _controller;
  FocusNode _focusNode;
  final String bookId;
  final String id;
  DocDetail docDetail;
  Ability ability;

  EditorDocBodyPageState(this.bookId, this.id);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    getBody().then((body) {
      _controller = ZefyrController(body);
      setState(() {});
    });
  }

  Future<NotusDocument> getBody() async {
    var map = await DioUtil.request(ConstURL.doc(bookId, id, 1));
    docDetail = DocDetail.fromJson(map['data']);
    Delta delta = Delta()..insert('${docDetail?.body}' ?? '');
    return NotusDocument.fromDelta(delta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑文档"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                var body = notusMarkdown.encode(_controller.document.toDelta());
                DioUtil.request(ConstURL.doc(bookId, id, null),
                        data: {
                          'title': docDetail.title,
                          'slug': docDetail.slug,
                          'public': docDetail.public,
                          'body': body,
                        },
                        method: DioUtil.PUT)
                    .then((map) {
                  NavigatorUtil.pop(context);
                  NavigatorUtil.popAndPushNamed(context,
                      '${Routes.reader}?bookId=${docDetail.bookId}&id=${docDetail.id}');
                  BotToast.showText(text: '保存成功');
                });
              }),
        ],
      ),
      body: ZefyrScaffold(
        child: _controller == null
            ? Center(child: CircularProgressIndicator())
            : ZefyrEditor(
                padding: EdgeInsets.all(16),
                controller: _controller,
                focusNode: _focusNode,
              ),
      ),
    );
  }
}
