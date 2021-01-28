import 'package:fasttestui/common/globals.dart';
import 'package:fasttestui/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:simple_api/simple_api.dart';

import '../models/post.dart';

class FormPage extends StatefulWidget {
  final String id;
  final Post post;
  FormPage({this.id, this.post, Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final myController = TextEditingController();
  String errMsg;
  bool waiting = false;

  Future<Post> postF;
  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      postF = Future.value(widget.post);
      return;
    } else if (widget.id != null) {
      // get by ID
      print("ID: ${widget.id}");
      postF = SimpleAPI.get<Post>(Globals.apiURL + "/posts/" + widget.id,
          fromJson: Post.fromJsonStatic);
    } else {
      postF = Future.value(Post());
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
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
        title: Text("Form"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
              myController.text = post.title;
              return Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    TextFormField(
                      controller: myController,
                      decoration: InputDecoration(labelText: 'Enter something'),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.

                          post.title = myController.text;
                          setState(() {
                            waiting = true;
                          });
                          try {
                            print("trying");
                            post = await SimpleAPI.post<Post>(
                                Globals.apiURL + "/posts",
                                body: post,
                                fromJson: Post.fromJsonStatic);
                            print("navigating");
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/details/' + post.id,
                                ModalRoute.withName('/list'));
                          } catch (err, stacktrace) {
                            print("caught error");
                            print(err);
                            print(stacktrace);
                            setState(() {
                              waiting = false;
                              errMsg = err.toString();
                            });
                          }
                        }
                      },
                      child: Text('Submit'),
                    ),
                    if (waiting) Styles.waiting(),
                    if (errMsg != null) Styles.errorText(errMsg),
                  ]));
            }),
      ),
    );
  }
}
