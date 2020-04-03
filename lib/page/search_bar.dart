import 'package:flutter/material.dart';
import 'package:lark/common/date_info.dart';
import 'package:lark/page/search_view.dart';
import 'package:provider/provider.dart';

class SearchBar extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => '搜索...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    var dataInfo = Provider.of<DataInfo>(context);
    return dataInfo.dark
        ? ThemeData.dark()
        : ThemeData(primarySwatch: Colors.teal);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchViewPage(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
