import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'common/globals.dart';
import 'common/styles.dart';

class SignIn extends StatelessWidget {
  final String fireClientID;
  final bool showApple;

  final Function signedInCallback;

  SignIn(
      {@required this.fireClientID,
      @required this.signedInCallback,
      this.showApple = true});

  @override
  Widget build(BuildContext context) {
    // print("beta? ${Globals.remoteConfig.getBool('beta_user')}");
    return Center(
        child: Column(children: [
      Container(
        constraints: BoxConstraints(
          minWidth: 350,
          maxWidth: 400,
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Builder(
              // Create an inner BuildContext so that the onPressed methods
              // can refer to the Scaffold with Scaffold.of().
              builder: (BuildContext context) {
            return Column(children: [
              Container(
                child: Text("Please Sign In"),
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                height: 36,
                child: SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () {
                    _handleSignIn(context);
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (showApple)
                SizedBox(
                  height: 36,
                  child: SignInButton(
                    Buttons.AppleDark,
                    onPressed: () {
                      _handleSignInApple(context);
                    },
                  ),
                ),
            ]);
          }),
        ),
      ),
    ]));
  }

  void _handleSignIn(BuildContext context) async {
    auth.User user;
    try {
      // GoogleSignInAccount googleUser = await Globals.googleSignIn().signIn();
      // user = await Globals.initUserGoogle(googleUser);
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      // googleProvider
      //     .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Once signed in, return the UserCredential
      UserCredential uc =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
      print("USER");
      print(uc.user);
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: new Text(err.toString()),
        backgroundColor: Colors.red,
      ));
      throw err;
    }
    signedInCallback(context, user);
  }

  void _handleSignInApple(BuildContext context) async {
    auth.User user;
    try {
      auth.User user = await FirebaseAuthOAuth()
          .openSignInFlow("apple.com", ["name", "email"], {"locale": "en"});
      // Globals.initUser2(user);
      print("APPLE USER");
      print(user);
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: new Text(err.toString()),
        backgroundColor: Colors.red,
      ));
      throw err;
    }
    signedInCallback(context, user);
  }
}
