import 'package:google_sign_in/google_sign_in.dart';

const bool prod = const bool.fromEnvironment('dart.vm.product');

class Globals {
  static final String apiURL = "http://localhost:8080";

  // static final String _firebaseClientID = prod
  //     ? "175941894004-k4lnqpcb79stq71b3qq0qusecefgrdku.apps.googleusercontent.com"
  //     : "784629108141-agbrhunaetsra899ufja05h07sak3ql5.apps.googleusercontent.com";

  // static GoogleSignIn _googleSignIn;

  // static void init() {
  //   print("Globals.init");
  //   _googleSignIn = GoogleSignIn(
  //     clientId: _firebaseClientID,
  //     scopes: <String>[
  //       'email',
  //     ],
  //     // signInOption: SignInOption.standard,
  //   );
  //   // loadedF = _init();
  //   // analytics = FirebaseAnalytics();
  // }
}
