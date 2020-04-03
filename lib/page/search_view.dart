import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/model/doc.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/navigator_util.dart';

class SearchViewPage extends StatefulWidget {
  final query;

  const SearchViewPage({Key key, this.query}) : super(key: key);

  @override
  _SearchViewPageState createState() => _SearchViewPageState(query);
}

class _SearchViewPageState extends State<SearchViewPage> {
  var docs = List<Doc>();
  var offset = 1;
  final query;

  _SearchViewPageState(this.query);

  @override
  void initState() {
    super.initState();
    getDocs();
  }

  @override
  Widget build(BuildContext context) {
    return docs.length == 0
        ? Center(child: CircularProgressIndicator())
        : EasyRefresh(
            header: BallPulseHeader(color: Colors.grey),
            footer: BallPulseFooter(color: Colors.grey),
            onLoad: () async {
              offset++;
              getDocs();
              setState(() {});
            },
            child: ListView.builder(
                itemCount: docs.length ?? 0, itemBuilder: _buildListItem),
          );
  }

  Future getDocs() async {
    var map = await DioUtil.request(ConstURL.search(query, 'doc', offset));
    var obj = map['data'];
    if (obj is List<dynamic>) {
      obj.forEach((o) {
        var doc = Doc.fromJson(o['target']);
        docs.add(doc);
        setState(() {});
      });
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      child: GestureDetector(
        onTap: () => NavigatorUtil.jump(context,
            '${Routes.reader}?bookId=${docs[index].bookId}&id=${docs[index].id}'),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 7.5, 5.0, 7.5),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 7.5, 5.0, 7.5),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    docs[index].title ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    docs[index].customDescription ??
                                        docs[index].description ??
                                        '',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ),
                          docs[index].cover != null && docs[index].cover != ''
                              ? Expanded(
                                  flex: 1,
                                  child: AspectRatio(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.network(
                                                docs[index].cover ?? '',
                                                fit: BoxFit.cover)),
                                      ),
                                      aspectRatio: 4.0 / 3.0),
                                )
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
