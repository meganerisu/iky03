import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("posts").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
        if (snapShot.hasError) {
          return new Text("Error: ${snapShot.error}");
        }
        switch (snapShot.connectionState) {
          case ConnectionState.waiting: return new Text("Loading");
          default:
          return new ListView(
            children: snapShot.data.documents.map((DocumentSnapshot document) {
              return new Material(
                child: ListTile(
                  title: new Text(document["title"]),
                  subtitle: new Text(document["author"]),
                )
              );
            }).toList()
          );
        }
      }
    );


    /*return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: _posts,
      ),
    );*/
  }

  Future getDocuments(String collection) async {
  return await Firestore.instance.collection(collection).getDocuments();
  }
}
