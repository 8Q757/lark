import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/model/doc.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/navigator_util.dart';

class RecommendPage extends StatefulWidget {
  final url;

  const RecommendPage({Key key, this.url}) : super(key: key);

  @override
  _RecommendPageState createState() => _RecommendPageState(url);
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  final url;
  var docs = List<Doc>();
  var limit = 10;
  var page = 1;

  _RecommendPageState(this.url);

  @override
  void initState() {
    super.initState();
    getDocs();
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
                  padding: const EdgeInsets.all(7.5),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            docs[index].user.avatarUrl ?? ConstURL.defaultLogo),
                        radius: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              docs[index].user.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              DateTimeFormat.format(
                                  DateTime.parse(docs[index].updatedAt),
                                  format: r'm-d H:i'),
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                                    docs[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    docs[index].customDescription ??
                                        docs[index].description,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 7.5, 5.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            '发布于 ',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                          Text(
                            docs[index].book.name,
                            style: TextStyle(fontSize: 12.0),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '获得 ',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                          Text(
                            (docs[index].likesCount * 7).toString(),
                            style: TextStyle(fontSize: 13.0),
                          ),
                          Text(
                            ' 颗稻谷',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
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

  void getDocs() async {
    var map = await DioUtil.request('$url?limit=$limit&page=$page');
    var obj = map['data']['docs'];
    if (obj is List<dynamic>) {
      obj.forEach((o) {
        var doc = Doc.fromJson(o);
        docs.add(doc);
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return docs.length == 0
        ? Center(child: CircularProgressIndicator())
        : EasyRefresh(
            header: BallPulseHeader(color: Colors.grey),
            footer: BallPulseFooter(color: Colors.grey),
            child: ListView.builder(
                itemCount: docs.length, itemBuilder: _buildListItem),
            onRefresh: () async {
              docs.clear();
              page = 1;
              getDocs();
            },
            onLoad: () async {
              page++;
              getDocs();
            },
          );
  }

  @override
  bool get wantKeepAlive => true;
}
