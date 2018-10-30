import 'package:flutter/material.dart'; // material 디자인이 적용된 컴포너트 패키지

// part 1 수행을 위한 패키지 리스트
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 앱 전체에 대한 title 만 지정
    return new MaterialApp(
      title: 'Startup Name Generator',
      home: new RandomWords(),
    );
  }
}

// Randomwords 클래스의 state를 관리할 State 클래스
class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[]; // 단어 쌍 저장 배열
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0); // 폰트 사이즈
  final Set<WordPair> _saved = new Set<WordPair>(); // 즐겨찾기 단어 쌍

  // State 클래스에 대한 초기화 이후 호출됨.
  @override
  Widget build(BuildContext context) {
    // 기본 material design 클래스
    // drawer, snack bar, bottom sheet 을 제공함
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    // lazy 생성을 사용하는 ListView
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          // 단어 쌍을 한줄 출력하고, 다음 줄은 구분 bar를 그린다.
          return new Divider();
        }
        final int index = i ~/ 2; // 몫의 정수 부분만 return

        // 현재 보여주는 리스트의 끝에 도달한 경우
        if (index >= _suggestions.length) {
          // 새로운 워드 10쌍을 리스트에 추가 한다
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont, 
      ),
      trailing: new Icon(
        alreadySaved? Icons.favorite : Icons.favorite_border,
        color: alreadySaved? Colors.red : null,
      ),
    );
  }
}

// State class 인스턴스를 생성하는데 사용되는 StatefulWidget 클래스
/* 
  StatefulWidget 클래스를 생성하면 자동적으로 createState() 메소드를 호출하게 된다. 
*/
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}