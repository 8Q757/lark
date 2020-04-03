import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/model/ability.dart';
import 'package:lark/model/book.dart';
import 'package:lark/page/empty.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/navigator_util.dart';

class BookPage extends StatefulWidget {
  final userId;

  const BookPage({Key key, this.userId}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState(userId);
}

class _BookPageState extends State<BookPage> {
  final userId;
  var books;
  Ability ability;
  var offset = 0;
  var limit = 10;

  _BookPageState(this.userId);

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      title: Text(books[index].name),
      leading: Icon(books[index].public == 1 ? Icons.lock_open : Icons.https),
      trailing: Icon(Icons.keyboard_arrow_right),
      subtitle: Text('共有文档 ${books[index].itemsCount} 篇'),
      onTap: () => NavigatorUtil.jump(
          context, '${Routes.docList}?bookId=${books[index].id}'),
    );
  }

  void getBooks() async {
    if (books == null) {
      books = List<Book>();
    }
    var map = await DioUtil.request(ConstURL.myBooks(userId, offset, limit));
    var obj = map['data'];
    if (obj is List<dynamic>) {
      obj.forEach((o) {
        var book = Book.fromJson(o);
        books.add(book);
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我的'),
        ),
        body: books == null
            ? Center(child: CircularProgressIndicator())
            : books.length == 0
                ? EmptyPage()
                : EasyRefresh(
                    header: BallPulseHeader(color: Colors.grey),
                    footer: BallPulseFooter(color: Colors.grey),
                    child: ListView.builder(
                        itemCount: books.length, itemBuilder: _buildListItem),
                    onRefresh: () async {
                      books.clear();
                      offset = 0;
                      getBooks();
                    },
                    onLoad: () async {
                      offset += limit;
                      getBooks();
                    },
                  ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => NavigatorUtil.jump(
                context, '${Routes.creatorBook}?userId=$userId&clazz=0')));
  }
}
