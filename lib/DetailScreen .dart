import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('授業詳細'),
      ),
      body: Center(
        child: Text('ここに授業の詳細情報を表示'),
      ),
    );
  }
}