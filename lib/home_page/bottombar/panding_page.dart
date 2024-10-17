
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../app_them.dart';
import 'bottombar.dart';

class PandingPage extends StatefulWidget {
  static FirebaseFirestore? firestoredb; //=FirebaseFirestore.instance;

  const PandingPage({super.key});

  @override
  State<PandingPage> createState() => _PandingPageState();
}

class _PandingPageState extends State<PandingPage> {
  int isselect = 0;
  @override
  void initState() {
    super.initState();
    firebaseInit();
    getmessages();
  }

  void firebaseInit() {
    try {
      PandingPage.firestoredb = FirebaseFirestore.instance;
    } catch (ee) {
      print(ee);
    }
  }

  List<Widget> lst = [];
  Future<void> getmessages() async {
    dynamic result =
    await PandingPage.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail)
          // setState(() {
          //   //print(value.get("comments").toString());
          //   lst.add(TaskList(
          //     value,
          //   ));
          // });
        firebasedata = firebasedata + value.data().toString() + "\n";
      }
    });
    setState(() {});
    print(firebasedata);
  }

  // Future<void> personal() async {
  //   dynamic result =
  //   await PandingPage.firestoredb?.collection("goal_getter").snapshots();
  //   Stream<QuerySnapshot> ms = result;
  //   firebasedata = "";
  //   ms.forEach((element) {
  //     for (var value in element.docs) {
  //       if (value.get('done').toString() == 'false' &&
  //           value.get('gmail').toString() == App_Text.gmail &&
  //           value.get('category').toString() == "Personal".toString())
  //         setState(() {
  //           //print(value.get("comments").toString());
  //           lst.add(TaskList(
  //             value,
  //           ));
  //         });
  //       firebasedata = firebasedata + value.data().toString() + "\n";
  //     }
  //   });
  //   setState(() {});
  //   print(firebasedata);
  // }
  //
  // Future<void> office_work() async {
  //   dynamic result =
  //   await PandingPage.firestoredb?.collection("goal_getter").snapshots();
  //   Stream<QuerySnapshot> ms = result;
  //   firebasedata = "";
  //   ms.forEach((element) {
  //     for (var value in element.docs) {
  //       if (value.get('done').toString() == 'false' &&
  //           value.get('gmail').toString() == App_Text.gmail &&
  //           value.get('category').toString() == "Office Work".toString())
  //         setState(() {
  //           //print(value.get("comments").toString());
  //           lst.add(TaskList(
  //             value,
  //           ));
  //         });
  //       firebasedata = firebasedata + value.data().toString() + "\n";
  //     }
  //   });
  //   setState(() {});
  //   print(firebasedata);
  // }
  //
  // Future<void> workout() async {
  //   dynamic result =
  //   await PandingPage.firestoredb?.collection("goal_getter").snapshots();
  //   Stream<QuerySnapshot> ms = result;
  //   firebasedata = "";
  //   ms.forEach((element) {
  //     for (var value in element.docs) {
  //       if (value.get('done').toString() == 'false' &&
  //           value.get('gmail').toString() == App_Text.gmail &&
  //           value.get('category').toString() == "Workout".toString())
  //         setState(() {
  //           //print(value.get("comments").toString());
  //           lst.add(TaskList(
  //             value,
  //           ));
  //         });
  //       firebasedata = firebasedata + value.data().toString() + "\n";
  //     }
  //   });
  //   setState(() {});
  //   print(firebasedata);
  // }
  //
  // Future<void> yoga() async {
  //   dynamic result =
  //   await PandingPage.firestoredb?.collection("goal_getter").snapshots();
  //   Stream<QuerySnapshot> ms = result;
  //   firebasedata = "";
  //   ms.forEach((element) {
  //     for (var value in element.docs) {
  //       if (value.get('done').toString() == 'false' &&
  //           value.get('gmail').toString() == App_Text.gmail &&
  //           value.get('category').toString() == "Yoga".toString())
  //         setState(() {
  //           //print(value.get("comments").toString());
  //           lst.add(TaskList(
  //             value,
  //           ));
  //         });
  //       firebasedata = firebasedata + value.data().toString() + "\n";
  //     }
  //   });
  //   setState(() {});
  //   print(firebasedata);
  // }
  //
  // Future<void> sport() async {
  //   dynamic result =
  //   await PandingPage.firestoredb?.collection("goal_getter").snapshots();
  //   Stream<QuerySnapshot> ms = result;
  //   firebasedata = "";
  //   ms.forEach((element) {
  //     for (var value in element.docs) {
  //       if (value.get('done').toString() == 'false' &&
  //           value.get('gmail').toString() == App_Text.gmail &&
  //           value.get('category').toString() == "Sport".toString())
  //         setState(() {
  //           //print(value.get("comments").toString());
  //           lst.add(TaskList(
  //             value,
  //           ));
  //         });
  //       firebasedata = firebasedata + value.data().toString() + "\n";
  //     }
  //   });
  //   setState(() {});
  //   print(firebasedata);
  // }

  Future<void> birth_day() async {
    dynamic result =
    await PandingPage.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail &&
            value.get('category').toString() == "Birthday".toString())
          // setState(() {
          //   //print(value.get("comments").toString());
          //   lst.add(TaskList(
          //     value,
          //   ));
          // });
        firebasedata = firebasedata + value.data().toString() + "\n";
      }
    });
    setState(() {});
    print(firebasedata);
  }

  Future<void> other() async {
    dynamic result =
    await PandingPage.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail &&
            value.get('category').toString() == "Other".toString())
          setState(() {
            //print(value.get("comments").toString());
            // lst.add(TaskList(
            //   value,
            // ));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
      }
    });
    setState(() {});
    print(firebasedata);
  }

  _FirebaseDemoState() {}
  String firebasedata = "data";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_circle_left,
            size: 50,
            color: Colors.teal,
          ),
          onTap: (){
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                isIos: true,
                child:  Bottomnavigation(index: 0,),
                // FingerPrint(),
              ),
            );
          },
        ),
        title: const Text(
          "Pending Task",
          style: TextStyle(
              color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
          children: [
            Center(child: Text("Simple Page"))
          ],
          ),
        ),
      ),
    );
  }
}
