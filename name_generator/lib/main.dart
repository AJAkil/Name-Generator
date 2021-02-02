import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to flutter',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordState createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWords> {
  final List<WordPair> _names = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Names for Fun'),
        centerTitle: true,
      ),
      body: _buildNames(),
    );
  }

  Widget _buildNames() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        // if i is odd, then generate a divider widget
        if (i.isOdd) {
          return Divider();
        }

        // if i is even then generate a ListTile Row
        // with a word pair
        // i ~/ 2 calculates the actual index of the
        // word pairs in the list of word pairs, leaving out the dividers
        final int index = i ~/ 2;

        // if the index crosses the size of the generated word list, then add 10 more
        if (index >= _names.length) {
          _names.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_names[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asCamelCase,
        style: _biggerFont,
      ),
    );
  }
}
