import 'dart:ui';

import 'package:drivo/Models/order.dart';
import 'package:drivo/Utils/utils.dart';
import 'package:drivo/component/main_button.dart';
import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:drivo/controllers/order_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/pages/order_details.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

int _selectedMins = 0;

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
  };
  final RxBool _updating = false.obs;
  final RxBool _fatching = false.obs;
  Order? order;
  @override
  void initState() {
    order = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const AppNavigationBar(),
      bottomSheet: order == null
          ? null
          : Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 0.1)
              ]),
              width: Get.width,
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width / 2,
                    height: 60,
                    child: MainButtonSecondary(
                      text: const Text('Cancel',
                          style: TextStyle(
                              fontSize: 18,
                              color: kAppPrimaryColor,
                              fontWeight: FontWeight.w600)),
                      onpressd: () {
                        Get.back();
                      },
                    ).paddingSymmetric(vertical: 9, horizontal: 10),
                  ),
                  SizedBox(
                    width: Get.width / 2,
                    height: 60,
                    child: MainButton(
                        text: Obx(
                          () => Text(
                              _updating.isTrue ? 'Updating...' : 'Complete',
                              style: const TextStyle(fontSize: 18)),
                        ),
                        onpressd: () async {
                          if (_updating.isTrue) return;
                          _updating(true);
                          var response = await ApiService.updateOrderStatus(
                              order!.orderId!, 'completed');
                          if (response) {
                            await Get.find<OrderController>().onReady();
                            _updating(false);
                            Get.back();
                            Fluttertoast.showToast(msg: 'Status Updated');
                            return;
                          }
                          _updating(false);
                          Fluttertoast.showToast(
                              msg: 'Error please try again!');
                        }).paddingSymmetric(vertical: 9, horizontal: 10),
                  ),
                ],
              ),
            ),
      body: Column(
        children: [
          _ItemViewerHeader(order: order!),
          SizedBox(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 5,
              minLeadingWidth: 20,
              leading: imageFromassets('wait.png', width: 23, height: 23),
              title: const Text(
                'Waiting',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Text(
                  '${DateTime.now().difference(DateTime.parse(order!.scheduleAt!)).inMinutes} mins'),
            ),
          ),
          const Divider(thickness: 1.1).paddingSymmetric(horizontal: 15),
          SizedBox(
            height: 40,
            child: ListTile(
              horizontalTitleGap: 5,
              minLeadingWidth: 25,
              leading: imageFromassets('calander.png', width: 20, height: 20),
              title: const Text('Scheduled',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              trailing: SizedBox(
                width: 88,
                child: Row(
                  children: [
                    Text(DateFormat.jm()
                        .format(DateTime.parse(order!.scheduleAt!))),
                    const SizedBox(width: 5),
                    InkWell(
                        onTap: () async {
                          var selected = await showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (context) => const BottomSheetModel());
                          if (selected != null) {
                            if (selected as int > 0) {
                              Fluttertoast.showToast(msg: '$selected');
                            }
                          }
                        },
                        child:
                            imageFromassets('edit.png', width: 25, height: 25))
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
                .map((item) => GestureDetector(
                      onTap: () async {
                        if (item == 'Details') {
                          await openOrder();
                          return;
                        }
                        callNumber();
                      },
                      child: Container(
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
                            imageFromassets(card[item]!, width: 34, height: 35),
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
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Future<void> openOrder() async {
    _fatching(true);
    Order? selectedOrder = await ApiService.orderById(order!.orderId);
    _fatching(false);
    if (selectedOrder != null) {
      Get.toNamed(OrderDetails.id, arguments: selectedOrder);
    } else {
      _fatching(false);
      Fluttertoast.showToast(msg: 'Order Not found');
    }
  }

  void callNumber() async {
    try {
      await launch('tel:+408${order?.orderNumber!.replaceAll('-', '')}');
    } catch (e) {
      Fluttertoast.showToast(msg: "Can't Open Phone Caller");
    }
  }
}

class BottomSheetModel extends StatefulWidget {
  const BottomSheetModel({Key? key}) : super(key: key);

  @override
  State<BottomSheetModel> createState() => _BottomSheetModelState();
}

class _BottomSheetModelState extends State<BottomSheetModel> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
            height: Get.height * .7,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.close))),
                  const Text('When will this order be ready for pickup?',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16))
                      .paddingOnly(left: 10),
                  Expanded(
                      child: GridView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 2,
                                  childAspectRatio: 16 / 9),
                          itemBuilder: (context, index) {
                            var number = (index + 1) * 5;
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedMins = number;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: _selectedMins == number
                                                ? kAppPrimaryColor
                                                : const Color(0xFFD7D7D7)),
                                        borderRadius: BorderRadius.circular(5)),
                                    alignment: Alignment.center,
                                    child: Text(
                                        index == 5 ? 'Other' : '$number mins',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: _selectedMins == number
                                                ? kAppPrimaryColor
                                                : Colors.black))));
                          })),
                  const Align(
                          child: Text('Enter Time'),
                          alignment: Alignment.centerLeft)
                      .paddingOnly(left: 20, bottom: 10),
                  SizedBox(
                          height: 50,
                          width: Get.width * .9,
                          child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                _selectedMins = int.tryParse(val) ?? -1;
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  border: _border,
                                  suffixIcon: const Padding(
                                      padding:
                                          EdgeInsets.only(top: 14.0, right: 10),
                                      child: Text('minutes')))))
                      .paddingOnly(bottom: 20),
                  SizedBox(
                      width: Get.width,
                      height: 55,
                      child: MainButton(
                          text: const Text('Confirm time',
                              style: TextStyle(fontSize: 18)),
                          onpressd: () {
                            Get.back(result: _selectedMins);
                          })).paddingSymmetric(horizontal: 20),
                  const SizedBox(height: 10)
                ])));
  }

  InputBorder get _border => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Color(0XFFD7D7D7)));
}

