import 'package:flutter/material.dart';

class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.mood_bad, color: Colors.teal),
          Text(
            '  你来这走了一遭，这里荒芜寸草不生',
            style: TextStyle(color: Colors.teal),
          )
        ],
      )),
    );
  }
}
