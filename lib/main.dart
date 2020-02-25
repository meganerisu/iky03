import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPostsPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ListPostsPage extends StatefulWidget {
  ListPostsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPostsPagState createState() => _ListPostsPagState();
}

class _ListPostsPagState extends State<ListPostsPage> {
  final List<Widget> _posts = <Widget>[
    ListTile(
      leading: const Icon(Icons.star),
      title: const Text("first item"),
      subtitle: const Text("subtitle"),
    ),
    ListTile(
      leading: const Icon(Icons.favorite),
      title: const Text("second item"),
      /*selected: _index == 2,
      onTap: () {
        _index = 2;
        tapTile();
      },*/
    ),
    ListTile(
      leading: const Icon(Icons.android),
      title: const Text("third item"),
      /*selected: _index == 3,
      onTap: () {
        _index = 2;
        tapTile();
      },*/
    ),
    ListTile(
      leading: const Icon(Icons.android),
      title: const Text("third item"),
    ),
    ListTile(
      leading: const Icon(Icons.android),
      title: const Text("third item"),
    ),
    ListTile(
      leading: const Icon(Icons.android),
      title: const Text("third item"),
    ),
    ListTile(
      leading: const Icon(Icons.android),
      title: const Text("third item"),
    ),
    ListTile(
      leading: const Icon(Icons.android),
      title: const Text("third item"),
    ),
    ListTile(
      leading: const Icon(Icons.android),
      title: const Text("third item"),
    ),
    ListTile(
      leading: const Icon(Icons.android),
      title: const Text("third item"),
    ),
    ListTile(
      leading: const Icon(Icons.android),
      title: const Text("third item"),
    ),
    ListTile(
      leading: const Icon(Icons.android),
      title: const Text("eleventh item"),
    ),
  ];
  String _message;
  int _index;

  @override
  void initState() {
    _message = "ok";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: _posts,

        /*children: <Widget>[
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text("first item"),
            selected: _index == 1,
            onTap: () {
              _index = 1;
              tapTile();
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text("second item"),
            selected: _index == 2,
            onTap: () {
              _index = 2;
              tapTile();
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text("third item"),
            selected: _index == 3,
            onTap: () {
              _index = 2;
              tapTile();
            },
          ),
        ],*/
      ),
    );
  }
  
  void tapTile() {
    setState(() {
      _message = "You tapped: No, $_index";
    });
  }
}
