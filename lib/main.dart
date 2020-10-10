import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'src/color_changer.dart';
import 'src/color_wtf.dart' as wtf;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: wtf.getRandomColor(),
        canvasColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = Set<WordPair>();
  double _hemuli = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          IconButton(icon: Icon(Icons.settings), onPressed: _showHemuliSlider),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );

          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            backgroundColor: getRandomColor(),
            appBar: AppBar(
              title: Text('Saved Suggestions'),
              backgroundColor: getRandomColor(),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  void _showHemuliSlider() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text('Hemuli ' + _hemuli.toInt().toString()),
                  backgroundColor: getRandomColor(),
                ),
                body: _buildSlider(setState));
          });
        },
      ),
    );
  }

  Widget _buildSlider(StateSetter _setState) {
    return Slider(
      divisions: 10,
      label: _hemuli.toString(),
      value: _hemuli,
      onChanged: (newValue) => _setState(() {
        _hemuli = newValue;
      }),
      onChangeEnd: (newValue) => _setState(() {
        _showHemuliSnackBar(newValue);
      }),
      min: 0.0,
      max: 20.0,
    );
  }

  void _showHemuliSnackBar(double _value) {
    print(_value);
    _scaffoldKey.currentState.showSnackBar(_createHemuliSnackBar(_value));
  }

  _createHemuliSnackBar(double _value) {
    return SnackBar(
      backgroundColor: Colors.cyan,
      duration: new Duration(milliseconds: 10),
      content: Text('Hemuli changed! ' + _value.toInt().toString()),
    );
  }
}
