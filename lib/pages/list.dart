import 'package:fasttestui/common/globals.dart';
import 'package:fasttestui/common/styles.dart';
import 'package:fasttestui/models/post.dart';
import 'package:flutter/material.dart';
import 'package:simple_api/simple_api.dart';

import 'details.dart';
import 'form.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<Post>> postsF;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    postsF = SimpleAPI.getList<Post>(Globals.apiURL + "/posts",
        rootPath: "posts", fromJson: Post.fromJsonStatic);
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
        title: Text("List"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: FutureBuilder<List<Post>>(
            future: postsF,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Styles.errorText(snapshot.error.toString());
              }
              if (!snapshot.hasData) {
                return Styles.waiting();
              }
              var posts = snapshot.data;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  var p = posts[index];
                  return ListTile(
                    title: Text(p.title),
                    onTap: () {
                      Navigator.pushNamed(context, '/details/' + p.id);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DetailsPage(post:posts[index])),
                      // );
                    },
                    trailing:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Text("${(p.votes ?? '0')}"),
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        tooltip: 'Upvote',
                        onPressed: () async {
                          try {
                            await SimpleAPI.post(
                                Globals.apiURL + "/posts/" + p.id + "/vote",
                                body: {"count": 1});
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: new Text("Voted"),
                            ));
                            setState(() {
                              refresh();
                            });
                          } catch (err) {
                            print("ERROR!");
                            print(err.toString());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: new Text(err.toString()),
                              backgroundColor: Colors.red,
                            ));
                            throw err;
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        tooltip: 'Delete',
                        onPressed: () async {
                          try {
                            await SimpleAPI.delete(
                                Globals.apiURL + "/posts/" + p.id);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: new Text("Deleted"),
                            ));
                            setState(() {
                              refresh();
                            });
                          } catch (err) {
                            print("ERROR!");
                            print(err.toString());
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: new Text(err.toString()),
                              backgroundColor: Colors.red,
                            ));
                            throw err;
                          }
                        },
                      ),
                    ]),
                  );
                },
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                // children: <Widget>[
                //   ListTile(
                //     title: Text(posts[0].title),
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => DetailsPage(posts[0])),
                //       );
                //     },
                //   ),
                // ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/form');
        },
        tooltip: 'New Post',
        child: Icon(Icons.add),
      ),
    );
  }
}
