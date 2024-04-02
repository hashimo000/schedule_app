import 'package:flutter/material.dart';
import 'DetailScreen .dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimetableScreen(),
    );
  }
}

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  _TimetableScreenState createState() => _TimetableScreenState();
}
class _TimetableScreenState extends State<TimetableScreen> {


  @override
  Widget build(BuildContext context) {
  
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
                builder: (context) => DetailScreen(cellIndex: index, ),
              ),
            );
          },
          
           child: Consumer(builder: (context, ref, _) {
    final cellData = ref.watch(timetableDataProvider)[index];
    final int RestLife = 5 - cellData.counter; 

    // '❤️: $RestLife'のテキストの色をRestLifeの値に基づいて決定
    Color lifeTextColor = RestLife == 5 ? Colors.black :
                          RestLife == 4 ? Colors.blue : 
                          RestLife == 3 ? Colors.green : 
                          RestLife == 2 ? Color.fromARGB(255, 251, 190, 8) :
                          RestLife == 1 ? Colors.red :
                          RestLife == 0 ? Colors.red :
                          Colors.black; // デフォルト

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: <Widget>[
          Text(
            cellData.classname,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
              RestLife == 0 ? '落単' : '❤️: $RestLife',
            style: TextStyle(
              fontSize: 15,
              color: lifeTextColor, 
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }));
        }
        return Container(); // 空のコンテナまたは他の適切なウィジェットを返す
     },
    );
  }
}