import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('授業の追加情報'),
      ),
      body: const Center(
        child: TextField(),
      ),
    );
  }
}