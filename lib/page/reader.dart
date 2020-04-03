import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/model/ability.dart';
import 'package:lark/model/doc_detail.dart';
import 'package:lark/model/doc_history.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/navigator_util.dart';
import 'package:lark/util/sp_util.dart';
import 'package:lark/util/time_util.dart';

class DocDetailPage extends StatefulWidget {
  final String bookId;
  final String id;

  const DocDetailPage({Key key, this.bookId, this.id}) : super(key: key);

  @override
  _ReadState createState() => _ReadState(bookId, id);
}

class _ReadState extends State<DocDetailPage> {
  DocDetail docDetail;
  Ability ability;
  final String bookId;
  final String id;

  _ReadState(this.bookId, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              forceElevated: false,
              automaticallyImplyLeading: true,
              titleSpacing: NavigationToolbar.kMiddleSpacing,
              expandedHeight:
                  docDetail?.cover != null && docDetail.cover != '' ? 200.0 : 0,
              snap: false,
              floating: true,
              title: Text(docDetail?.book?.name ?? ''),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.network(
                  docDetail?.cover ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () => BotToast.showText(text: "敬请期待"),
                ),
              ],
            )
          ];
        },
        body: Container(
          child: docDetail == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(7.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 7.5, 10, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(docDetail?.title ?? '',
                                      style: TextStyle(
                                          fontSize: 26.0,
                                          fontWeight: FontWeight.bold)),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7.5),
                                    child: Row(
//                                      mainAxisAlignment:
//                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            '${docDetail?.creator?.name ?? ''}  '),
                                        GestureDetector(
                                            child: Text(
                                              '${docDetail?.book?.name ?? ''}',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                            onTap: () => NavigatorUtil.jump(
                                                context,
                                                '${Routes.docList}?bookId=${docDetail?.book?.id}')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        docDetail.status == 0
                            ? Container()
                            : HtmlWidget(
                                docDetail?.bodyHtml ?? '',
                              ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                docDetail.status == 0
                                    ? '该文章暂未发布'
                                    : '最后编辑于 ${TimeUtil.convert2Timeline(docDetail?.updatedAt)}',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.0),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton:
          (ability?.update ?? false) && (docDetail?.format == 'markdown')
              ? FloatingActionButton(
                  child: const Icon(Icons.edit),
                  onPressed: () => NavigatorUtil.jump(
                      context, '${Routes.editor}?bookId=$bookId&id=$id'),
                )
              : null,
    );
  }

  getDoc() async {
    var map = await DioUtil.request(ConstURL.doc(bookId, id, null));
    docDetail = DocDetail.fromJson(map['data']);
    ability = Ability.fromJson(map['abilities']);
    setState(() {});
    setHistory();
  }

  setHistory() {
    var docHistory = DocHistory();
    docHistory.id = docDetail.id;
    docHistory.bookId = docDetail.bookId;
    docHistory.title = docDetail.title;
    docHistory.description =
        docDetail.customDescription ?? docDetail.description;
    SpUtil.setJsonList("history", docHistory);
  }

  @override
  void initState() {
    getDoc();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
