import 'dart:ui';

import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/core/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  static const id = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isSlected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.3),
          toolbarHeight: 65,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          leading:
              Image.asset('$kIconsPath/logo_red.png', width: 70, height: 70)
                  .paddingOnly(left: 10, right: 10),
          elevation: 10,
          leadingWidth: 100,
        ),
        bottomNavigationBar: const AppNavigationBar(position: 2),
        body: Column(children: [
          const SizedBox(height: 15),
          _listTileBuilder(iconName: 'account.png', text: 'Jessica Smith'),
          const Divider(thickness: 1.1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 15),
              Image.asset('$kIconsPath/clock.png',
                  color: kAppPrimaryColor, width: 25, height: 25),
              const SizedBox(width: 10),
              _boxTileBuilder(text: 'OPEN'),
              _boxTileBuilder(text: 'CLOSE'),
            ],
          ),
          const Divider(thickness: 1.1).paddingOnly(top: 10),
          _listTileBuilder(
              iconName: 'location_store.png', text: 'Store Name'.toUpperCase()),
          const Divider(thickness: 1.1).paddingOnly(top: 10),
          _listTileBuilder(
              iconName: 'location.png', text: 'full address'.toUpperCase()),
          const Divider(thickness: 1.1).paddingOnly(top: 10),
          _listTileBuilder(
              iconName: 'help.png',
              text: 'Help & support'.toUpperCase(),
              trailing: true),
          const Divider(thickness: 1.1).paddingOnly(top: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 15),
              Image.asset('$kIconsPath/clock.png',
                  color: kAppPrimaryColor, width: 25, height: 25),
              const SizedBox(width: 10),
              _boxTileBuilder(text: 'RU'),
              _boxTileBuilder(text: 'EN'),
            ],
          ),
          const Divider(thickness: 1.1).paddingOnly(top: 10),
          const Spacer(),
          SizedBox(
            width: 110,
            child: IconButton(
                onPressed: () {},
                icon: Row(children: [
                  const Icon(Icons.exit_to_app, color: kAppPrimaryColor),
                  const Text('Log Out',
                          style: TextStyle(
                              color: kAppPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600))
                      .paddingOnly(left: 5)
                ])),
          ).paddingOnly(bottom: 40)
        ]));
  }

  SizedBox _boxTileBuilder({required String text}) {
    return SizedBox(
      height: 40,
      width: 110,
      child: Theme(
        data: ThemeData(
            unselectedWidgetColor: kAppPrimaryColor,
            checkboxTheme: const CheckboxThemeData(
                side: BorderSide(width: 3, color: kAppPrimaryColor))),
        child: ListTileTheme(
          horizontalTitleGap: 0,
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: isSlected,
            onChanged: (val) {
              setState(() {
                isSlected = val!;
              });
            },
            contentPadding: EdgeInsets.zero,
            activeColor: kAppPrimaryColor,
            title: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listTileBuilder(
      {required String iconName, required String text, bool trailing = false}) {
    return SizedBox(
      height: 40,
      child: ListTile(
          dense: true,
          minVerticalPadding: 0,
          title: Text(text,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          horizontalTitleGap: 0,
          trailing: trailing
              ? const Icon(Icons.arrow_forward_ios,
                  color: kAppPrimaryColor, size: 22)
              : null,
          leading: Image.asset('$kIconsPath/$iconName',
              color: kAppPrimaryColor, width: 25, height: 25)),
    );
  }
}
