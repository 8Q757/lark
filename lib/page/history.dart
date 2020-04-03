import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:lark/model/doc_history.dart';
import 'package:lark/page/empty.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/navigator_util.dart';
import 'package:lark/util/sp_util.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var docs;

  void getDocs() async {
    SpUtil.getJsonList("history").then((obj) {
      if (docs == null) {
        docs = List<DocHistory>();
      }
      if (obj != null) {
        obj.forEach((o) {
          var doc = DocHistory.fromJson(json.decode(o));
          docs.add(doc);
        });
      }
      setState(() {});
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      title: Text(docs[index].title),
      trailing: Icon(Icons.keyboard_arrow_right),
      subtitle: Text(
        docs[index].description ?? '',
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
        title: Text('历史'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              docs.clear();
              SpUtil.remove("history");
              BotToast.showText(text: "清除成功");
              setState(() {});
            },
          ),
        ],
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
                    getDocs();
                  },
                ),
    );
  }
}
