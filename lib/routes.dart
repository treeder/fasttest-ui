import 'package:fasttestui/main.dart';
import 'package:fasttestui/pages/details.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'pages/form.dart';
import 'pages/list.dart';
import 'pages/signin.dart';

const String HomeRoute = '/';
const String AboutRoute = '/about';
const String EpisodesRoute = '/episodes';
const String EpisodeDetailsRoute = '/episode';

final router = FluroRouter();

class MyRouter {
  static init() {
    router.define("/list", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return ListPage();
    }));
    router.define("/details/:id", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return DetailsPage(id: params["id"][0]);
    }));
    router.define("/form", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return FormPage();
    }));
    router.define("/form/:id", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return FormPage(id: params["id"][0]);
    }));
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  var user = auth.FirebaseAuth.instance.currentUser;
  if (user == null) {
    return MaterialPageRoute(
        builder: (context) => SigninPage(),
        settings: RouteSettings(name: '/signin'));
  }
  switch (settings.name) {
    case '/':
      // todo: could redirect here if not authed
      if (user != null) {
        return MaterialPageRoute(
            builder: (context) => ListPage(),
            settings: RouteSettings(name: '/list'));
      }
      return MaterialPageRoute(
          builder: (context) => MyHomePage(title: "Test app"));
    case '/signin':
      return MaterialPageRoute(
          builder: (context) => SigninPage(),
          settings: RouteSettings(name: '/signin'));
    default:
      return router.generator(settings);
  }
}
