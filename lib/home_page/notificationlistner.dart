import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationListScreen extends StatelessWidget {
  Future<List<String>> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('notifications') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: loadNotifications(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final notifications = snapshot.data ?? [];
        if (notifications.isEmpty) {
          return Center(child: Text('No notifications received'));
        }
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              color: Colors.blue,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image.network(
                          "https://plus.unsplash.com/premium_photo-1661878265739-da90bc1af051?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZGlnaXRhbCUyMHRlY2hub2xvZ3l8ZW58MHx8MHx8fDA%3D",
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                    ],
                  ),
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
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 70),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Name",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.indigo),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Uploading on",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(color: Colors.blue)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text(
                                            "Carvars Painting",
                                            style: TextStyle(
                                                color: Colors.indigo,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
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
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.remove_red_eye_outlined),
                              Text("2.14 K"),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.message),
                              Text("2"),
                            ],
                          ),
                          // List of Notifications
                          Expanded(
                            child: ListView.builder(
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                final parts = notifications[index].split('|');
                                return ListTile(
                                  title: Text(parts[0]),
                                  subtitle: Text(parts[1]),
                                  trailing: Text(parts[2]),
                                );
                              },
                            ),
                          ),
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
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                  const BorderSide(color: Colors.grey),
                                ),
                                hintText: "Enter Task",
                                hintStyle: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(50)),
                          child: InkWell(
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}


class UserInterface extends StatefulWidget {
  const UserInterface({super.key});

  @override
  State<UserInterface> createState() => _UserInterfaceState();
}

class _UserInterfaceState extends State<UserInterface> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
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
                        ),
                        SingleChildScrollView(
                          child: Text("njxncjxbchxbx")
                        )
                        //NotificationListScreen()
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

