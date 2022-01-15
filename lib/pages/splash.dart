import 'dart:async';

import 'package:drivo/Utils/notification.dart';
import 'package:drivo/controllers/auth_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color selectedColor = Colors.white;
  int seconds = 0;

  @override
  void initState() {
    super.initState();

    ///Simplest way to do this ... it can be done with future builder but
    /// it will much more complicated

    ///switching the color
    Timer(const Duration(seconds: 1), () {
      seconds++;
      setState(() {
        selectedColor = kAppPrimaryColor;
      });
    });

    ///switching the page
    Future.delayed(const Duration(seconds: 2), () async {
      if (AuthController.isAuthnthicated) {
        AuthController.initControllers();
        await NotificationHandler().initFirebaseMessaging();
        Get.offNamed(HomePage.id);
      } else {
        Get.offNamed(Login.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedContainer(
            color: selectedColor,
            duration: const Duration(milliseconds: 600),
            child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                    'assets/splashScreen/${selectedColor == Colors.white ? "logo_bg_orange" : "logo_bg_white"}.png',
                    width: Get.width * .9))));
  }
}
