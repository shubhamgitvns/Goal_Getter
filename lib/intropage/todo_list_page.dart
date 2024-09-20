
// import 'package:firebase_demo/signin_demo.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../app_them.dart';
import '../signin.dart';
// import 'package:to_do_list/authentication_pages/login_page.dart';

class To_Do_List_Intro extends StatelessWidget {
  const To_Do_List_Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //const SizedBox(height: 100,),
                // Image.asset("images/list.png"),

                const SizedBox(height: 25,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Icon(Icons.file_copy_rounded,color: Colors.teal,size: 35,),
                      ),
                      Text(
                        'Create Task Quickly and Easily',
                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Icon(Icons.alarm,color: Colors.teal,size: 35,),
                      ),
                      Text(
                        'Task Reminders',
                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Icon(Icons.personal_injury,color: Colors.teal,size: 35,),
                      ),
                      Text(
                        'Personalized Widget',
                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Icon(Icons.supervised_user_circle,color: Colors.teal,size: 35,),
                      ),
                      Text(
                        'Users Friendly',
                        style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 70,),

                InkWell(
                  child: Container(
                    height: 50,
                    width: 300,
                    color: App_Text.button_color,
                    child:  const Center(child: Text("Continue >>",
                      style: App_Text.button_text,),),
                  ),
                  onTap: (){
                    Navigator.push(
                      context, PageTransition(
                      type: PageTransitionType.rightToLeft,
                      isIos: true,
                      child:  const SignInDemo(),
                      // FingerPrint(),
                    ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
