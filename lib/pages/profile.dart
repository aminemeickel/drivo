import 'dart:developer';

import 'package:drivo/Models/store.dart';
import 'package:drivo/Models/user.dart';
import 'package:drivo/Utils/utils.dart';
import 'package:drivo/component/main_button.dart';
import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:drivo/controllers/order_controller.dart';
import 'package:drivo/controllers/store_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/core/log.dart';
import 'package:drivo/core/storage.dart';
import 'package:drivo/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  User get user => storeController.user.value;
  bool isOpen = false;
  RxBool isEnglish = false.obs;
  final RxBool _langugeUpdating = false.obs;
  @override
  void initState() {
    super.initState();
    isEnglish(user.lang == 'english');

    setState(() {
      isOpen = store.active!;
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
                  RowTile(iconName: 'account.png', text: user.fullname ?? ''),
                  const Divider(thickness: 1.1),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 15),
                      imageFromassets('clock.png',
                          color: kAppPrimaryColor, width: 25, height: 25),
                      const SizedBox(width: 10),
                      BoxTile(
                          text: 'OPEN',
                          value: isOpen,
                          onChanged: (val) async {
                            setState(() {
                              isOpen = val!;
                            });
                            await Fluttertoast.showToast(msg: 'No Api Found');
                          }),
                      BoxTile(
                          text: 'CLOSE',
                          value: !isOpen,
                          onChanged: (val) async {
                            setState(() {
                              isOpen = val!;
                            });
                            await Fluttertoast.cancel();
                            await Fluttertoast.showToast(
                                msg: 'No Api to Found');
                          })
                    ],
                  ),
                  const Divider(thickness: 1.1).paddingOnly(top: 10),
                  RowTile(
                      iconName: 'location_store.png',
                      text: '${store.storeName}'.toUpperCase()),
                  const Divider(thickness: 1.1).paddingOnly(top: 10),
                  RowTile(
                      iconName: 'location.png',
                      text: '${store.fullAddress}'.toUpperCase()),
                  const Divider(thickness: 1.1).paddingOnly(top: 10),
                  RowTile(
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
                      Obx(() => BoxTile(
                          text: 'RU',
                          value: isEnglish.isFalse,
                          onChanged: updateLang)),
                      Obx(
                        () => BoxTile(
                            text: 'EN',
                            value: isEnglish.isTrue,
                            onChanged: updateLang),
                      )
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
                ]),
        ));
  }

  Future<void> updateLang(bool? val) async {
    var updated = await ApiService.updateLanguge(
        isEnglish.isTrue ? 'russian' : 'english', user.fullname!);
    if (updated) {
      await storeController.onReady();
      isEnglish(user.lang == 'english');
    }
    _langugeUpdating(false);
  }
}

class RowTile extends StatelessWidget {
  final String iconName;
  final String text;
  final bool trailing;
  const RowTile({
    required this.iconName,
    required this.text,
    this.trailing = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class BoxTile extends StatelessWidget {
  final String text;
  final ValueChanged<bool?>? onChanged;
  final bool value;
  const BoxTile(
      {Key? key, required this.text, this.onChanged, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            value: value,
            onChanged: onChanged,
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
}
