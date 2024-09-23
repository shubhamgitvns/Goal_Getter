import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todocreater/home_page/task_list.dart';

import '../app_them.dart';

class Category extends StatefulWidget {
  static FirebaseFirestore? firestoredb; //=FirebaseFirestore.instance;
  const Category({super.key});
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int isselect = 0;
  int index = 0;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    firebaseInit();
    setState(() {
      App_Text.Counter = 0;
      App_Text.Complete = 0;
    });
    lst.clear();
    category();
    complete_tak();
  }

  void firebaseInit() {
    try {
      Category.firestoredb = FirebaseFirestore.instance;
    } catch (ee) {
      print(ee);
    }
  }

  //************* According to category devide the today task fun() ****************//
  List<Widget> lst = [];
  Future<void> persional() async {
    dynamic result =
    await Category.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        // value.update("");
        if (value.get('category').toString() == "Personal".toString() &&
            value.get('date').toString() == DateTime.now().day.toString() &&
            value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail)
          setState(() {
            lst.add(TaskList(value));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  Future<void> office_work() async {
    dynamic result =
    await Category.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('category').toString() == "Office Work".toString() &&
            value.get('date').toString() == DateTime.now().day.toString() &&
            value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail)
          setState(() {
            lst.add(TaskList(value));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  Future<void> workout() async {
    dynamic result =
    await Category.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('category').toString() == "Workout".toString() &&
            value.get('date').toString() == DateTime.now().day.toString() &&
            value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail)
          setState(() {
            lst.add(TaskList(value));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  Future<void> yoga() async {
    dynamic result =
    await Category.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('category').toString() == "Yoga".toString() &&
            value.get('date').toString() == DateTime.now().day.toString() &&
            value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail)
          setState(() {
            lst.add(TaskList(value));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  Future<void> sport() async {
    dynamic result =
    await Category.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('category').toString() == "Sport".toString() &&
            value.get('date').toString() == DateTime.now().day.toString() &&
            value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail)
          setState(() {
            lst.add(TaskList(value));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  Future<void> birthday() async {
    dynamic result =
    await Category.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('category').toString() == "Birthday".toString() &&
            value.get('date').toString() == DateTime.now().day.toString() &&
            value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail)
          setState(() {
            lst.add(TaskList(value));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  Future<void> none() async {
    dynamic result =
    await Category.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('category').toString() == "None".toString() &&
            value.get('date').toString() == DateTime.now().day.toString() &&
            value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail)
          setState(() {
            lst.add(TaskList(value));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  Future<void> category() async {
    dynamic result =
    await Category.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('date').toString() == DateTime.now().day.toString() &&
            value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail)
          setState(() {
            App_Text.Counter++;
            lst.add(TaskList(value));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
        print(value.id);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  Future<void> All() async {
    dynamic result =
    await Category.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('date').toString() == DateTime.now().day.toString() &&
            value.get('done').toString() == 'false' &&
            value.get('gmail').toString() == App_Text.gmail)
          setState(() {
            lst.add(TaskList(value));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
      }
    });
    setState(() {});
    // print(firebasedata);
  }

  Future<void> complete_tak() async {
    dynamic result =
    await Category.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if(value.get('done').toString() == 'true' &&
            value.get('date').toString() == DateTime.now().day.toString()
        )
          setState(() {
            App_Text.Complete++;

          });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
      }
    });
    setState(() {
    });
    print(firebasedata);


  }

  _FirebaseDemoState() {}
  String firebasedata = "data";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Row(
            children: [
              Text(
                "Task Overview",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 120,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.shade100,
                    border: Border.all(color: Colors.green)),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${App_Text.Complete}",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Complete Task",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                height: 120,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.shade100,
                    border: Border.all(color: Colors.green)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${App_Text.Counter}",
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Pending Task",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: isselect != 0
                                    ? Colors.white
                                    : Colors.green.shade300,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                Border.all(color: Colors.green.shade300)),
                            child: Center(
                                child: Text(
                                  "All",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    isselect != 0 ? Colors.black : Colors.white,
                                  ),
                                ))),
                        onTap: () {
                          print(DateTime.now().microsecond);
                          setState(() {
                            lst.clear();
                            isselect = 0;
                            All();
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                color: isselect != 1
                                    ? Colors.white
                                    : Colors.green.shade300,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                Border.all(color: Colors.green.shade300)),
                            child: Center(
                                child: Text(
                                  "Personal",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    isselect != 1 ? Colors.black : Colors.white,
                                  ),
                                ))),
                        onTap: () {
                          setState(() {
                            lst.clear();
                            isselect = 1;
                            persional();
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: isselect != 2
                                    ? Colors.white
                                    : Colors.green.shade300,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                Border.all(color: Colors.green.shade300)),
                            child: Center(
                              child: Text(
                                "Office Work",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: isselect != 2
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            )),
                        onTap: () {
                          setState(() {
                            lst.clear();
                            office_work();
                            isselect = 2;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: isselect != 3
                                    ? Colors.white
                                    : Colors.green.shade300,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                Border.all(color: Colors.green.shade300)),
                            child: Center(
                                child: Text(
                                  "Workout",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    isselect != 3 ? Colors.black : Colors.white,
                                  ),
                                ))),
                        onTap: () {
                          setState(() {
                            lst.clear();
                            workout();
                            isselect = 3;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: isselect != 4
                                    ? Colors.white
                                    : Colors.green.shade300,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                Border.all(color: Colors.green.shade300)),
                            child: Center(
                                child: Text(
                                  "Yoga",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    isselect != 4 ? Colors.black : Colors.white,
                                  ),
                                ))),
                        onTap: () {
                          setState(() {
                            lst.clear();
                            yoga();
                            isselect = 4;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: isselect != 5
                                    ? Colors.white
                                    : Colors.green.shade300,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                Border.all(color: Colors.green.shade300)),
                            child: Center(
                                child: Text(
                                  "Sport",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    isselect != 5 ? Colors.black : Colors.white,
                                  ),
                                ))),
                        onTap: () {
                          setState(() {
                            lst.clear();
                            sport();
                            isselect = 5;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: isselect != 6
                                    ? Colors.white
                                    : Colors.green.shade300,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                Border.all(color: Colors.green.shade300)),
                            child: Center(
                                child: Text(
                                  "Birthday",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    isselect != 6 ? Colors.black : Colors.white,
                                  ),
                                ))),
                        onTap: () {
                          setState(() {
                            lst.clear();
                            birthday();
                            isselect = 6;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        child: Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                                color: isselect != 7
                                    ? Colors.white
                                    : Colors.green.shade300,
                                borderRadius: BorderRadius.circular(15),
                                border:
                                Border.all(color: Colors.green.shade300)),
                            child: Center(
                                child: Text(
                                  "Other",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    isselect != 7 ? Colors.black : Colors.white,
                                  ),
                                ))),
                        onTap: () {
                          setState(() {
                            lst.clear();
                            none();
                            isselect = 7;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Text(
                    "Today's Task",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: lst,
            ),
          ],
        ),
      ],
    );
  }
}