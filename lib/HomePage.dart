import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
       title: '時間割アプリ',
      home: TimetableScreen(),
    );
  }
}


class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('私の時間'),
      ),
      body: Timetable(),
    );
  }
}

class Timetable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(title: Text('月曜日')),
        ListTile(title: Text('9:00 - 数学')),
        ListTile(title: Text('10:00 - 英語')),
        // 他の曜日や時間も同様に追加
      ],
    );
  }
}
