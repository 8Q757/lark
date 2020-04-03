import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/model/group.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/navigator_util.dart';

import 'empty.dart';

class GroupPage extends StatefulWidget {
  final userId;

  const GroupPage({Key key, this.userId}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState(userId);
}

class _GroupPageState extends State<GroupPage> {
  final userId;
  var groups;
  var offset = 0;
  var limit = 10;

  _GroupPageState(this.userId);

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      title: Text(groups[index].name),
      leading: CircleAvatar(
        backgroundColor: (Colors.white),
        backgroundImage: NetworkImage('${groups[index].avatarUrl}'),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      subtitle: Text('${groups[index].description}'),
      onTap: () => NavigatorUtil.jump(
          context, '${Routes.groupBook}?userId=${groups[index].id}'),
    );
  }

  void getGroups() async {
    if (groups == null) {
      groups = List<Group>();
    }
    var map = await DioUtil.request(ConstURL.myGroups(userId, offset, limit));
    var obj = map['data'];
    if (obj is List<dynamic>) {
      obj.forEach((o) {
        var group = Group.fromJson(o);
        groups.add(group);
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    getGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('协作'),
      ),
      body: groups == null
          ? Center(child: CircularProgressIndicator())
          : groups.length == 0
              ? EmptyPage()
              : EasyRefresh(
                  header: BallPulseHeader(color: Colors.grey),
                  footer: BallPulseFooter(color: Colors.grey),
                  child: ListView.builder(
                      itemCount: groups.length, itemBuilder: _buildListItem),
                  onRefresh: () async {
                    groups.clear();
                    offset = 0;
                    getGroups();
                  },
                  onLoad: () async {
                    offset += limit;
                    getGroups();
                  },
                ),
    );
  }
}
