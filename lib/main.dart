import 'package:drivo/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Drivo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(bodyText1: TextStyle(fontWeight: FontWeight.bold)),
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
