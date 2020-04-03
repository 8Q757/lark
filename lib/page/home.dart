import 'package:flutter/material.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/page/drawer.dart';
import 'package:lark/page/home/recommend.dart';
import 'package:lark/page/search_bar.dart';

import 'home/selections.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      RecommendPage(url: ConstURL.recommends),
      SelectionsPage(url: ConstURL.selections),
      SelectionsPage(url: ConstURL.docs),
//      SelectionsPage(),
//      DocsPage(),
    ];
    final _kTabs = <Tab>[
      Tab(text: '推荐'),
      Tab(text: '精选'),
      Tab(text: '热门'),
    ];
    return Scaffold(
      body: DefaultTabController(
        length: _kTabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('发现'),
            bottom: TabBar(
              tabs: _kTabs,
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () =>
                    showSearch(context: context, delegate: SearchBar()),
              ),
            ],
          ),
          drawer: MyDrawer(),
          body: TabBarView(
            children: _kTabPages,
          ),
        ),
      ),
    );
  }
}
