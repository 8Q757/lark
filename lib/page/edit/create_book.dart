import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/model/book_detail.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/navigator_util.dart';

class CreateBookPage extends StatefulWidget {
  final userId;
  final clazz;

  const CreateBookPage({Key key, this.userId, this.clazz}) : super(key: key);

  @override
  _CreateBookPageState createState() => _CreateBookPageState(userId, clazz);
}

class _CreateBookPageState extends State<CreateBookPage> {
  final userId;
  final clazz;
  var name;
  var description;
  var slug;
  var public = '1';

  _CreateBookPageState(this.userId, this.clazz);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("创建知识库"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                DioUtil.request(
                        clazz == 0
                            ? ConstURL.createMyBook(userId)
                            : ConstURL.createGroupBook(userId),
                        data: {
                          'name': name,
                          'slug': slug,
                          'description': description,
                          'public': int.parse(public),
                          'type': 'Book'
                        },
                        method: DioUtil.POST)
                    .then((map) {
                  BookDetail bookDetail = BookDetail.fromJson(map['data']);
                  NavigatorUtil.popAndPushNamed(
                      context, '${Routes.docList}?bookId=${bookDetail.id}');
                  BotToast.showText(text: '发布成功');
                });
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
                    name = value;
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
                  slug = value;
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 7.5, 16.0, 7.5),
              child: TextField(
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "描述",
                    hintText: "选填",
                    icon: Icon(
                      Icons.description,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    description = value;
                    setState(() {});
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 7.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Icon(Icons.lock_outline, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: DropdownButton(
                      items: <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                          child: Text(
                            "私密",
                          ),
                          value: "0",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "所有人可见",
                          ),
                          value: "1",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "空间成员可见",
                          ),
                          value: "2",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "空间所有人（含外部联系人）可见",
                          ),
                          value: "3",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "知识库成员可见",
                          ),
                          value: "4",
                        ),
                      ],
                      style: TextStyle(color: Colors.grey[600]),
                      onChanged: (selectValue) {
                        public = selectValue;
                        setState(() {});
                      },
                      underline: Container(
                        height: 1,
                        color: Colors.grey[500],
                      ),
                      value: public,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
