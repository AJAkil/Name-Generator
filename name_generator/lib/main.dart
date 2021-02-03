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
  final _saved = Set<WordPair>(); // a set for saving the favorite word pairs
  final List<WordPair> _names = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Names for Fun'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
        ],
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
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asCamelCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          alreadySaved ? _saved.remove(pair) : _saved.add(pair);
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(

        builder: (BuildContext context) {

          final tiles = _saved.map((WordPair pair) {
            return ListTile(
              title: Text(
                pair.asCamelCase,
                style: _biggerFont,
              ),
            );
          });

          // this ListTile.dividedTiles create a divided tiles automatically.
          final dividedTiles = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
              centerTitle: true,
            ),
            body: ListView(children: dividedTiles),
          );
        },
      ),
    );
  }
}

