import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class InquiriesPage extends StatelessWidget {
  final Uri url = Uri.parse('https://forms.gle/QyrNd6jFdikaPaLb7'); 
  final Uri url2 = Uri.parse('https://www.termsfeed.com/live/f268ae8b-64b3-4246-90f4-e2f644dd9cb5'); 

  InquiriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('その他'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(  
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 51.0),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, 
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () => _launchUrl(url), 
                          child: const Text('お問い合わせ'),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => _launchUrl(url2), 
                          child: const Text('プライバシーサポート'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'URLを開けませんでした: $url';
    }
  }
}
