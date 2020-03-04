import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: createListView(),
    );
  }
  
  createListView(){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("posts").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
        if (snapShot.hasError) {
          return new Text("Error: ${snapShot.error}");
        }
        switch (snapShot.connectionState) {
          case ConnectionState.waiting: return new Text("Loading");
          default: 
          return getPosts(snapShot);
        }
      }
    );
  }

  String dateToString(Timestamp dateTime)  {
    initializeDateFormatting("ja_JP");

    var formatter = new DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP");
    var formatted = formatter.format(dateTime.toDate()); // DateからString
    return formatted.toString();
  }
  
  getPosts(AsyncSnapshot<QuerySnapshot> snapShot) {
    List<Widget> listPosts = <Widget>[];
    List<DocumentSnapshot> posts = snapShot.data.documents;

    posts.sort((a, b) => a["date"].compareTo(b["date"]));

    listPosts = posts.map((DocumentSnapshot document) {
      return new Material(
        child: ListTile(
          title: new Text(
            document["title"],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: new Text(dateToString(document["date"])),
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (_) => PostDetailPage(document: document),
              )
            );
          },
        )
      );
    }).toList();

    return new ListView(
      children: listPosts
    );
  }
}

class PostDetailPage extends StatefulWidget {
  final DocumentSnapshot document;

  PostDetailPage({@required this.document});

  @override
  _PostDetailPageState createState() => _PostDetailPageState(document: document);
}

class _PostDetailPageState extends State<PostDetailPage> {
  final DocumentSnapshot document;

  _PostDetailPageState({
    @required this.document
  });
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(document["title"]),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.blue,
                padding: EdgeInsets.all(10),
                child: Text(
                  document["title"],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  document["author"],
                ),
              ),
              Container(
                color: Colors.blue,
                padding: EdgeInsets.all(10),
                child: Text(
                  document["content"],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}