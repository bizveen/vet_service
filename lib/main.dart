

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'auth_gate.dart';
import 'controllers/initial_bindings.dart';
import 'firebase_options.dart';
import 'my_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // if (Firebase.apps.isNotEmpty) {
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // }else{
  //   Firebase.app();
  // }
//  FirebaseDatabase.instance.setPersistenceEnabled(true);
  await GetStorage.init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Client Care App',
      theme: MyTheme().getTheme(),
      home: SafeArea(child: AuthGate()),
    );
  }
}
