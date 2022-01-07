import 'dart:async';

import 'package:drivo/core/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color selectedColor = Colors.white;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 1), () {
      setState(() {
        selectedColor = kAppPrimaryColor;
      });
      _timer.cancel();
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
                  width: Get.width * .9))),
    );
  }
}
