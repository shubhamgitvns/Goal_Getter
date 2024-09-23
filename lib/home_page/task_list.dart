
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../app_them.dart';
import 'edit_task.dart';

class TaskList extends StatefulWidget {
  static FirebaseFirestore? firestoredb; //=FirebaseFirestore.instance;
  // TaskList({super.key});
  dynamic value;
  String id = "";
  String title = "";
  String sub_title = "";
  String time = "";
  String date = "";
  String month = "";
  String year = "";
  String category = "";
  String comments = "";
  @override
  State<TaskList> createState() => _TaskListState();

  TaskList(
      dynamic value,
      ) {
    this.value = value;
    this.id = value.id;
    this.title = value.get("title").toString();
    this.sub_title = value.get("sub_title").toString();
    this.time = value.get("time").toString();
    this.date = value.get("date").toString();
    this.month = value.get("month").toString();
    this.year = value.get("year").toString();
    this.category = value.get("category").toString();
    this.comments = value.get("comments").toString();
  }
}

class _TaskListState extends State<TaskList> {
  bool isselect = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    firebaseInit();

  }

  void firebaseInit() {
    try {
      TaskList.firestoredb = FirebaseFirestore.instance;
    } catch (ee) {
      print(ee);
    }
  }

  _FirebaseDemoState() {}
  String firebasedata = "data";

  List<Widget> lst = [];
  Future<void> category() async {
    dynamic result =
    await TaskList.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('date').toString() == DateTime.now().day.toString() &&
            value.get('done').toString() == 'false'
        )
          setState(() {
            App_Text.Counter++;
            lst.add(TaskList(
                value
            ));
          });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
        print(value.id);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green.shade100),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade100,
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
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //if(App_Text.done == false)
                          Column(
                            children: [
                              Container(
                                color: Colors.teal,
                                width: 19,
                                height: 19,
                                child: Checkbox(
                                  checkColor: Colors.green,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState((){
                                      isChecked = value!;
                                      App_Text.done = isChecked;
                                      var collection = FirebaseFirestore
                                          .instance
                                          .collection('goal_getter');
                                      collection
                                          .doc(widget.id)
                                          .update({
                                        'done': '${App_Text.done}',
                                      }) // <-- Updated data
                                          .then((_) => print('Success'))
                                          .catchError((error) =>
                                          print('Failed: $error'));
                                      category();
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                          // if(App_Text.done == true)
                          //   const Column(
                          //     children: [
                          //       Icon(Icons.check)
                          //     ],
                          //   ),
                          Column(
                            children: [
                              Text(
                                widget.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(
                                widget.sub_title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.category,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            // const SizedBox(width: 15,),
                            Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green.shade300,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.lock_clock,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    Text(
                                      widget.time,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.calendar_month,
                                  color: Colors.teal,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.date,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Text("-"),
                          Text(
                            widget.month,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Text("-"),
                          Text(
                            widget.year,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Icon(
                            Icons.star,
                            size: 30,
                            color:
                            isselect ? Colors.green : Colors.green.shade100,
                          ),
                          onTap: () {
                            setState(() {
                              // using this double tap//
                              isselect = !isselect;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.green,
                            size: 30,
                          ),
                          onTap: () {
                            App_Text.edit_task.text = widget.id;
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                isIos: true,
                                child: Edit_TaskPage(
                                    "${widget.value}",
                                    "${widget.title}",
                                    "${widget.sub_title} ",
                                    "${widget.comments}",
                                    "${widget.time}",
                                    "${widget.date}",
                                    "${widget.month}",
                                    "${widget.year}",
                                    "${widget.id}"),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}