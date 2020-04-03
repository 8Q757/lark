import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/common/date_info.dart';
import 'package:lark/model/user.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/dio_util.dart';
import 'package:lark/util/navigator_util.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    var dataInfo = Provider.of<DataInfo>(context);
    if (dataInfo.user == null) {
      DioUtil.request("/v2/user").then((map) {
        User user = User.fromJson(map['data']);
        dataInfo.initUserInfo(user);
      });
    }
    return Drawer(
      child: ListView(children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            dataInfo.user?.name ?? '暂未登录',
            overflow: TextOverflow.ellipsis,
          ),
          accountEmail: Text(
            dataInfo.user?.description ?? '这个人很懒，什么都没有留下。',
            overflow: TextOverflow.ellipsis,
          ),
          currentAccountPicture: GestureDetector(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  dataInfo.user?.avatarUrl ?? ConstURL.defaultLogo),
            ),
//            onTap: () => login(dataInfo),
          ),
//          onDetailsPressed: () => print('hello world'),
        ),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          ListTile(
            leading: const Icon(Icons.explore),
            title: const Text('发现'),
            selected: true,
            onTap: () {
              NavigatorUtil.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.grey),
            title: const Text('我的'),
            onTap: () => NavigatorUtil.popAndPushNamed(
                context, '${Routes.myBook}?userId=${dataInfo.user.id}'),
          ),
          ListTile(
            leading: const Icon(Icons.folder, color: Colors.grey),
            title: const Text('协作'),
            onTap: () => NavigatorUtil.popAndPushNamed(
                context, '${Routes.group}?userId=${dataInfo.user.id}'),
          ),
          ListTile(
            leading: const Icon(Icons.hourglass_full, color: Colors.grey),
            title: const Text('历史'),
            onTap: () => NavigatorUtil.popAndPushNamed(context, Routes.history),
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.grey),
            title: const Text('通知'),
            onTap: () => BotToast.showText(text: "敬请期待"),
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.grey),
            title: const Text('收藏'),
            onTap: () => BotToast.showText(text: "敬请期待"),
          ),
          ListTile(
            leading: const Icon(Icons.visibility, color: Colors.grey),
            title: const Text('关注'),
            onTap: () => BotToast.showText(text: "敬请期待"),
          ),
          Divider(),
          SwitchListTile(
            title: Text(
              '夜间',
              style:
                  TextStyle(color: dataInfo.dark ? Colors.white : Colors.black),
            ),
            value: dataInfo.dark,
            secondary: const Icon(Icons.brightness_2, color: Colors.grey),
            onChanged: (bool value) {
              dataInfo.changeTheme();
              NavigatorUtil.pop(context);
            },
          ),
//          ListTile(
//            leading: const Icon(Icons.exit_to_app, color: Colors.grey),
//            title: const Text('退出'),
//            onTap: () {
//              dataInfo.logout();
//            },
//          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.grey),
            title: const Text('关于'),
            onTap: () {
              NavigatorUtil.popAndPushNamed(context, Routes.about);
            },
          )
        ]),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
