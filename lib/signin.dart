
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:todocreater/utilittes.dart';


const List<String> scopes =Googel_Signin.scopes;

//GoogleSignIn _googleSignIn = GoogleSignIn(
// Optional clientId
// clientId: 'your-client_id.apps.googleusercontent.com',
//scopes: scopes,
//);//transfer utilittes class
// #enddocregion Initialize


class SignInDemo extends StatefulWidget {
  ///
  const SignInDemo({super.key});

  @override
  State createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {

  //GoogleSignInAccount? _currentUser;//transfer to utiities
  //bool _isAuthorized = false; // has granted permissions? tranafer to utillits
  String _contactText = '';
  bool isChecked = false;
  bool isSecurePassword = false;

  @override
  void initState() {
    super.initState();

    Googel_Signin.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
// #docregion CanAccessScopes
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, on web...
      if (kIsWeb && account != null) {
        isAuthorized = await Googel_Signin.googleSignIn.canAccessScopes(scopes);
      }
// #enddocregion CanAccessScopes

      setState(() {
        Googel_Signin.currentUser = account;
        Googel_Signin.isAuthorized= isAuthorized;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }
    });

    Googel_Signin.googleSignIn.signInSilently();
  }

  // Calls the People API REST endpoint for the signed-in user to retrieve information.
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
            (dynamic name) =>
        (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  // Future<void> _handleSignIn() async {
  //   try {
  //     await Googel_Signin.googleSignIn.signIn();
  //     print('Point 2 _googleSignIn.signIn();');
  //   } catch (error) {
  //     print('Point 3 Error start();');
  //     print(error);
  //     print('Point 4 Error done();');
  //   }
  // } // transfer utillites class

  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await Googel_Signin.googleSignIn.requestScopes(scopes);
    // #enddocregion RequestScopes
    setState(() {
      Googel_Signin.isAuthorized = isAuthorized;
    });
    // #docregion RequestScopes
    if (isAuthorized) {
      unawaited(_handleGetContact(  Googel_Signin.currentUser!));
    }
    // #enddocregion RequestScopes
  }

  Future<void> _handleSignOut() => Googel_Signin.googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = Googel_Signin.currentUser;
    print("Checking current user  $user");
    if (user != null) {
      String mail = "";
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          if (Googel_Signin.isAuthorized) ...<Widget>[
            // The user has Authorized all required scopes
            // Text(_contactText),
            InkWell(
              child: Container(
                height: 50,
                width: 300,
                color: Colors.green,
                child: Center(child: Text("Continue >>",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
              ),
              onTap:() {
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     type: PageTransitionType.topToBottom,
                //     isIos: true,
                //     child: Bottomnavigation(index: 0),
                //   ),
                //);
              },
            )
          ],
          if (!Googel_Signin.isAuthorized) ...<Widget>[
            // The user has NOT Authorized all required scopes.
            // (Mobile users may never see this button!)
            const Text('Additional permissions needed to read your contacts.'),
            ElevatedButton(
              onPressed: _handleAuthorizeScopes,
              child: const Text('REQUEST PERMISSIONS'),
            ),
          ],

          InkWell(
            child: Container(
              height: 50,
              width: 300,
              color: Colors.teal,
              child: const Center(child: Text("Sign Out",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
            ),
            onTap:() {
              setState(() {
                _handleSignOut();
              });
            },
          ),


        ],
      );

    } else {
      // The user is NOT Authenticated
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // const Text('You are not currently signed in.'),
          //Image.asset("images/login.png"),

          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: [

                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Text(
                  'Please sign in to continue',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            child: Container(
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.teal),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text("Login With Google",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ),

                ],
              ),
            ),
            onTap: () async {
              await Googel_Signin.handleSignIn();
            },
          ),
          const SizedBox(height: 50), // Adjust this height to ensure it doesn't overflow


        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));


  }
}



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  bool isSecurePassword = false;

  @override
  Widget build(BuildContext context) {
    // Color getColor(Set<WidgetState> states) {
    //   const Set<WidgetState> interactiveStates = <WidgetState>{
    //     WidgetState.pressed,
    //     WidgetState.hovered,
    //     WidgetState.focused,
    //   };
    //   if (states.any(interactiveStates.contains)) {
    //     return Colors.blue;
    //   }
    //   return Colors.blue;
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
               // child: Image.asset("images/login.png"),
              ),

            ],
          ),
        ),
      ),
    );
  }

}


