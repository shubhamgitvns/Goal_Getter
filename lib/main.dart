import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todocreater/app_text_var.dart';

import 'api/firebase_api.dart';
import 'downloder.dart';
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

  try {
    dynamic text =
        await Utilities.Downloaddata("/ecommerce/assets/products.json");
    App_Text.json_data = ("${text["sarees"]}");
    App_Text.new_version = ("${text["no"]}");
    // App_Text.name = ("${text["username"]}");
  } catch (ex) {
    print(ex);
  }

  print(App_Text.new_version);

  print(App_Text.old_version);

  if (App_Text.new_version != App_Text.old_version) {
    App_Text.old_version = App_Text.new_version;
    //convert string data to int data
    App_Text.version = int.tryParse(App_Text.old_version)!;

    App_Text.db_json_data = App_Text.json_data;
    print("Come");

    var javabook = Json(App_Text.version, App_Text.json_data);
    await DatabaseHandler.updateJson(javabook);
    print(await DatabaseHandler.jsons());
    print("Update");

    // print("search");
    // var list = await DatabaseHandler.jsons();
    // List<Json> lst = list;
    // print(list);
  }
  print(App_Text.version);
  print(App_Text.db_json_data);

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
