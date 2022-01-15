import 'package:drivo/Models/store.dart';
import 'package:drivo/Utils/notification.dart';
import 'package:drivo/Utils/utils.dart';
import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/controllers/store_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/core/log.dart';
import 'package:drivo/core/storage.dart';
import 'package:drivo/pages/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  static const id = '/profile';
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late StoreController storeController = Get.find();
  Store get store => storeController.store.value;
  final _isEnabled = [false, false, false, false];
  @override
  void initState() {
    super.initState();
    setState(() {
      if (store.active!) {
        _isEnabled[0] = true;
      } else {
        _isEnabled[1] = true;
      }
      _isEnabled[3] = true;
    });
  }

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
          leading: imageFromassets('logo_red.png', width: 70, height: 70)
              .paddingOnly(left: 10, right: 10),
          elevation: 10,
          leadingWidth: 100,
        ),
        bottomNavigationBar: const AppNavigationBar(position: 2),
        body: Obx(
          () => storeController.isLoading.isTrue
              ? const Center(child: CircularProgressIndicator())
              : Column(children: [
                  const SizedBox(height: 15),
                  _listTileBuilder(
                      iconName: 'account.png', text: store.storeName ?? ''),
                  const Divider(thickness: 1.1),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 15),
                      imageFromassets('clock.png',
                          color: kAppPrimaryColor, width: 25, height: 25),
                      const SizedBox(width: 10),
                      _boxTileBuilder(text: 'OPEN', isEnabled: _isEnabled[0]),
                      _boxTileBuilder(text: 'CLOSE', isEnabled: _isEnabled[1]),
                    ],
                  ),
                  const Divider(thickness: 1.1).paddingOnly(top: 10),
                  _listTileBuilder(
                      iconName: 'location_store.png',
                      text: '${store.storeName}'.toUpperCase()),
                  const Divider(thickness: 1.1).paddingOnly(top: 10),
                  _listTileBuilder(
                      iconName: 'location.png',
                      text: '${store.fullAddress}'.toUpperCase()),
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
                      imageFromassets('clock.png',
                          color: kAppPrimaryColor, width: 25, height: 25),
                      const SizedBox(width: 10),
                      _boxTileBuilder(text: 'RU', isEnabled: _isEnabled[2]),
                      _boxTileBuilder(text: 'EN', isEnabled: _isEnabled[3]),
                    ],
                  ),
                  const Divider(thickness: 1.1).paddingOnly(top: 10),
                  const Spacer(),
                  SizedBox(
                    width: 110,
                    child: IconButton(
                        onPressed: () {
                          Get.deleteAll(force: true);
                          StorageDriver.clear();
                          Get.offAllNamed(Login.id);
                        },
                        icon: Row(children: [
                          const Icon(Icons.exit_to_app,
                              color: kAppPrimaryColor),
                          const Text('Log Out',
                                  style: TextStyle(
                                      color: kAppPrimaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600))
                              .paddingOnly(left: 5)
                        ])),
                  ).paddingOnly(bottom: 40),
                  ElevatedButton(
                      onPressed: () async {
                        Log.verbose(
                            await FirebaseMessaging.instance.getToken());
                      },
                      child: const Text('SHOW NOTIFICATION'))
                ]),
        ));
  }

  SizedBox _boxTileBuilder({required String text, required bool isEnabled}) {
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
            value: isEnabled,
            onChanged: (val) {
              setState(() {
                isEnabled = val!;
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
          leading: imageFromassets(iconName,
              color: kAppPrimaryColor, width: 25, height: 25)),
    );
  }
}
