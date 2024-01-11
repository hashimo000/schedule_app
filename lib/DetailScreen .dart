import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';// 入力制限用
// Counterの状態を管理するStateNotifier
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}
class TimetableCellData {
  int counter;
  String classname;
  TimetableCellData({this.counter = 0, this.classname = ''});
}
// ClassNameの状態を管理するStateNotifier
class ClassNameNotifier extends StateNotifier<String> {
  // コンストラクタで初期状態を設定
  ClassNameNotifier() : super('初期値');

  // 状態を更新するメソッド
  void updateText(String newText) {
    state = newText; //状態を更新
     }
}
class TimetableDataNotifier extends StateNotifier<List<TimetableCellData>> {
  TimetableDataNotifier() : super(List.generate(56, (_) => TimetableCellData())); // 8行7列のグリッドの場合

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



// CounterNotifierを提供するProvider
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
// ClassNameNotifierを提供するProvider
final classnameProvider = StateNotifierProvider<ClassNameNotifier, String>((ref) {
  return ClassNameNotifier();
});

final timetableDataProvider = StateNotifierProvider<TimetableDataNotifier, List<TimetableCellData>>((ref) {
  return TimetableDataNotifier();
});

// DetailScreenクラス内の変更点
class DetailScreen extends ConsumerWidget {
  final int cellIndex;
  final TextEditingController textEditingController = TextEditingController();
   DetailScreen({Key? key, required this.cellIndex}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
      // StateNotifierからセルのデータを取得
    final cellData = ref.watch(timetableDataProvider.select((state) => state[cellIndex]));

    // TextFieldに初期値を設定
    textEditingController.text = cellData.classname;

    return Scaffold(
      appBar: AppBar(title: const Text('授業の追加情報'),
      actions: <Widget>[
          TextButton(
          onPressed: () {
           final updatedData = TimetableCellData(
           counter: cellData.counter,
           classname: textEditingController.text,
        );
        ref.read(timetableDataProvider.notifier).updateCellData(cellIndex, updatedData);
        Navigator.pop(context);
      },
      child: const Text('保存',style: TextStyle(
      fontSize: 20, 
       ),),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // テキストの色
        
      ),
    ),
  ],
              ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: textEditingController..text = cellData.classname,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "授業名"),
                inputFormatters: [
                LengthLimitingTextInputFormatter(12),
              ],
              ),
              ElevatedButton(
                onPressed: () {
                  final updatedData = TimetableCellData(
                    counter: cellData.counter,
                    classname: textEditingController.text,
                  );
                  ref.read(timetableDataProvider.notifier).updateCellData(cellIndex, updatedData);
                  Navigator.pop(context);
                },
                child: const Text('保存'),
              ),
              Text(
                '欠席回数: ${cellData.counter}',
                style: TextStyle(fontSize: 24),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      // セルデータのカウンターをインクリメント
                      final updatedData = TimetableCellData(
                        counter: cellData.counter + 1,
                        classname: cellData.classname,
                      );
                      ref.watch(timetableDataProvider.notifier).updateCellData(cellIndex, updatedData);
                    },
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      // セルデータのカウンターをデクリメント
                      final updatedData = TimetableCellData(
                        counter: cellData.counter > 0 ? cellData.counter - 1 : 0,
                        classname: cellData.classname,
                      );
                      ref.watch(timetableDataProvider.notifier).updateCellData(cellIndex, updatedData);
                    },
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      
                      // セルデータのカウンターをリセット
                      final updatedData = TimetableCellData(
                        counter: 0,
                        classname: cellData.classname,
                      );
                      ref.watch(timetableDataProvider.notifier).updateCellData(cellIndex, updatedData);
                    },
                    child: Icon(Icons.refresh),
                  ),
                ],
              ),
              ElevatedButton(
                 onPressed: () {
                 // セルデータをリセット
                 ref.read(timetableDataProvider.notifier).resetCellData(cellIndex);
                 Navigator.pop(context);
                  },
                  child: const Text('削除'),
                  style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.red, // ボタンの背景色を赤に設定
                 ),
                 ),
            ],
          ),
        ),
      ),
    );
  }
}