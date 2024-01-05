import 'package:flutter/material.dart';
import 'DetailScreen .dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
       theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  TimetableScreen(),
    );
  }
}
class TimetableScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('時間割'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
             
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () {
           
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: TimetableGrid(),
    );
  }
}

class TimetableGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int gridStateRows = 8; // 行数
    int gridStateColumns = 7; // 列数（曜日 + 時間列）

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridStateColumns,
        childAspectRatio: 2/3,
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
                ['時間', '月', '火', '水', '木', '金', '土'][y],
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
                padding: const EdgeInsets.only(right: 17.0),
                child: Text(
                  "${0 + x}", //時間割 を表示
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        } if (x > 0 && y > 0) {
        // 通常のグリッドセルを生成
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(cellIndex: index),
              ),
            );
          },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
               child: Consumer(builder: (context, ref, _) {
              final cellData = ref.watch(timetableDataProvider)[index];
              return Column(
                children: <Widget>[
                  Text(cellData.classname),
                  Text('欠席: ${cellData.counter}', style: TextStyle(fontSize: 15)),
                ],
              );
            }
            ),
        ));
        }
      },
    );
  }
}
