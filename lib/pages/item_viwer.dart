import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/core/app.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ItemViewer extends StatefulWidget {
  static const id = '/viewer';
  const ItemViewer({Key? key}) : super(key: key);

  @override
  _ItemViewerState createState() => _ItemViewerState();
}

class _ItemViewerState extends State<ItemViewer> {
  final card = {
    'Phone': 'call_out.png',
    'Details': 'documnt.png',
    'Message': 'messages.png',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const AppNavigationBar(),
      body: Column(
        children: [
          const _ItemViewerHeader(),
          SizedBox(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 5,
              minLeadingWidth: 20,
              leading:
                  Image.asset('$kIconsPath/wait.png', width: 23, height: 23),
              title: const Text(
                'Waiting',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Text('1 mins'),
            ),
          ),
          const Divider(thickness: 1.1).paddingSymmetric(horizontal: 15),
          SizedBox(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 5,
              minLeadingWidth: 25,
              leading: Image.asset('$kIconsPath/calander.png',
                  width: 20, height: 20),
              title: const Text('Scheduled',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              trailing: SizedBox(
                width: 88,
                child: Row(
                  children: [
                    const Text('4:55 pm'),
                    const SizedBox(width: 5),
                    Image.asset('$kIconsPath/edit.png', width: 25, height: 25)
                  ],
                ),
              ),
            ),
          ).paddingOnly(bottom: 5),
          const Divider(thickness: 1.1).paddingSymmetric(horizontal: 15),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: card.keys
                .map((item) => Container(
                      width: Get.width / 3.5,
                      height: 130,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: item == 'Details'
                              ? kAppPrimaryColor
                              : kAppsecondryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('$kIconsPath/${card[item]}',
                              width: 34, height: 35),
                          const SizedBox(height: 25),
                          Text(item,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: item == 'Details'
                                      ? Colors.white
                                      : kAppPrimaryColor)),
                          const SizedBox(height: 15)
                        ],
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class _ItemViewerHeader extends StatelessWidget {
  const _ItemViewerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(10)),
      shadowColor: Colors.black.withOpacity(0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kToolbarHeight),
          Row(
            children: [
              SizedBox(
                width: 30,
                child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios,
                        color: kAppPrimaryColor)),
              ),
              Image.asset('$kIconsPath/drivo_car_full.png',
                  width: 100, height: 40, fit: BoxFit.fitWidth),
            ],
          ),
          const Divider(thickness: 1.5),
          Row(children: [
            const Text('1 customer has arrived',
                style: TextStyle(
                    color: kAppPrimaryColor, fontWeight: FontWeight.w600)),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: kAppPrimaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: const Text(
                'Curbside',
                style: TextStyle(
                    color: kAppPrimaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                    color: kAppPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(children: [
                  Image.asset('$kIconsPath/car_side.png',
                      width: 30, height: 30),
                  const Text('Driving',
                          style: TextStyle(
                              color: kAppPrimaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600))
                      .paddingOnly(left: 5)
                ]))
          ]),
          const SizedBox(height: 10),
          const Text('Elizabeth bradely',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          const Text('Order # 9df69644',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset('$kIconsPath/car.png', width: 20, height: 20)
                  .paddingOnly(right: 7),
              const Flexible(
                child: Text('Toyota Corolla Silver',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Image.asset('$kIconsPath/plate.png', width: 22, height: 22)
                  .paddingOnly(left: 7, right: 7),
              const Text('LQR445',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ).paddingOnly(top: 3),
          const SizedBox(height: 15)
        ],
      ).marginSymmetric(horizontal: 8),
    );
  }
}
