import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lark/common/date_info.dart';
import 'package:lark/model/publish.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/navigator_util.dart';
import 'package:provider/provider.dart';

class CreateDocInfoPage extends StatefulWidget {
  final bookId;

  const CreateDocInfoPage({Key key, this.bookId}) : super(key: key);

  @override
  _CreateDocInfoPageState createState() => _CreateDocInfoPageState(bookId);
}

class _CreateDocInfoPageState extends State<CreateDocInfoPage> {
  final bookId;
  var isLock = false;
  Publish publish = Publish();

  _CreateDocInfoPageState(this.bookId);

  @override
  Widget build(BuildContext context) {
    var dataInfo = Provider.of<DataInfo>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("创建文档"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                publish.public = isLock ? 0 : 1;
                dataInfo.post(publish);
                NavigatorUtil.jump(
                    context, '${Routes.creatorDocBody}?bookId=$bookId');
              }),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 7.5, 16.0, 7.5),
              child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: "标题",
                    hintText: "必填，起个响亮的标题吧",
                    icon: Icon(
                      Icons.title,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    publish.title = value;
                    setState(() {});
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 7.5, 16.0, 7.5),
              child: TextField(
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp('[a-zA-Z0-9]'))
                ],
                maxLines: 1,
                decoration: InputDecoration(
//                  border: OutlineInputBorder(),
                  labelText: "Slug",
                  hintText: "选填，自定义文章的路径",
                  icon: Icon(
                    Icons.whatshot,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (value) {
                  publish.slug = value;
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7.5),
              child: SwitchListTile(
                title: Text(
                  '私密文档',
                  style: TextStyle(color: Colors.grey),
                ),
                value: isLock,
                secondary: Icon(
                  isLock ? Icons.lock : Icons.lock_open,
                  color: Colors.grey,
                ),
                onChanged: (bool value) {
                  setState(() {
                    isLock = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
