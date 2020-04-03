import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lark/common/const_url.dart';
import 'package:lark/routers/routes.dart';
import 'package:lark/util/navigator_util.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String appName = "云雀";
  String version = "V0.1.6 Beta";
  String androidAppId = 'cn.oever.lark';
  String iOSAppId = '';

  feedback() async {
    const url = 'mailto:ryu@oever.cn?subject=云雀·反馈';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      BotToast.showText(text: '遇到了问题...');
    }
  }

  openSource() async {
    const url = 'https://github.com/Veneris/Lark';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      BotToast.showText(text: '遇到了问题...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                children: <Widget>[
                  Container(
                      height: 60.0,
                      width: 60.0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(ConstURL.defaultLogo),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(7.5),
                    child: Column(
                      children: <Widget>[
                        Text(
                          appName,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(version),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(7.5, 15, 7.5, 0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.favorite_border),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        '鼓励一下',
                      ),
                      onTap: () {
                        OpenAppstore.launch(
                            androidAppId: androidAppId, iOSAppId: iOSAppId);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.update),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        '更新计划',
                      ),
                      onTap: () => NavigatorUtil.jump(
                          context, '${Routes.aboutUs}?slug=todo'),
                    ),
                    ListTile(
                      leading: Icon(Icons.open_in_new),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        '开放源码',
                      ),
                      onTap: () => openSource(),
                    ),
                    ListTile(
                      leading: Icon(Icons.code),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        '开源许可',
                      ),
                      onTap: () => NavigatorUtil.jump(
                          context, '${Routes.aboutUs}?slug=license'),
                    ),
                    ListTile(
                      leading: Icon(Icons.help_outline),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        '建议反馈',
                      ),
                      onTap: () => feedback(),
                    ),
                    ListTile(
                      leading: Icon(Icons.info_outline),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(
                        '关于我们',
                      ),
                      onTap: () => NavigatorUtil.jump(
                          context, '${Routes.aboutUs}?slug=about'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('使用'),
                  FlutterLogo(size: 16.0),
                  Text('Flutter技术构建'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(7.5),
                child: Text(
                  'Copyright @ 2020 Veneris.All Rights Reserved',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
