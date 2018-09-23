import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:dotp/dotp.dart';

void main() => runApp(new MinaOTP());

class MinaOTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MinaOTP',
      theme: new ThemeData(
        primaryColor: Colors.black,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _titleFont = const TextStyle(fontSize: 18.0);
  final _codeFont = const TextStyle(fontSize: 24.0);

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_suggestions[index]);
      }
    );
  }

  Widget _buildRow(WordPair pair) {
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _titleFont,
      ),
      subtitle: new Text(
        pair.asLowerCase,
      ),
      trailing: new Text(
        '201826',
        style: _codeFont,
      ),
      onTap: _pushSaved,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('MinaOTP'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: _showModal,
          )
        ],
      ),
      body: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.orange,
          ),
          new Expanded(
            child: _buildSuggestions(),
          ),
        ],
      ),
    );
  }

  void _showModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.camera_alt),
              title: new Text('Scan'),
              onTap: () => {},
            ),
            new ListTile(
              leading: new Icon(Icons.create),
              title: new Text('Mannual'),
              onTap: _pushSaved,
            ),
          ]
        );
      }
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Edit'),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.done),
                  onPressed: _updateToken,
                )
              ],
            ),
            body: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Card(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        title: const Text('Service'),
                      ),
                      new TextField(
                        decoration: InputDecoration(
                          hintText: 'miaotp',
                        ),
                      ),
                    ]
                  )
                ),
                new Card(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        title: const Text('Account'),
                      ),
                      new TextField(
                        decoration: InputDecoration(
                          hintText: 'user@minaotp.com',
                        ),
                      ),
                    ]
                  )
                ),
                new Card(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        title: const Text('Key'),
                      ),
                      new TextField(
                        decoration: InputDecoration(
                          hintText: 'abcd efgh ijkl mnop',
                        ),
                      ),
                    ]
                  )
                ),
              ]
            )

          );
        },
      ),
    );
  }

  void _updateToken() {

  }
}