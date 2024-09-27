import 'dart:ui';
import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:todocreater/home_page/home_page.dart';

import '../app_them.dart';
import 'bottombar/bottombar.dart';

const List<String> list_a = <String>[
  'Choose',
  'Personal',
  'Office Work',
  'Workout',
  'Yoga',
  'Sport',
  'Birthday',
  'Other'
];

const List<String> list_b = <String>[
  'None',
  'Hour',
  'Daily',
  'Weekly',
  'Monthly',
  'Yearly',
];

class Add_TaskPage extends StatefulWidget {
  static FirebaseFirestore? firestoredb; //=FirebaseFirestore.instance;

  const Add_TaskPage({super.key});
  @override
  State<Add_TaskPage> createState() => _Add_TaskPageState();
}

class _Add_TaskPageState extends State<Add_TaskPage> {
  DateTime _selectedDate1 = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool meassage = false;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    firebaseInit();
  }

  void firebaseInit() {
    try {
      Add_TaskPage.firestoredb = FirebaseFirestore.instance;
    } catch (ee) {
      print(ee);
    }
  }

  _FirebaseDemoState() {}
  String firebasedata = "data";

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
        App_Text.alrm_year = _selectedDate1.year;
        App_Text.alrm_month = _selectedDate1.month;
        App_Text.alrm_day = _selectedDate1.day;
        print("Updated Date: ${App_Text.alrm_year}-${App_Text.alrm_month}-${App_Text.alrm_day}");
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
        App_Text.alrm_hour = _selectedTime.hour;
        App_Text.alrm_min = _selectedTime.minute;
        print("Updated Time: ${App_Text.alrm_hour}:${App_Text.alrm_min}");
      });
    }
  }
  void setAlarm() async {
    // Update this with the values you get from the DatePicker and TimePicker
    DateTime alarmDateTime = DateTime(
      App_Text.alrm_year,
      App_Text.alrm_month,
      App_Text.alrm_day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final alarmSettings = AlarmSettings(
      id: 2, // Unique alarm ID, update it if needed
      dateTime: alarmDateTime,
      assetAudioPath: 'assets/battle.mp3',
      loopAudio: true,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: 'Check Your Upcoming Task',
      notificationBody: 'Click and go to the App',
      enableNotificationOnKill: Platform.isIOS,
    );

    // Print alarm settings to check if everything is set correctly
    print("Setting alarm for: $alarmDateTime");

    // Call the Alarm.set method to set the alarm
    try {
      await Alarm.set(alarmSettings: alarmSettings);
      print("Alarm set successfully!");
    } catch (e) {
      print("Failed to set alarm: $e");
    }
  }

  void stopAlarm() async {
    try {
      // Call the stop or cancel method provided by the package
      await Alarm.stop(2);
      print("Alarm stopped successfully!");
    } catch (e) {
      print("Failed to stop alarm: $e");
    }
  }

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
          onTap: () {
            //Navigator.pop(context);
            print(App_Text.alrm_year);
            print(App_Text.alrm_month);
            print(App_Text.alrm_day);
            print(_selectedTime.hour);
            print(_selectedTime.minute);
            print(_selectedTime.period);
          },
        ),
        title: const Center(
            child: Text(
              "Add Task",
              style: TextStyle(
                  color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 25),
            )),
      ),
      body: SingleChildScrollView(
        //physics: const BouncingScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
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
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 100),
                                    child: Text(
                                      "Date",
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
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 100),
                                    child: Text(
                                      "Time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width: 170,
                                  height: 65,
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
                                      "Cancel",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20),
                                    ))),
                            onTap: (){
                              stopAlarm();
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
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ))),
                            onTap: () async {
                              print("alarm set");
                              setState(() async {
                                setAlarm();

                              });

                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

            ],
          )),
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
        padding: EdgeInsets.only(left: 150),
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
          print(App_Text.category);
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
          App_Text.repeat_task = dropdownValue;
          print(App_Text.repeat_task);
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

