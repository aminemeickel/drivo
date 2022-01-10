import 'package:drivo/Utils/utils.dart';
import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Orders extends StatelessWidget {
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
                      imageFromassets('drivo_car_full.png',
                              width: 100, height: 40, fit: BoxFit.fitWidth)
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
                              fontFamily: 'Montserrat'),
                          tabs: [
                            Tab(text: 'pending'.toUpperCase()),
                            Tab(text: 'ready'.toUpperCase()),
                            Tab(text: 'completed'.toUpperCase()),
                            Tab(text: 'cancelled'.toUpperCase()),
                          ])
                    ])),
            Expanded(
              child: TabBarView(
                  children: List.generate(
                      4,
                      (index) => ListView.separated(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: 20,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const Divider(thickness: 0.5),
                          itemBuilder: (_, index) => const _OrderTile()))),
            ),
          ])),
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: const Text('Justin Folley',
            style: TextStyle(
                color: Color(0xFF392726), fontWeight: FontWeight.w700)),
        subtitle: const Text('Order #44354'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              '\$14.90',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kAppPrimaryColor),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 104,
              child: Row(
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
                  InkWell(
                      onTap: () {
                        Get.toNamed(OrderDetails.id);
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
