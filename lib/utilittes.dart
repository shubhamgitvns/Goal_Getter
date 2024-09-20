

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Googel_Signin{
  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  static GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: scopes,
  );
  static GoogleSignInAccount? currentUser;
  static bool isAuthorized = false;
  static bool check = isAuthorized =  Googel_Signin.googleSignIn.requestScopes(scopes) as bool;

// FUNCTIONS()
// the purpose of this fun to login throw the whose g mail.
  static Future<void> handleSignIn() async {
    try {
      await Googel_Signin.googleSignIn.signIn();
      print('Point 2 _googleSignIn.signIn();');
    } catch (error) {
      print('Point 3 Error start();');
      print(error);
      print('Point 4 Error done();');
    }
  }
// the purpose of this fun check user login or not.
  static Future<void> login() async{

    Googel_Signin.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {

      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await Googel_Signin.googleSignIn.canAccessScopes(scopes);
      }
      Googel_Signin.currentUser = account;
      Googel_Signin.isAuthorized= isAuthorized;

      // if (isAuthorized) {
      //   unawaited(_handleGetContact(account!));
      // }

    });

    Googel_Signin.googleSignIn.signInSilently();

  }

}