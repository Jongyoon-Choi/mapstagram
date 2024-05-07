import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:mapstagram/firebase_options.dart';
import 'package:mapstagram/src/pages/root.dart';
import 'package:get/get.dart';
import 'package:mapstagram/src/binding/init_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // 지도 초기화
  await NaverMapSdk.instance.initialize(
      clientId: 'nqtyabefq7',
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
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
