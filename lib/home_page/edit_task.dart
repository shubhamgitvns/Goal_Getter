import 'dart:io';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:todocreater/home_page/task_list.dart';

import '../app_them.dart';
import 'bottombar/bottombar.dart';

const List<String> list_a = <String>[
  'Personal',
  'Office Work',
  'Workout',
  'Yoga',
  'Sport',
  'Birthday'
];

const List<String> list_b = <String>[
  'None',
  'Hour',
  'Daily',
  'Weekly',
  'Monthly',
  'Yearly',
];

class Edit_TaskPage extends StatefulWidget {
  static FirebaseFirestore? firestoredb; //=FirebaseFirestore.instance;
  dynamic value;
  String title = "";
  String sub_title = "";
  String comments = "";
  String time = "";
  String day = "";
  String month = "";
  String year = "";
  String id = "";
  String ID = "";
  //const Edit_TaskPage({super.key});

  @override
  State<Edit_TaskPage> createState() => _Edit_TaskPageState();
  Edit_TaskPage(
      dynamic value,
      String title,
      String sub_title,
      String comments,
      String time,
      String day,
      String month,
      String year,
      String id,
      String  ID,
      ) {
    this.value = value;
    this.title = title;
    this.sub_title = sub_title;
    this.comments = comments;
    this.time = time;
    this.day = day;
    this.month = month;
    this.year = year;
    this.id = id;
    this.ID = ID;
  }
}

class _Edit_TaskPageState extends State<Edit_TaskPage> {
  DateTime _selectedDate1 = DateTime.now();
  DateTime _selectedDate2 = DateTime.now();
//*************Time picker initializer*************
  TimeOfDay _selectedTime = TimeOfDay.now();

  final myController = TextEditingController();
  final sub_title = TextEditingController();
  final comments = TextEditingController();

  Future<void> _fromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate1) {
      setState(() {
        _selectedDate1 = picked;
      });
    }
  }

  Future<void> _ToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate2) {
      setState(() {
        _selectedDate2 = picked;
      });
    }
  }

