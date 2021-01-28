import 'package:fasttestui/common/globals.dart';
import 'package:fasttestui/common/styles.dart';
import 'package:fasttestui/models/post.dart';
import 'package:flutter/material.dart';
import 'package:simple_api/simple_api.dart';

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
  Future<Post> postF;
  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      postF = Future.value(widget.post);
      return;
    }
    // get by ID
    print("ID: ${widget.id}");
    postF = SimpleAPI.get<Post>(Globals.apiURL + "/posts/" + widget.id,
        fromJson: Post.fromJsonStatic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Center(
        child: FutureBuilder<Post>(
            future: postF,
            builder: (context, snapshot) {
              print("in futurebuilder");
              if (snapshot.hasError) {
                return Styles.errorText(snapshot.error.toString());
              }
              if (!snapshot.hasData) {
                return Styles.waiting();
              }
              var post = snapshot.data;
              print("in build.builder");
              print(post);
              return Column(
                children: [
                  Text(post.title),
                ],
              );
            }),
      ),
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
