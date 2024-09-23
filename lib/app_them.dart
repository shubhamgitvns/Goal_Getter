import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class App_Text{
  static const TextStyle button_text =
  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25);

  static const TextStyle label =
  TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.w400);

  static const Color button_color= Colors.teal;



  // Input Text var
  static TextEditingController number = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController name = TextEditingController();
  static TextEditingController task_title = TextEditingController();
  static TextEditingController sub_title = TextEditingController();
  static TextEditingController comments = TextEditingController();


  static TextEditingController edit_task = TextEditingController();

  //select var
  static String connection = "";
  static String category = "";
  static String time = "";
  static String Screen_size="None";
  static String repeat_task="";
  static String date ="";
  static String month ="";
  static String year ="";
  static int Counter = 0;
  static int Complete = 0;
  static int id = 0;
  static bool done = false;
  static String gmail = "";

  static FirebaseFirestore? firestoredb; //=FirebaseFirestore.instance;

  static List<Widget> lst = [];
  static bool click = false;


  _FirebaseDemoState() {}
  static String firebasedata = "data";



}

class Support_container {
  static final BoxDecoration box = BoxDecoration(
    border: Border.all(color: Colors.green.shade100),
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.green.shade500,
        offset: const Offset(
          2.0,
          2.0,
        ),
        blurRadius: 5.0,
        spreadRadius: 1.0,
      ), //BoxShadow
      const BoxShadow(
        color: Colors.white,
        offset: Offset(0.0, 0.0),
        blurRadius: 0.0,
        spreadRadius: 0.0,
      ), //BoxShadow
    ],
  );
}