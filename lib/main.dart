import 'package:drivo/core/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'pages.dart';

void main() async {
  await GetStorage.init('main');
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
        GetPage(
            name: HomePage.id,
            page: () => const HomePage(),
            curve: Curves.easeIn),
        GetPage(
            name: Profile.id,
            page: () => const Profile(),
            curve: Curves.easeIn),
        GetPage(
            name: Orders.id, page: () => const Orders(), curve: Curves.easeIn),
        GetPage(
            name: ItemViewer.id,
            page: () => const ItemViewer(),
            curve: Curves.easeIn),
        GetPage(
            name: OrderDetails.id,
            page: () => const OrderDetails(),
            curve: Curves.easeIn),
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
