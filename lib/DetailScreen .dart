import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Counterの状態を管理するStateNotifier
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}

// CounterNotifierを提供するProvider
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

// DetailScreenクラス内の変更点
class DetailScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
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
                decoration: InputDecoration(
                  border:OutlineInputBorder(),
                  labelText:"授業名"
                ),
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
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: () => ref.read(counterProvider.notifier).decrement(),
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: () => ref.read(counterProvider.notifier).reset(),
                    tooltip: 'Reset',
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
