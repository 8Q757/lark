import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/model/doc_detail.dart';
import 'package:lark/util/dio_util.dart';

class AboutUsPage extends StatefulWidget {
  final slug;

  const AboutUsPage({Key key, this.slug}) : super(key: key);

  @override
  _ReadState createState() => _ReadState(slug);
}

class _ReadState extends State<AboutUsPage> {
  final slug;
  DocDetail docDetail;

  _ReadState(this.slug);

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
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(docDetail?.title ?? ''),
                centerTitle: true,
                background: Image.network(
                  docDetail?.cover ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ];
        },
        body: Container(
            child: docDetail == null
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: HtmlWidget(
                    docDetail?.bodyHtml ?? '',
                  ))),
      ),
    );
  }

  getDoc() async {
    var map = await DioUtil.request(ConstURL.about(slug));
    docDetail = DocDetail.fromJson(map['data']);
    setState(() {});
  }

  @override
  void initState() {
    getDoc();
  }
}
