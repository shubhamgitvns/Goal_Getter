import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
import '../app_them.dart';
import '../utilittes.dart';
import 'add_task.dart';
import 'cataegory.dart';


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
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String scheduledTime ="";
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
    _requestNotificationPermission();
   // _scheduleNotification();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> _requestNotificationPermission() async {
    await _messaging.requestPermission();
  }

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
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width:300,
                                    child: Text("${user?.displayName}",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),

                              ],
                            ),
                            const SizedBox(height: 20,),
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
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Category(),
                  ),

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
                setState(() {
                  var intValue = Random().nextInt(100000);
                  print(intValue);
                  App_Text.id = intValue;
                  print(App_Text.id);
                });

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