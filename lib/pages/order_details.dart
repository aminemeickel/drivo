import 'package:drivo/Utils/utils.dart';
import 'package:drivo/component/main_button.dart';
import 'package:drivo/component/navigation_bar.dart';
import 'package:drivo/core/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetails extends StatefulWidget {
  static const id = '/order/details';
  const OrderDetails({Key? key}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int mints = 0;
  final card = {
    'Phone': 'call_out.png',
    'Details': 'documnt.png',
    'Message': 'messages.png',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const AppNavigationBar(position: 1),
        bottomSheet: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0.1)
          ]),
          width: Get.width,
          child: SizedBox(
            width: Get.width * .9,
            height: 60,
            child: MainButton(
              text: const Text('Mark as Ready', style: TextStyle(fontSize: 18)),
              onpressd: () {},
            ).paddingSymmetric(vertical: 9, horizontal: 10),
          ),
        ),
        body: Column(children: [
          const _OrderHeader(),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('FOOD ITEMS',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          ).paddingOnly(left: 10, bottom: 10),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => const _OrderTile(),
            itemCount: 20,
          )),
          const SizedBox(height: 70)
        ]));
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(value: false, onChanged: (val) {}),
        Image.asset('assets/dummyData/image 1.png', width: 70, height: 70),
        const SizedBox(width: 10),
        Flexible(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 5),
              Text('1x Chicken Cobb Salad',
                  style: TextStyle(fontWeight: FontWeight.w800)),
              SizedBox(height: 10),
              Text('+ Tomatoes')
            ],
          ),
        ),
        const Spacer(),
        const Text(
          '\$14.90',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kAppPrimaryColor,
              fontSize: 16),
        ).paddingOnly(top: 8),
      ],
    );
  }
}

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({Key? key}) : super(key: key);

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
              imageFromassets('drivo_car_full.png',
                  width: 100, height: 40, fit: BoxFit.fitWidth),
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
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(children: [
                  imageFromassets('car_side.png', width: 20, height: 20),
                  const Text('Driving',
                          style: TextStyle(
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
              const Text('John Doe',
                  style: TextStyle(fontWeight: FontWeight.w700)),
              const Spacer(),
              imageFromassets('clock.png',
                  color: kAppPrimaryColor, height: 20, width: 20),
              const SizedBox(width: 5),
              const Text('04:59 PM',
                  style: TextStyle(fontWeight: FontWeight.w700))
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              imageFromassets('store.png', width: 25, height: 25)
                  .paddingOnly(left: 0, right: 7),
              const Text('Street 96, First Avenue',
                  style: TextStyle(fontWeight: FontWeight.w700))
            ],
          ),
          const SizedBox(height: 15)
        ],
      ).marginSymmetric(horizontal: 8),
    );
  }
}
