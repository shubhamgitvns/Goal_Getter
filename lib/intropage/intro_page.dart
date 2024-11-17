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
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black.withOpacity(0.7)),
          bodyMedium: TextStyle(color: Colors.black.withOpacity(0.7)),
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

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;
  late AnimationController _textController;
  late Animation<double> _textAnimation;
  late AnimationController _buttonController;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward();

    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );

    _textController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..forward();

    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    );

    _buttonController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _buttonAnimation = CurvedAnimation(
      parent: _buttonController,
      curve: Curves.elasticOut,
    );

    Googel_Signin.login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background for a clean look
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated logo with subtle fade and scale effect
              FadeTransition(
                opacity: _logoAnimation,
                child: ScaleTransition(
                  scale: _logoAnimation,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 120,
                    color: Colors.green.shade300,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Animated welcome text
              FadeTransition(
                opacity: _textAnimation,
                child: Text(
                  "Welcome to Women's Fashion App",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              FadeTransition(
                opacity: _textAnimation,
                child: Text(
                  "Discover the best products at unbeatable prices.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),

              // Animated Get Started button
              AnimatedBuilder(
                animation: _buttonAnimation,
                builder: (context, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Rounded corners for the button
                      ),
                      shadowColor: Colors.greenAccent,
                      elevation: 5, // Add shadow to button for 3D effect
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
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _buttonController.dispose();
    super.dispose();
  }
}
