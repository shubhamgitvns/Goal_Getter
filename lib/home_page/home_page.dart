import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';

import '../app_them.dart';
import '../utilittes.dart';
import 'add_task.dart';


class HomePage extends StatefulWidget {
  static FirebaseFirestore? firestoredb; //=FirebaseFirestore.instance;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignInAccount? user = Googel_Signin.currentUser;
  final messaging = FirebaseMessaging.instance;
  String _lastMessage = "";
  // notification ke liye hh
  final _messageStreamController = BehaviorSubject<RemoteMessage>();

  _HomePageState() {

    _messageStreamController.listen((message) {
      setState(() {
        if (message.notification != null) {
          _lastMessage = 'Received a notification message:'
              '\nTitle=${message.notification?.title},'
              '\nBody=${message.notification?.body},'
              '\nData=${message.data}';
        } else {
          _lastMessage = 'Received a data message: ${message.data}';
        }
      });
    });
  }

  //print("Checking current user  $user");
  @override
  Widget build(BuildContext context) {
    App_Text.gmail = "${user?.email}";
    return Scaffold(

      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Image.network("https://plus.unsplash.com/premium_photo-1661878265739-da90bc1af051?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZGlnaXRhbCUyMHRlY2hub2xvZ3l8ZW58MHx8MHx8fDA%3D"))
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child:  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 70),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Name",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.indigo),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Uploding on",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey),)

                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  //width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Colors.blue)
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(child: Text("Carvars Painting",style: TextStyle(color: Colors.indigo,fontSize: 15,fontWeight: FontWeight.bold),)),
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Icon(Icons.heart_broken_outlined),
                            Text("543"),
                            SizedBox(width: 20,),
                            Icon(Icons.remove_red_eye_outlined),
                            Text("2.14 K"),
                            SizedBox(width: 20,),
                            Icon(Icons.message),
                            Text("2"),
                          ],
                        )
                      ],
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: TextField(
                            autofocus: true,
                            //controller: myController,
                            cursorColor: Colors.grey,
                            style: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  //width: 1.5,
                                ),
                              ),

                              //********Focus border like hover******************8
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                  const BorderSide(color: Colors.grey)),
                              hintText: "Enter Task",
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: InkWell(child: Icon(Icons.send,color: Colors.white,)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),


          //***********Task Add Button****************//
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: InkWell(
          //     child: Container(
          //       height: 60,
          //       width: 60,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(50),
          //           color: Colors.teal
          //       ),
          //       child:
          //       const Icon(Icons.add,size: 50,color: Colors.white,),
          //     ),
          //     onTap: () async {
          //       setState(() {
          //         var intValue = Random().nextInt(100000);
          //         print(intValue);
          //         App_Text.id = intValue;
          //         print(App_Text.id);
          //       });
          //
          //       Navigator.push(
          //         context,
          //         PageTransition(
          //           type: PageTransitionType.bottomToTop,
          //           isIos: true,
          //           child: const Add_TaskPage(),
          //         ),
          //       );
          //     },
          //   ),
          // )
        ],

      ),
    );
  }
}

class DataGet {
  static String token = '';
}