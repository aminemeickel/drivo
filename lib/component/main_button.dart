import 'package:drivo/core/app.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback? onpressd;
  final Widget text;

  const MainButton({Key? key, required this.text, this.onpressd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressd,
        style: ElevatedButton.styleFrom(
            primary: kAppPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: text);
  }
}

class MainButtonSecondary extends StatelessWidget {
  final VoidCallback? onpressd;
  final Widget text;

  const MainButtonSecondary({Key? key, required this.text, this.onpressd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressd,
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: kAppPrimaryColor, width: 2.1))),
        child: text);
  }
}
