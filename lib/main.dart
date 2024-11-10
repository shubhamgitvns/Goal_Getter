import 'dart:ui' as ui;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'api/firebase_api.dart';
import 'app_text_var.dart';
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
  //print(App_Text.local_version);
  print("search");
  var list = await DatabaseHandler.jsons();
  List<Json> lst = list;
  print(lst);

  if (lst.length == 0) {
    var javabook = Json(App_Text.id, App_Text.version, App_Text.json_data);
    await DatabaseHandler.insertJson(javabook);
    print(await DatabaseHandler.jsons());
  }
  list = await DatabaseHandler.jsons();
  lst = list;
  print("search");
  App_Text.local_version = lst.first.version;
  App_Text.db_json_data = lst.last.json_data;
  print(App_Text.local_version);
  print(App_Text.db_json_data);
  //********************Download throw the internet*********************//

  try {
    dynamic text =
        await Utilities.Downloaddata("/ecommerce/assets/version.json");
    App_Text.new_version = ("${text["version"]}");
    print("the new version ${App_Text.new_version}");
    print(App_Text.new_version.runtimeType);
  } catch (ex) {
    print(ex);
  }
  int intversion = int.parse(App_Text.new_version);
  print("The new version $intversion");
  print("The local version ${App_Text.local_version}");

  if (intversion > App_Text.local_version) {
    print("Yes its greater");
    App_Text.version = intversion;
    print(App_Text.version);

    try {
      dynamic text =
          await Utilities.Downloaddata("/ecommerce/assets/products.json");
      App_Text.json_data = "${text["sarees"]}";
      print("the new String ${App_Text.json_data}");
    } catch (ex) {
      print(ex);
    }

    var javabook = Json(App_Text.id, App_Text.version, App_Text.json_data);
    await DatabaseHandler.updateJson(javabook);
    print(await DatabaseHandler.jsons());
    print("Update");
  }

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
