import 'package:fasttestui/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'pages/SigninPage.dart';

const String HomeRoute = '/';
const String AboutRoute = '/about';
const String EpisodesRoute = '/episodes';
const String EpisodeDetailsRoute = '/episode';

Route<dynamic> generateRoute(RouteSettings settings) {
  var authed = auth.FirebaseAuth.instance.currentUser;
  switch (settings.name) {
    case '/':
      // todo: could redirect here if not authed
      return MaterialPageRoute(
          builder: (context) => MyHomePage(title: "Test app"));
    case '/signin':
      return MaterialPageRoute(builder: (context) => SigninPage());
    case '/browse':
      return MaterialPageRoute(
          builder: (context) => MyHomePage(title: "Browsing"));
    // default:
    //   return MaterialPageRoute(builder: (context) => MyHomePage());
  }
}
