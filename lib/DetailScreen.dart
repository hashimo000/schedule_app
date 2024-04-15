import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';// 入力制限用
import 'package:schedule/database.dart';


class EVENTS {
  final int id;
  String classname;
  int absenceCount;
  int row;
  int column;

  EVENTS({
    required this.id,
    required this.classname,
    required this.absenceCount,
    required this.row,
    required this.column,
  });
}

class TimetableCellData {
  int counter;
  String classname;
  TimetableCellData({this.counter = 0, this.classname = '',});
}
class TimetableDataNotifier extends StateNotifier<List<TimetableCellData>> {
  final Ref ref; // RiverpodのRefを追加

  TimetableDataNotifier(this.ref) : super(List.generate(56, (_) => TimetableCellData())) {
    _loadData(); // コンストラクタでデータ読み込みを呼び出す
  }

  Future<void> _loadData() async {
    final database = ref.read(appDatabaseProvider);
  final events = await database.allEvents;
  // イベントをTimetableCellDataのリストに変換してstateに設定
  state = List.generate(56, (_) => TimetableCellData()); // 56はグリッドの総セル数
  for (var event in events) {
    int index = event.row * 7 + event.column; // 7は列数
    state[index] = TimetableCellData(classname: event.className, counter: event.absenceCount);
  }
    print('データベースから取得したイベント: $events'); // 取得したデータをコンソールに出力

  }
    void updateCellData(int index, TimetableCellData data) {
    state = [
      ...state.sublist(0, index),
      data,
      ...state.sublist(index + 1),
    ];
  }
  void resetCellData(int index) {
  state = [
    ...state.sublist(0, index),
    TimetableCellData(), // 初期化されたTimetableCellDataオブジェクト
    ...state.sublist(index + 1),
  ];
}
}
final timetableDataProvider = StateNotifierProvider<TimetableDataNotifier, List<TimetableCellData>>((ref) {
  return TimetableDataNotifier(ref);
});

class DetailScreen extends ConsumerStatefulWidget {
  final int cellIndex;
  DetailScreen({Key? key, required this.cellIndex}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  late TextEditingController textEditingController;

 @override
@override
void initState() {
  super.initState();
  final cellData = ref.read(timetableDataProvider.select((state) => state[widget.cellIndex]));
  textEditingController = TextEditingController(text: cellData.classname);

  // テキストフィールドの変更を検知するリスナーを追加
  textEditingController.addListener(() {
    setState(() {
    });
  });
}

@override
void dispose() {
  textEditingController.removeListener(() {});
  textEditingController.dispose();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    final cellData = ref.watch(timetableDataProvider.select((state) => state[widget.cellIndex]));
     final database = ref.watch(appDatabaseProvider);

    // 欠席回数のローカル状態を管理するためのStateProviderを作成
    final localCounter = StateProvider<int>((ref) => cellData.counter);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '授業詳細',
          style: TextStyle(
      fontSize: 20, // フォントサイズを20に設定
      fontWeight: FontWeight.bold, // フォントを太く設定
    ),),
    backgroundColor: Color.fromARGB(255, 246, 108, 2),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "授業名"),
                inputFormatters: [LengthLimitingTextInputFormatter(9)],
              ),
              Consumer(
                builder: (context, ref, _) {
                  // 欠席回数のローカル状態を表示
                  final counter = ref.watch(localCounter);
                  return Text('欠席回数: $counter', style: TextStyle(fontSize: 24));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () { 
                     ref.read(localCounter.notifier).update((state) => state < 5 ? state + 1 : 5);
                    },
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
                    ref.read(localCounter.notifier).update((state) => state > 0 ? state - 1 : 0);
                   },
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: "btn3",
                    onPressed: () {
                     ref.read(localCounter.notifier).update((state) => 0);
                    },
                    child: Icon(Icons.refresh),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: textEditingController.text.isNotEmpty
                   ?() async{
                  // 保存ボタンを押したときに、ローカル状態をグローバル状態に反映
                  final updatedData = TimetableCellData(
                    counter: ref.read(localCounter),
                    classname: textEditingController.text,
                  );
                  ref.read(timetableDataProvider.notifier).updateCellData(widget.cellIndex, updatedData);
                      // データベースに追加
                  await database.addEvent(updatedData.classname, updatedData.counter, widget.cellIndex ~/ 7, widget.cellIndex % 7);
                  Navigator.pop(context);
                } 
                : null,
                child: Text(
                  '保存',
                  style: TextStyle(
                  fontWeight: FontWeight.bold,  // フォントを太くする
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(timetableDataProvider.notifier).resetCellData(widget.cellIndex);
                  Navigator.pop(context);
                },
                child: Text(
                '削除',
                 style: TextStyle(
                 fontWeight: FontWeight.bold,  // フォントを太くする
               ),
              ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
