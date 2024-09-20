import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';

import '../app_them.dart';
import '../utilittes.dart';


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
  //final _messageStreamController = BehaviorSubject<RemoteMessage>();


  _HomePageState() {
    // notification ke liye hh

    // _messageStreamController.listen((message) {
    //   setState(() {
    //     if (message.notification != null) {
    //       _lastMessage = 'Received a notification message:'
    //           '\nTitle=${message.notification?.title},'
    //           '\nBody=${message.notification?.body},'
    //           '\nData=${message.data}';
    //     } else {
    //       _lastMessage = 'Received a data message: ${message.data}';
    //     }
    //   });
    // });
  }

  //print("Checking current user  $user");
  @override
  Widget build(BuildContext context) {
    App_Text.gmail = "${user?.email}";
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Center(child: Text("Welcome",
          style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 30),
        )),
        actions: const [
          Padding(
            padding: EdgeInsets.all(25.0),
            child: Icon(Icons.notification_add,size: 30,color: Colors.teal,),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          SingleChildScrollView(
            //physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50,),
                  Center(
                    child: Container(
                      height: 200,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text("Hello,",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 35,fontStyle: FontStyle.italic),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width:200,
                                    child: Text("${user?.displayName}",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),

                                const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage("images/intro.png"),
                                )

                              ],
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                                width:300,
                                child: Center(child: Text("${user?.email}",style: TextStyle(fontWeight: FontWeight.w500,),))),
                          ],
                        ),
                      ),
                    ),
                  ),

                  //************ Category slider *****************//
                  const SizedBox(height: 10,),
                  // Padding(
                  //   padding: EdgeInsets.all(15.0),
                  //   child: Category(),
                  // ),
                  Text('Last message from Firebase Messaging:',
                      style: Theme.of(context).textTheme.titleLarge),
                  Text(_lastMessage, style: Theme.of(context).textTheme.bodyLarge),
                  SelectableText(DataGet.token, style: Theme.of(context).textTheme.bodyLarge),


                ],
              ),
            ),
          ),

          //***********Task Add Button****************//
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.teal
                ),
                child:
                const Icon(Icons.add,size: 50,color: Colors.white,),
              ),
              onTap: () async {

                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.bottomToTop,
                    isIos: true,
                    child: const Add_TaskPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class DataGet {
  static String token = '';
}