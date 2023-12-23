import 'package:flutter/material.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body:  MyTimetableApp(),
    );
  }
}

class MyTimetableApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timetable App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimetableScreen(),
    );
  }
}

class TimetableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('時間割'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // 設定アイコンの動作をここに追加
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () {
              // ダウンロードアイコンの動作をここに追加
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // メニューアイコンの動作をここに追加
            },
          ),
        ],
      ),
      body: TimetableGrid(),
    );
  }
}

class TimetableGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int gridStateRows = 8; // 行数
    int gridStateColumns = 7; // 列数（曜日 + 時間列）

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridStateColumns,
        childAspectRatio: 3 / 2,
      ),
      itemCount: gridStateRows * gridStateColumns,
      itemBuilder: (context, index) {
        int x, y = 0;
        x = (index / gridStateColumns).floor();
        y = (index % gridStateColumns);

        if (x == 0) {
          // 曜日のヘッダーを生成
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                ['時', '月', '火', '水', '木', '金', '土'][y],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (y == 0) {
          // 時間のヘッダーを生成
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.black54,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  "${9 + x}:59", // 9時からの時間を表示
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        } else {
          // 通常のグリッドセルを生成
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Text(''),
            ),
          );
        }
      },
    );
  }
}
