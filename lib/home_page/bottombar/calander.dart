
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:table_calendar/table_calendar.dart';

import 'bottombar.dart';

class CalanderPage extends StatefulWidget {
  const CalanderPage({super.key});

  @override
  State<CalanderPage> createState() => _CalanderPageState();
}

class _CalanderPageState extends State<CalanderPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focuseDay){
    setState(() {
      today = day;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_circle_left,size: 50,color: Colors.teal,),
          onTap: (){
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                isIos: true,
                child:  Bottomnavigation(index: 2,),
                // FingerPrint(),
              ),
            );
          },
        ),
        title: const Text("Calendar",style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 25),),
      ),
      body:  Column(
        children: [
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 50,
              headerStyle:
              const HeaderStyle(formatButtonVisible: false, titleCentered:  true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day)=> isSameDay(day,today),
              focusedDay: today,
              firstDay: DateTime.utc(2010,10,15),
              lastDay: DateTime.utc(2030,3,14),
              onDaySelected: _onDaySelected,
            ),
          )
        ],
      ),

    );
  }
}
