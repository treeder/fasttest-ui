import 'package:flutter/material.dart';

import 'globals.dart';

class Styles {
  static TextStyle error = TextStyle(color: Colors.red);
  static TextStyle success = TextStyle(color: Colors.green);
  static TextStyle successBig = TextStyle(color: Colors.green, fontSize: 20);

  static Widget errorText(String msg) {
    return Text(msg, style: Styles.error);
  }

  static errorSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: new Text(msg),
      backgroundColor: Colors.red,
    ));
  }

  // static Widget userAvatar() {
  //   return avatar(
  //       Globals.currentUser().displayName, Globals.currentUser().photoURL);
  // }

  static Widget avatar(String name, String photoUrl) {
    // print("AVATAR");
    // print(name);
    // print(photoUrl);
    // return GoogleUserCircleAvatar(identity: Globals.???);
    if (photoUrl != null && photoUrl != "") {
      // if profile pic exists, use
      return CircleAvatar(
        // radius: 30,
        backgroundImage: NetworkImage(photoUrl),
      );
    } else {
      return CircleAvatar(
        // radius: 30,
        backgroundColor: Colors.grey[400],
        child: Text(userInitials(name)),
      );
    }
  }

  static String userInitials(String name) {
    var split = name.split(" ");
    String r = split[0][0];
    if (split.length > 1) {
      r += split[1][0];
    }
    return r;
  }

  // @deprecated use waiting()
  static Widget waitingIndicator() {
    return waiting();
  }

  static Widget waiting() {
    return SizedBox(width: 40, height: 40, child: CircularProgressIndicator());
  }

  static Widget link(String text, String url) {
    return InkWell(
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue,
          // fontSize: 12,
        ),
      ),
      // onTap: () => launch(url),
    );
  }
}
