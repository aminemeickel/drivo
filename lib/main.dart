import 'package:drivo/core/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: APPNAME,
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: SplashScreen.id, page: () => const SplashScreen()),
        GetPage(name: Login.id, page: () => const Login()),
      ],
      theme: ThemeData(
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
              bodyText1: TextStyle(fontWeight: FontWeight.bold)),
          primarySwatch: Colors.blue),
      initialRoute: '/splash',
    );
  }
}
