import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          return new ListView(
            children: snapShot.data.documents.map((DocumentSnapshot document) {
              return new Material(
                child: ListTile(
                  title: new Text(document["title"]),
                  subtitle: new Text(document["author"]),
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (_) => PostDetailPage(),
                      )
                    );
                  },
                )
              );
            }).toList()
          );
        }
      }
    );
  }

  /*Future getDocuments(String collection) async {
  return await Firestore.instance.collection(collection).getDocuments();
  }*/
}

class PostDetailPage extends StatefulWidget {
  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("title"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: Text("title"),
            ),
            Container(
              child: Text("autor"),
            ),
            Container(
              child: Text("content"),
            ),
          ],
        ),
      ),
    );
  }
}