import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/model/ability.dart';
import 'package:lark/model/book_detail.dart';
import 'package:lark/model/doc.dart';
import 'package:lark/page/empty.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/navigator_util.dart';

class DocPage extends StatefulWidget {
  final String bookId;

  const DocPage({Key key, this.bookId}) : super(key: key);

  @override
  _DocPageState createState() => _DocPageState(bookId);
}

class _DocPageState extends State<DocPage> {
  final String bookId;
  Ability ability;
  BookDetail bookDetail;
  var docs;
  var offset = 0;
  var limit = 10;

  _DocPageState(this.bookId);

  void getDocs() async {
    if (docs == null) {
      docs = List<Doc>();
    }
    var map = await DioUtil.request(ConstURL.myDocs(bookId, offset, limit));
    var map2 = await DioUtil.request(ConstURL.book(bookId));
    print(map2['abilities']);
    ability = Ability.fromJson(map2['abilities']);
    bookDetail = BookDetail.fromJson(map2['data']);
    var obj = map['data'];
    if (obj is List<dynamic>) {
      obj.forEach((o) {
        var doc = Doc.fromJson(o);
        docs.add(doc);
      });
    }
    setState(() {});
  }

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      title: Text(docs[index].title),
      trailing: Icon(Icons.keyboard_arrow_right),
      subtitle: Text(
        docs[index].customDescription ?? docs[index].description ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        NavigatorUtil.jump(context,
            '${Routes.reader}?bookId=${docs[index].bookId}&id=${docs[index].id}');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getDocs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(bookDetail?.name ?? ''),
        ),
        body: docs == null
            ? Center(child: CircularProgressIndicator())
            : docs.length == 0
                ? EmptyPage()
                : EasyRefresh(
                    header: BallPulseHeader(color: Colors.grey),
                    footer: BallPulseFooter(color: Colors.grey),
                    child: ListView.builder(
                        itemCount: docs.length, itemBuilder: _buildListItem),
                    onRefresh: () async {
                      docs.clear();
                      offset = 0;
                      getDocs();
                    },
                    onLoad: () async {
                      offset += limit;
                      getDocs();
                    },
                  ),
        floatingActionButton: ability?.doc?.create ?? false
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => NavigatorUtil.jump(
                    context, '${Routes.createDocInfo}?bookId=$bookId'))
            : null);
  }
}
