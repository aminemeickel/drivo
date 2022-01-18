import 'dart:ui';

import 'package:drivo/Models/order.dart';
import 'package:drivo/Utils/utils.dart';
import 'package:drivo/component/location_map.dart';
import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/controllers/order_controller.dart';
import 'package:drivo/controllers/store_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/core/log.dart';
import 'package:drivo/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

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
  var store = Get.find<StoreController>();
  var storeLocation = Get.find<StoreController>().store.value.storeLocation;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.5),
          toolbarHeight: 65,
          leading: imageFromassets('logo_red.png',
                  width: 20, height: 20, fit: BoxFit.fitWidth)
              .paddingOnly(left: 10),
          leadingWidth: 100,
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
      bottomSheet: null,
      body: Obx(
        () => orderController.isLoading.isTrue
            ? const Center(child: CircularProgressIndicator.adaptive())
            : Column(
                mainAxisAlignment: listView
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  if (!listView) const LocationMap(useOpenStreatMap: false),
                  Obx(
                    () => orderController.ready.isEmpty && listView
                        ? const Center(
                            child: Text('No orders!!',
                                style: TextStyle(fontSize: 22)))
                        : Expanded(
                            child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: orderController.orders.length,
                            itemBuilder: (context, index) => ItemTile(
                                order: orderController.orders.elementAt(index),
                                storeLocation: storeLocation),
                            separatorBuilder: (context, index) =>
                                const Divider(),
                          )),
                  ),
                ],
              ),
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

  final LatLng? storeLocation;
  const ItemTile({Key? key, required this.order, this.storeLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Log.verbose(order.status);
        Get.toNamed(ItemViewer.id, arguments: order);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _orderStatus == OrderStatus.Transit
                    ? 'In Transit'
                    : _orderStatus.name,
                style: TextStyle(
                    color: _statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              const Spacer(),
              imageFromassets('clock.png', width: 15, height: 15),
              Text(
                timeago.format(DateTime.parse(order.scheduleAt!)),
                style: const TextStyle(color: Color(0xFF392726)),
              ).paddingOnly(left: 5)
            ],
          ),
          Row(
            children: [
              Text(
                '${order.buyer.upper()} -Order #${order.localId}',
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
                    child: Text(order.pickupType.upper(),
                        style: const TextStyle(
                            color: kAppPrimaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    width: 30,
                    height: 20,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: () {
                          Get.toNamed(ItemViewer.id, arguments: order);
                        },
                        icon: const Icon(Icons.arrow_forward_ios,
                            color: kAppPrimaryColor, size: 20)),
                  )
                ],
              ),
            ],
          ).paddingOnly(top: 10, bottom: 5),
          Row(
            children: getRow(),
          ),
        ],
      ).paddingSymmetric(horizontal: 10, vertical: 8),
    );
  }

  OrderStatus get _orderStatus {
    if (order.customerLocation != null && storeLocation != null) {
      var distance = calculateDistance(order.customerLocation!, storeLocation!);
      if (distance <= 1) return OrderStatus.Arrived;
      if (distance <= 5) return OrderStatus.Approaching;
    }
    return OrderStatus.Transit;
  }

  Color get _statusColor {
    switch (_orderStatus) {
      case OrderStatus.Approaching:
        return kAppsecondryColor;
      case OrderStatus.Transit:
        return const Color(0xFF666666);
      default:
        return kAppPrimaryColor;
    }
  }

  String get timeState => '';

  List<Widget> getRow() {
    switch (_orderStatus) {
      case OrderStatus.Arrived:
        return [
          imageFromassets(getImage(), width: 20, height: 20)
              .paddingOnly(right: 7),
          Flexible(
            child: Text(
                order.transportation == 'VEHICLE'
                    ? order.transportationModel.upper()
                    : order.transportation.upper(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          if (order.transportation == 'VEHICLE' && order.colour != null)
            Flexible(child: Text(order.colour.upper()).paddingOnly(left: 3)),
          if (order.licensePlate != null && order.licensePlate!.isNotEmpty)
            imageFromassets('plate.png', width: 22, height: 22)
                .paddingOnly(left: 7, right: 7),
          Text(order.licensePlate!,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ];

      case OrderStatus.Approaching:
      case OrderStatus.Transit:
        return [
          imageFromassets('call.png', width: 22, height: 22),
          Text('(408)-${order.orderNumber!}').paddingOnly(left: 10, top: 5)
        ];
    }
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
