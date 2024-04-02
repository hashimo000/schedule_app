import 'package:schedule/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  runApp(const ProviderScope(
    child: MyApp()
  ));
}
class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return MaterialApp(
      theme: ThemeData(
 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

