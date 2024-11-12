import 'dart:convert';
import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todocreater/functions.dart';

import 'api/firebase_api.dart';
import 'firebase_options.dart';
import 'intropage/intro_page.dart';
import 'jsonclass.dart';
import 'localdb.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  await DatabaseHandler.initialize();

  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    NotificationServices().requestNotificationPermission();
    NotificationServices().InitNotification();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    print(e);
  }
  print("search");
  await initDbData();

  int vnoOnline = await getOnline_Version();
  int vnoLocal = await getLocal_Version();
  print("online V-- $vnoOnline");
  print("local V-- $vnoLocal");

  if (vnoOnline > vnoLocal) {
    // App_Text.version = vnoOnline;
    try {
      print("data kr bare me hh");
      var onlinedata = await getOnlineData();

      int newversion = onlinedata["no"];
      String sarees = jsonEncode(onlinedata["sarees"]);
      await Update_Data(1, newversion, sarees);
      print("update");
      var list = await DatabaseHandler.jsons();
      List<Json> lst = list;
      // String name = lst.first.json_data['name'];
      var obj = jsonDecode(lst.first.json_data);
      print(lst.first.json_data);
      print(obj);
      print(obj.length);
      print(obj['name']);
    } catch (ex) {
      print("Error");
      print(ex);
    }
  }
  // return;

  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  FirebaseAuth.instance.setLanguageCode(ui.window.locale.languageCode);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ECommerceIntroApp(),
      //home: Bottomnavigation(index: 0),
    );
  }
}