//*******************Select Time fun()****************
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    firebaseInit();
  }

  void firebaseInit() {
    try {
      Edit_TaskPage.firestoredb = FirebaseFirestore.instance;
    } catch (ee) {
      print(ee);
    }
  }

  List<Widget> lst = [];
  Future<void> getmessages() async {
    dynamic result =
    await Edit_TaskPage.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        if (value.get('date').toString() != DateTime.now().day.toString())
          continue;
        setState(() {
          App_Text.Counter++;
          lst.add(TaskList(value));
        });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  Future<void> editmessages() async {
    dynamic result =
    await Edit_TaskPage.firestoredb?.collection("goal_getter").snapshots();
    Stream<QuerySnapshot> ms = result;
    firebasedata = "";
    ms.forEach((element) {
      for (var value in element.docs) {
        print(value.runtimeType);
        // setState(() {
        //   App_Text.Counter++;
        //   lst.add(TaskList(
        //     value
        //   )
        //   );
        // });
        firebasedata = firebasedata + value.data().toString() + "\n";
        print(TimeOfDay.hoursPerDay);
      }
    });
    setState(() {});
    print(firebasedata);
  }

  _FirebaseDemoState() {}
  String firebasedata = "data";


  void deleteMessages(String id) async {
    print("hii");
    dynamic result =
    await Edit_TaskPage.firestoredb?.collection("goal_getter").get();
    QuerySnapshot messages = result;
    for (var message in messages.docs) {
      // firebasedata = firebasedata + message.data().toString() + "\n";
      String msgfrom = message.id;
      if (msgfrom == id) {
        Edit_TaskPage.firestoredb
            ?.collection("goal_getter")
            .doc(message.id)
            .delete();
        break;
      }
    }
    //print(firebasedata);
    //setState(() {});
  }
  final alarmSettings = AlarmSettings(
    id: App_Text.id,
    dateTime: DateTime(2024,9,23,16,12,1),
    assetAudioPath: 'assets/battle.mp3',
    loopAudio: true,
    vibrate: true,
    volume: 0.8,
    fadeDuration: 3.0,
    notificationTitle: 'Check Yor Latest Task',
    notificationBody: 'Click and go to the App',
    enableNotificationOnKill: Platform.isIOS,
  );

  @override
  Widget build(BuildContext context) {
    myController.text = widget.title;
    sub_title.text = widget.sub_title;
    comments.text = widget.comments;
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
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
            child: Text(
              "Edit Task",
              style: TextStyle(
                  color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 25),
            )),
      ),
      body: SingleChildScrollView(
        //physics: const BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const Column(
                    children: [
                      Text("If alarm is ring",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),)
                    ],
                  ),
                    Column(
                      children: [
                        InkWell(
                          child: Container(
                            height: 50,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Center(child: Text("Off",style: TextStyle(color: Colors.white,fontSize: 20),)),
                          ),
                          onTap: (){
                            //print(widget.ID);
                            setState(() async {
                              int stop = int.parse(widget.ID);
                              await Alarm.stop(stop);
                              print(stop);

                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                const Row(
                  children: [
                    Text(
                      "Task Title",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.white,
                      child: SizedBox(
                        width: 350,
                        child: TextField(
                          autofocus: true,
                          controller: myController,
                          cursorColor: Colors.green,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.green.shade200,
                                //width: 1.5,
                              ),
                            ),

                            //********Focus border like hover******************8
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                const BorderSide(color: Colors.green)),
                            hintText: "Enter Task",
                            hintStyle: TextStyle(color: Colors.green.shade200),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Sub-Title",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.white,
                      child: SizedBox(
                        width: 350,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          controller: sub_title,
                          cursorColor: Colors.green,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.green.shade200,
                                //width: 1.5,
                              ),
                            ),

                            //********Focus border like hover******************8
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                const BorderSide(color: Colors.green)),
                            hintText: "Enter Sub-Task",
                            hintStyle: TextStyle(color: Colors.green.shade200),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Choose Category",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButtonExample(),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: Text(
                                "Previous Time",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 170,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Colors.green.shade200),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.lock_clock,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                  ),
                                  Text(widget.time)
                                ],
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: Text(
                                "Edit Time",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 170,
                            child: InkWell(
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.green.shade200),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.lock_clock,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                    ),
                                    Text(_selectedTime.format(context))
                                  ],
                                ),
                              ),
                              onTap: () {
                                _selectTime(context);
                              },
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: Text(
                                "Previous Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 170,
                          child: AbsorbPointer(
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.green.shade200,
                                    //width: 1.5,
                                  ),
                                ),
                                labelText:
                                "${widget.year}-${widget.month}-${widget.day}",
                                prefixIcon: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: Text(
                                "Edit Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 170,
                          child: GestureDetector(
                            onTap: () => _fromDate(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.green.shade200,
                                      //width: 1.5,
                                    ),
                                  ),
                                  labelText: _selectedDate1
                                      .toString()
                                      .substring(0, 10),
                                  prefixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Repeat Task",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 350,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green.shade200),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DropdownButton_B(),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Choose Remainder",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green.shade200)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Remainder",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.chevron_right,
                            size: 30,
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Choose Screen Size && Close Button",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green.shade200)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            App_Text.Screen_size,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.chevron_right,
                              size: 30,
                              color: Colors.green,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   PageTransition(
                    //     type: PageTransitionType.rightToLeft,
                    //     isIos: true,
                    //     child: const Screensize_Page(),
                    //   ),
                    // );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      "Comments",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.white,
                      child: SizedBox(
                        //height: 100,
                        width: 350,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: comments,
                          autofocus: true,
                          cursorColor: Colors.green,
                          cursorHeight: 20,
                          style: const TextStyle(
                              height: 5,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.green.shade200,
                                //width: 1.5,
                              ),
                            ),

                            //********Focus border like hover******************8
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                const BorderSide(color: Colors.green)),
                            //hintText: "Enter Sub-Task",
                            hintStyle: TextStyle(color: Colors.green.shade200),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ))),
                      onTap: () {
                        print("click delete");
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 300,
                              color: Colors.green.shade100,
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Center(
                                        child: Text(
                                          "Are You Sure!",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Center(
                                        child: Text(
                                          "Do you really want to delete this task",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        )),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          child: Container(
                                            width: 70,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.green)),
                                            child: const Center(
                                                child: Text(
                                                  "No",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.green),
                                                )),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        InkWell(
                                          child: Container(
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                border: Border.all(
                                                    color: Colors.green)),
                                            child: const Center(
                                                child: Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                          ),
                                          onTap: () {
                                            print(widget.id);
                                            deleteMessages(widget.id);
                                            //Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType
                                                    .leftToRight,
                                                isIos: true,
                                                child:
                                                Bottomnavigation(index: 0),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                              child: Text(
                                "Edit",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ))),
                      onTap: () {
                        var collection = FirebaseFirestore.instance
                            .collection('goal_getter');
                        collection
                            .doc(widget.id)
                            .update({
                          'title': '${myController.text}',
                          'sub_title': '${sub_title.text}',
                          'comments': '${comments.text}',
                          'category': '${App_Text.category}',
                          'time': '${_selectedTime.format(context)}',
                          'date': '${_selectedDate1.day}',
                          'month': '${_selectedDate1.month}',
                          'year': '${_selectedDate1.year}',
                        }) // <-- Updated data
                            .then((_) => print('Success'))
                            .catchError((error) => print('Failed: $error'));

                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.leftToRight,
                            isIos: true,
                            child: Bottomnavigation(index: 0),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list_a.first;


  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Padding(
        padding: EdgeInsets.only(left: 180),
        child: Icon(
          Icons.arrow_drop_down,
          color: Colors.green,
          size: 30,
        ),
      ),
      elevation: 16,
      style: const TextStyle(
          color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
      underline: Container(
        height: 0,
        color: Colors.white,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          App_Text.category = dropdownValue;
        });
      },
      items: list_a.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropdownButton_B extends StatefulWidget {
  const DropdownButton_B({super.key});

  @override
  State<DropdownButton_B> createState() => _DropdownButton_BState();
}

class _DropdownButton_BState extends State<DropdownButton_B> {
  String dropdownValue = list_b.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Padding(
        padding: EdgeInsets.only(left: 200),
        child: Icon(
          Icons.arrow_drop_down,
          color: Colors.green,
          size: 30,
        ),
      ),
      elevation: 16,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      underline: Container(
        height: 0,
        color: Colors.white,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list_b.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}