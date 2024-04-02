import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';// 入力制限用
class TimetableCellData {
  int counter;
  String classname;
  TimetableCellData({this.counter = 0, this.classname = ''});
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
    final cellData = ref.watch(timetableDataProvider.select((state) => state[cellIndex]));
    textEditingController.text = cellData.classname; // 初期値を設定

    // 欠席回数のローカル状態を管理するためのStateProviderを作成
    final localCounter = StateProvider<int>((ref) => cellData.counter);

    return Scaffold(
      appBar: AppBar(title: const Text('授業の追加情報')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "授業名"),
                inputFormatters: [LengthLimitingTextInputFormatter(12)],
              ),
              Consumer(
                builder: (context, ref, _) {
                  // 欠席回数のローカル状態を表示
                  final counter = ref.watch(localCounter);
                  return Text('欠席回数: $counter', style: TextStyle(fontSize: 24));
                },
              ),
              // 以下のRowとFloatingActionButtonは、ローカル状態のカウンターを更新するように変更
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () { 
                     ref.read(localCounter.notifier).update((state) => state + 1);
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
                onPressed: () {
                  // 保存ボタンを押したときに、ローカル状態をグローバル状態に反映
                  final updatedData = TimetableCellData(
                    counter: ref.read(localCounter),
                    classname: textEditingController.text,
                  );
                  ref.read(timetableDataProvider.notifier).updateCellData(cellIndex, updatedData);
                  Navigator.pop(context);
                },
                child: const Text('保存'),
              ),
              // 削除ボタンはそのまま
              ElevatedButton(
                onPressed: () {
                  ref.read(timetableDataProvider.notifier).resetCellData(cellIndex);
                  Navigator.pop(context);
                },
                child: const Text('削除'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
