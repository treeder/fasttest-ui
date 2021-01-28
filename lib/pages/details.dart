import 'package:fasttestui/models/post.dart';
import 'package:flutter/material.dart';

import 'form.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  final Post post;
  DetailsPage({this.id, this.post, Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Post post;
  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      post = widget.post;
      return;
    }
    // get by ID
    post = posts[0];
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Details"),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
        children: [
          Text(post.title),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/form/' + widget.id);
        },
        tooltip: 'Edit',
        child: Icon(Icons.edit),
      ),
    );
  }
}
