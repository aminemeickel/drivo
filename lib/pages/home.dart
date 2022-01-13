import 'package:drivo/Models/order.dart';
import 'package:drivo/Utils/utils.dart';
import 'package:drivo/component/location_map.dart';
import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/controllers/order_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  static const id = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool listView = true;
  int position = 0;
  var orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.5),
          toolbarHeight: 70,
          leading: imageFromassets('drivo_car_full.png').paddingOnly(left: 10),
          leadingWidth: 230,
          actions: [
            _AppBarButton(
                text: 'List View',
                padding: true,
                isSelected: listView,
                onPress: () {
                  setState(() {
                    listView = true;
                  });
                }),
            _AppBarButton(
                text: 'Map View',
                padding: false,
                isSelected: !listView,
                onPress: () {
                  setState(() {
                    listView = false;
                  });
                }),
            const SizedBox(width: 8)
          ],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7)))),
      bottomNavigationBar: const AppNavigationBar(),
      // bottomSheet: Container(
      //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //     BoxShadow(
      //         color: Colors.black.withOpacity(0.1),
      //         blurRadius: 10,
      //         spreadRadius: 0.1)
      //   ]),
      //   width: Get.width,
      //   height: 65,
      //   child: MainButton(
      //     text: const Text('Add New', style: TextStyle(fontSize: 18)),
      //     onpressd: () async {
      //       await ApiService.orders();
      //     },
      //   ).paddingSymmetric(vertical: 10, horizontal: 15),
      // ),
      body: Column(
        children: [
          if (!listView) const LocationMap(),
          Obx(
            () => Expanded(
                child: ListView.separated(
              shrinkWrap: true,
              itemCount: orderController.orders.length,
              itemBuilder: (context, index) => ItemTile(
                order: orderController.orders.elementAt(index),
              ),
              separatorBuilder: (context, index) => const Divider(),
            )),
          ),
          const SizedBox(height: 70)
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final bool isSelected;
  final double width;
  final bool padding;
  const _AppBarButton(
      {required this.text,
      required this.onPress,
      required this.isSelected,
      required this.padding,
      this.width = 80,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPress,
        child: Text(text,
            style: TextStyle(
                fontSize: 13,
                color: isSelected ? Colors.white : kAppPrimaryColor)),
        style: ElevatedButton.styleFrom(
            primary: isSelected ? kAppPrimaryColor : kAppsecondryColor,
            padding: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                    left: padding ? const Radius.circular(5) : Radius.zero,
                    right: padding ? Radius.zero : const Radius.circular(5)))),
      ).paddingSymmetric(vertical: 18),
    );
  }
}

class ItemTile extends StatelessWidget {
  final Order order;
  final String status;
  const ItemTile({Key? key, this.status = 'Arrived', required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              status,
              style: const TextStyle(
                  color: kAppPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            const Spacer(),
            imageFromassets('clock.png', width: 15, height: 15),
            const Text(
              'just now',
              style: TextStyle(color: Color(0xFF392726)),
            ).paddingOnly(left: 10)
          ],
        ),
        Row(
          children: [
            Text(
              '${order.buyer} -Order #${order.orderNumber}',
              style: const TextStyle(color: Color(0xFF392726)),
            ).paddingOnly(top: 5),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: kAppPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: const Text(
                    'Curbside',
                    style: TextStyle(
                        color: kAppPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 20,
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                      onPressed: () {
                        Get.toNamed(ItemViewer.id);
                      },
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: kAppPrimaryColor, size: 20)),
                )
              ],
            ),
          ],
        ).paddingOnly(top: 10, bottom: 5),
        Row(
          children: [
            imageFromassets('car.png', width: 20, height: 20)
                .paddingOnly(right: 7),
            const Flexible(
              child: Text('Toyota Corolla Silver',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            imageFromassets('plate.png', width: 22, height: 22)
                .paddingOnly(left: 7, right: 7),
            const Text('LQR445', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ).paddingOnly(top: 3),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 8);
  }
}
