import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String _title = 'Widgets testing';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _textColor = Colors.blueGrey;
  Color _circleColor = Colors.white;
  String _memeLink =
      'https://sun9-18.userapi.com/impg/bqtr8dz7Eb2MTTCWRWn32mEEinxcPDBA_7sPsg/8YeD-_-pC_U.jpg?size=1354x1500&quality=95&sign=fff5ef1085c679193dd04ccdbf834d78&type=album';

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter % 13 == 0) {
        _textColor = Colors.blue;
        _circleColor = Colors.red;
      } else if (_counter % 23 == 0) {
        _textColor = Colors.blueGrey;
        _circleColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        leading: const Placeholder(),
        centerTitle: true,
        foregroundColor: Colors.indigo,
        backgroundColor: Colors.blue,
        toolbarHeight: 70,
      ),
      backgroundColor: Colors.yellow,
      body: SelectionArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _circleColor,
              ),
              child: FlutterLogo(
                style: FlutterLogoStyle.horizontal,
                curve: Curves.bounceInOut,
                duration: const Duration(seconds: 5),
                textColor: _textColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'You have pushed the increasing button this as many times as possible:',
              selectionColor: Color.fromRGBO(100, 255, 255, 0.3),
              style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontFamily: 'sant-serif',
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SelectionContainer.disabled(
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.ads_click,
                size: 40,
                color: Colors.red,
                semanticLabel: 'Icon increase click',
              ),
              iconSize: 50,
              tooltip: 'Click this!!!',
              onPressed: _incrementCounter,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(
                  image: NetworkImage(
                    _memeLink,
                  ),
                  width: 200,
                  height: 140,
                  semanticLabel: "",
                  fit: BoxFit.fill,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Когда увлёкся поиском'),
                      const Text('мемов для вставки в Image'),
                      const Text('но осознал, что через 5 минут'),
                      const Text('митинг с Артёмом:'),
                      Image.network(
                        'https://media.tenor.com/aA6JL-Un2h4AAAAC/gachi-billy-herrington.gif',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => setState(() => _memeLink =
                  'https://media.tenor.com/aBs-tJmtyQAAAAAM/gachimuchi-billy-herrington.gif'),
              child: const SelectionContainer.disabled(
                  child: Text('Don\'t click!!!')),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
