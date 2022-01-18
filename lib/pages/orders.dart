import 'package:drivo/Models/order.dart';
import 'package:drivo/Utils/utils.dart';
import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:drivo/controllers/order_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Orders extends GetView<OrderController> {
  static const id = '/orders';
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: const AppNavigationBar(position: 1),
          body: Column(children: [
            Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(5)),
                shadowColor: Colors.black.withOpacity(0.4),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: kToolbarHeight),
                      imageFromassets('logo_red.png',
                              width: 90, height: 40, fit: BoxFit.fitWidth)
                          .paddingOnly(left: 10),
                      const Text('Manage orders',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700))
                          .paddingOnly(left: 10),
                      const Divider(thickness: 1.5),
                      TabBar(
                          indicatorColor: kAppPrimaryColor,
                          isScrollable: true,
                          labelColor: kAppPrimaryColor,
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'GothamPro'),
                          tabs: [
                            Tab(text: 'pending'.toUpperCase()),
                            Tab(text: 'ready'.toUpperCase()),
                            Tab(text: 'completed'.toUpperCase()),
                            Tab(text: 'cancelled'.toUpperCase()),
                          ])
                    ])),
            Expanded(
                child: Obx(
              () => TabBarView(children: [
                _tabBuilder(controller.pending),
                _tabBuilder(controller.ready),
                _tabBuilder(controller.completed),
                _tabBuilder(controller.cancelled),
              ]),
            ))
          ])),
    );
  }

  _tabBuilder(RxList<Order> orders) => ListView.separated(
      padding: const EdgeInsets.only(top: 10),
      itemCount: orders.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(thickness: 0.5),
      itemBuilder: (_, index) => _OrderTile(
            order: orders.elementAt(index),
            isWorking: controller.isWorking,
          ));
}

class _OrderTile extends StatelessWidget {
  final Order order;
  final RxBool isWorking;
  const _OrderTile({Key? key, required this.order, required this.isWorking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('${order.buyer}',
            style: const TextStyle(
                color: Color(0xFF392726), fontWeight: FontWeight.w700)),
        subtitle: Text('Order #${order.localId}'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text.rich(
              TextSpan(
                  text: '₽',
                  style: const TextStyle(
                      fontFamily: 'russian',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kAppPrimaryColor),
                  children: [
                    TextSpan(
                        text: ' ${order.netto}',
                        style: const TextStyle(
                            fontFamily: 'GothamPro',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: kAppPrimaryColor))
                  ]),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 104,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: kAppPrimaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      order.pickupType?.upper() ?? '',
                      style: const TextStyle(
                          color: kAppPrimaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  InkWell(
                      onTap: () async {
                        if (isWorking.isTrue) return;
                        isWorking(true);
                        Order? selectedOrder =
                            await ApiService.orderById(order.orderId);
                        isWorking(false);
                        if (selectedOrder != null) {
                          Get.toNamed(OrderDetails.id,
                              arguments: selectedOrder);
                        } else {
                          Fluttertoast.showToast(msg: 'Order Not found');
                        }
                      },
                      child: const Icon(Icons.arrow_forward_ios,
                          size: 18, color: kAppPrimaryColor)),
                ],
              ),
            )
          ],
        ),
        leading: Container(
            width: 50,
            height: 70,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            child: imageFromassets('papier.png'),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kAppsecondryColor)));
  }
}
