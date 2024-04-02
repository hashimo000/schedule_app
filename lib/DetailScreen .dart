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


    // 欠席回数のローカル状態を管理するためのStateProviderを作成
    final localCounter = StateProvider<int>((ref) => cellData.counter);

    return Scaffold(
      appBar: AppBar(title: const Text('授業詳細')
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
                inputFormatters: [LengthLimitingTextInputFormatter(12)],
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
                   ?() {
                  // 保存ボタンを押したときに、ローカル状態をグローバル状態に反映
                  final updatedData = TimetableCellData(
                    counter: ref.read(localCounter),
                    classname: textEditingController.text,
                  );
                  ref.read(timetableDataProvider.notifier).updateCellData(widget.cellIndex, updatedData);
                  Navigator.pop(context);
                } 
                : null,
                child: const Text('保存'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(timetableDataProvider.notifier).resetCellData(widget.cellIndex);
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
