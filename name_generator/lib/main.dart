import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // an english word object
    final wordPair = WordPair.random();

    return MaterialApp(
      title: 'Welcome to flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('First Flutter App'),
        ),
        body: Center(
          child: Text(wordPair.asCamelCase),
        ),
      ),
    );
  }
}


