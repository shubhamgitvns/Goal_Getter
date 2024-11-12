import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todocreater/app_text_var.dart';
import 'package:todocreater/authentication/signin.dart';

import '../functions.dart';
import '../home_page/bottombar/bottombar.dart';
import '../utilittes.dart';

void main() => runApp(ECommerceIntroApp());

class ECommerceIntroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green,
          secondary: Colors.greenAccent,
        ),
      ),
      home: IntroPage(),
    );
  }
}

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Googel_Signin.login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                size: 100,
                color: Colors.green.shade300,
              ),
              SizedBox(height: 20),
              Text(
                "Welcome to GreenShop!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Discover the best products at unbeatable prices.",
                style: TextStyle(fontSize: 20, color: Colors.green.shade300),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  int vnoOnline = await getOnline_Version();
                  print(vnoOnline);
                  if (vnoOnline == -1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("No internet connection."),
                      ),
                    );
                  } else {
                    print(App_Text.db_json_data);
                    if (Googel_Signin.currentUser == null) {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.topToBottom,
                          isIos: true,
                          child: SignInDemo(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.topToBottom,
                          isIos: true,
                          child: Bottomnavigation(
                            index: 0,
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
