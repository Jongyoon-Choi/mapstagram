import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mapstagram/firebase_options.dart';
import 'package:mapstagram/src/pages/root.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/binding/init_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      initialBinding: Initbinding(),
      home: const Root(),
    );
  }
}
