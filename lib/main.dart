import 'package:schedule/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:schedule/inquiries.dart';
import 'package:schedule/database.dart';
void main() {
   WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase(openConnection());
  runApp( ProviderScope(
    child: MyApp(database: database)
    
  ));
}
final bottomIndexProvider = StateProvider<int>((ref) => 0);
class Root extends ConsumerWidget {
   
  const Root({super.key, required this.database});
final AppDatabase database; 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // bottomIndexProviderを監視して、その値を取得します。
    final bottomIndex = ref.watch(bottomIndexProvider);

    // BottomNavigationBarItemのリストを定義します。
    // ここでは「ホーム」と「その他」の2つのアイテムを作成しています。
    final items = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'ホーム',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.question_answer),
        label: 'お問い合わせ',
        
      ),
    ];

    // BottomNavigationBarを定義します。
    // `currentIndex`には`bottomIndex`の値を、`onTap`にはタップされた時の処理を定義しています。
    final bar = BottomNavigationBar(
      items: items,
      currentIndex: bottomIndex,
      backgroundColor: Color.fromARGB(255, 246, 108, 2), 
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.5),
      onTap: (index){
        // bottomIndexProviderの値を更新します。
        ref.read(bottomIndexProvider.notifier).state=index;
      },
    );
    final pages =[
      MyHomePage(database: database),
      InquiriesPage(),
    ];

    // Scaffoldウィジェットを使用して、BottomNavigationBarを画面下部に配置します。
    // 通常、BottomNavigationBarはScaffoldのレイアウトの一部として使用されます。
    return Scaffold(
      body:pages[bottomIndex],
      bottomNavigationBar: bar,
    );
  }
}

class MyApp extends ConsumerWidget {
  final AppDatabase database;

  const MyApp({super.key , required this.database});
  @override
  Widget build(BuildContext context, WidgetRef ref) {    
    return MaterialApp( 
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: 
       Root(database: database),
    );
  }
}

