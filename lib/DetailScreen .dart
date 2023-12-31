import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('授業の追加情報'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Columnを中心に配置
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: '授業名',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8), // テキストフィールド間のスペース
              TextField(
                decoration: InputDecoration(
                  labelText: '教室',
                  border: OutlineInputBorder(),
                ),
              ),
              // 他にもTextFieldを追加可能
            ],
          ),
        ),
      ),
    );
  }
}
