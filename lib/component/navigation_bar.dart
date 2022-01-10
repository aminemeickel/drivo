import 'package:drivo/Utils/utils.dart';
import 'package:drivo/core/app.dart';

import 'package:drivo/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigationBar extends StatelessWidget {
  final int position;
  const AppNavigationBar({Key? key, this.position = 0})
      : assert(position < 3),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedLabelStyle: const TextStyle(color: kAppPrimaryColor),
      currentIndex: position,
      unselectedLabelStyle: const TextStyle(color: Color(0xFFBFBFBF)),
      selectedItemColor: kAppPrimaryColor,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.offNamed(HomePage.id);
            break;
          case 1:
            Get.offNamed(Orders.id);
            break;
          case 2:
            Get.offNamed(Profile.id);
            break;
          default:
        }
      },
      items: [
        _navigatinBarItemBuilder('home.png', 'Home'),
        _navigatinBarItemBuilder('orders.png', 'Orders'),
        _navigatinBarItemBuilder('account.png', 'Account'),
      ],
    );
  }

  BottomNavigationBarItem _navigatinBarItemBuilder(
      String imageName, String label) {
    return BottomNavigationBarItem(
        icon: imageFromassets(imageName,
            width: 25, height: 25, color: const Color(0xFFC4C4C4)),
        activeIcon: imageFromassets(imageName,
            width: 28, height: 28, color: kAppPrimaryColor),
        label: label);
  }
}
