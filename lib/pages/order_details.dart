import 'package:drivo/Models/detail_items.dart';
import 'package:drivo/Models/order.dart';
import 'package:drivo/Utils/utils.dart';
import 'package:drivo/component/main_button.dart';
import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:drivo/controllers/order_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/core/log.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  static const id = '/order/details';
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int mints = 0;
  Order? order;
  RxBool updating = false.obs;
  RxBool cancel = false.obs;
  @override
  void initState() {
    super.initState();
    order = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    var orderStatus = order!.status!.toLowerCase();
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const AppNavigationBar(position: 1),
        bottomSheet: order != null &&
                orderStatus != 'canceled' &&
                orderStatus != 'completed'
            ? Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 0.1)
                ]),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (orderStatus == 'approved')
                      SizedBox(
                        width: Get.width / 2,
                        height: 60,
                        child: MainButtonSecondary(
                          text: Obx(() => Text(
                              cancel.isTrue ? 'Updating...' : 'Cancel',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: kAppPrimaryColor,
                                  fontWeight: FontWeight.w600))),
                          onpressd: () async {
                            if (updating.isTrue || cancel.isTrue) return;
                            cancel(true);
                            var response = await ApiService.updateOrderStatus(
                                order!.orderId!, 'canceled');
                            if (response) {
                              await Get.find<OrderController>().onReady();
                              cancel(false);
                              Get.back();
                              Fluttertoast.showToast(msg: 'Order canceld!');
                              return;
                            }
                            cancel(false);
                            Fluttertoast.showToast(
                                msg: 'Error please try again!');
                          },
                        ).paddingSymmetric(vertical: 9, horizontal: 10),
                      ),
                    SizedBox(
                      width: order!.status!.toLowerCase() == 'approved'
                          ? (Get.width / 2)
                          : Get.width * .9,
                      height: 60,
                      child: MainButton(
                        text: Obx(() => Text(
                            updating.isTrue
                                ? 'Updating..'
                                : 'Mark as ${order!.status!.toLowerCase() == 'approved' ? 'Ready' : 'Completed'}',
                            style: const TextStyle(fontSize: 18))),
                        onpressd: () async {
                          if (updating.isTrue) return;
                          updating(true);
                          var response = await ApiService.updateOrderStatus(
                              order!.orderId!,
                              orderStatus == 'approved'
                                  ? 'delivery'
                                  : 'completed');
                          if (response) {
                            await Get.find<OrderController>().onReady();
                            updating(false);
                            Get.back();
                            Fluttertoast.showToast(msg: 'Status Updated');
                            return;
                          }
                          updating(false);
                          Fluttertoast.showToast(
                              msg: 'Error please try again!');
                        },
                      ).paddingSymmetric(vertical: 9, horizontal: 10),
                    ),
                  ],
                ),
              )
            : null,
        body: order == null
            ? const Center(child: Text('No info!'))
            : Column(children: [
                _OrderHeader(order: order!),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('FOOD ITEMS',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                ).paddingOnly(left: 10, bottom: 10),
                Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        padding: EdgeInsets.zero,
                        itemCount: order!.detailItem!.length,
                        itemBuilder: (context, index) => _OrderTile(
                            detailItem: order!.detailItem!.elementAt(index)))),
                const SizedBox(height: 70)
              ]));
  }

  getButtonText() {
    if (order != null) {
      switch (order!.status) {
        case 'approved':
          return {'Cancel': 'Mark as Ready'};
      }
    }
  }
}

class _OrderTile extends StatelessWidget {
  final DetailItem detailItem;

  const _OrderTile({Key? key, required this.detailItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(detailItem.picture!,
            width: 80,
            height: 100,
            fit: BoxFit.fitHeight,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error)).paddingOnly(left: 10, right: 15),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 5),
          Text('${detailItem.qty}x ${detailItem.itemName}',
              style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          if (detailItem.extras != null && detailItem.extras!.isNotEmpty)
            ...detailItem.extras!.map((e) => Text('+ ${e.name!}'))
        ])),
        Text(
          '₽${detailItem.netto}',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: kAppPrimaryColor,
              fontSize: 16),
        ).paddingOnly(top: 8, right: 10)
      ],
    );
  }
}

class _OrderHeader extends StatelessWidget {
  final Order order;
  const _OrderHeader({Key? key, required this.order}) : super(key: key);

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
              imageFromassets('logo_red.png',
                  width: 80, height: 40, fit: BoxFit.fitWidth),
            ],
          ),
          const Divider(thickness: 1.5),
          Row(children: [
            const Text('Order Details',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: kAppPrimaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                order.pickupType.upper(),
                style: const TextStyle(
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
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(children: [
                  getImage(order.transportation!),
                  Text(order.transportation.upper(),
                          style: const TextStyle(
                              color: kAppPrimaryColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600))
                      .paddingOnly(left: 5)
                ]))
          ]),
          const SizedBox(height: 10),
          Row(
            children: [
              imageFromassets('person.png', width: 20, height: 20)
                  .paddingOnly(left: 5, right: 7),
              Text(order.buyer ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              imageFromassets('clock.png',
                  color: kAppPrimaryColor, height: 20, width: 20),
              const SizedBox(width: 5),
              Text(DateFormat.jm().format(DateTime.parse(order.createdAt!)),
                  style: const TextStyle(fontWeight: FontWeight.w700))
            ],
          ),
          const SizedBox(height: 15)
        ],
      ).marginSymmetric(horizontal: 8),
    );
  }

  //it can be better
  Widget getImage(String transportation) {
    switch (transportation) {
      case 'VEHICLE':
        return imageFromassets('car_side.png', width: 20, height: 20);
      case 'BICYLE':
        return imageFromassets('bike.png', width: 20, height: 20);
      case 'WALKING':
        return imageFromassets('walk.png', width: 20, height: 20);
      default:
        return const SizedBox.shrink();
    }
  }
}
