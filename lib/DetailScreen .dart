import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Counterの状態を管理するStateNotifier
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
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

// CounterNotifierを提供するProvider
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});
// ClassNameNotifierを提供するProvider
final classnameProvider = StateNotifierProvider<ClassNameNotifier, String>((ref) {
  return ClassNameNotifier();
});
// DetailScreenクラス内の変更点
class DetailScreen extends ConsumerWidget {
  final TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    final classname = ref.watch(classnameProvider); //状態を可視化
    return Scaffold(
      appBar: AppBar(
        title: const Text('授業の追加情報'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: textEditingController,//TextFieldの中身をtextEditingControllerで管理
                decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  labelText:"授業名"
                ),
                   
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(classnameProvider.notifier).updateText(textEditingController.text);//ボタン押すとtextEditingControllerの中身をclassnameProviderで管理
                  Navigator.pop(context);
                },
                child: const Text('保存'),
              ),
              Text(
                '欠席回数: $counter',
                style: TextStyle(fontSize: 24),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () => ref.read(counterProvider.notifier).increment(),
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: () => ref.read(counterProvider.notifier).decrement(),
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: () => ref.read(counterProvider.notifier).reset(),
                    child: Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