class _ItemViewerHeader extends StatelessWidget {
  final Order order;
  const _ItemViewerHeader({Key? key, required this.order}) : super(key: key);

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
                width: 20,
                height: 40,
                child: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios,
                        color: kAppPrimaryColor)),
              ),
              imageFromassets('logo_red.png',
                      width: 80, height: 40, fit: BoxFit.fitWidth)
                  .paddingOnly(left: 10),
            ],
          ),
          const Divider(thickness: 1.5),
          Row(children: [
            const Text('customer has arrived',
                style: TextStyle(
                    color: kAppPrimaryColor, fontWeight: FontWeight.w600)),
            const Spacer(),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kAppPrimaryColor, width: 1.5),
                    borderRadius: BorderRadius.circular(10)),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text(order.pickupType.upper(),
                    style: const TextStyle(
                        color: kAppPrimaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600))),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                    color: kAppPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(children: [
                  imageFromassets(getImage(), width: 23, height: 23),
                  Text(order.transportation.upper(),
                          style: const TextStyle(
                              color: kAppPrimaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600))
                      .paddingOnly(left: 5)
                ]))
          ]),
          const SizedBox(height: 10),
          Text(order.buyer.upper(),
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          Text('Order #${order.localId}', style: const TextStyle(fontSize: 17)),
          const SizedBox(height: 10),
          Row(
            children: [
              imageFromassets(getImage(), width: 25, height: 25)
                  .paddingOnly(right: 7),
              Flexible(
                child: Text(
                    order.transportation == 'VEHICLE'
                        ? order.transportationModel.upper()
                        : order.transportation.upper(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              if (order.transportation == 'VEHICLE' && order.colour != null)
                Flexible(
                    child: Text(order.colour.upper()).paddingOnly(left: 3)),
              if (order.licensePlate != null && order.licensePlate!.isNotEmpty)
                imageFromassets('plate.png', width: 22, height: 22)
                    .paddingOnly(left: 7, right: 7),
              Text(order.licensePlate!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ).paddingOnly(top: 3),
          const SizedBox(height: 15)
        ],
      ).marginSymmetric(horizontal: 8),
    );
  }

  String getImage() {
    switch (order.transportation) {
      case 'VEHICLE':
        return 'car_side.png';
      case 'BICYLE':
        return 'bike.png';
      case 'WALKING':
        return 'walk.png';
      default:
        return 'woman.png';
    }
  }
}
