import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InquiriesPage extends StatelessWidget {
  final Uri url = Uri.parse('https://forms.gle/tkctwq5irnBUKcNz7'); 

  InquiriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('その他'),
        backgroundColor: Color.fromARGB(255, 246, 108, 2), 
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
