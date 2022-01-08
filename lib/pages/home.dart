import 'dart:math';

import 'package:drivo/core/app.dart';
import 'package:drivo/core/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  static const id = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool listView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 70,
        leading:
            Image.asset('$kIconsPath/drivo_car_full.png').paddingOnly(left: 10),
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
          bottomRight: Radius.circular(7),
        )),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        height: 70,
        destinations: [
          Image.asset('$kIconsPath/home.png',
              width: 25, height: 25, color: Colors.black),
          Image.asset('$kIconsPath/bag.png', width: 25, height: 25),
          Image.asset('$kIconsPath/account.png', width: 25, height: 25),
        ],
      ),
      body: Column(
        children: [
          if (!listView) LocationMap(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) => const ItemTile(),
              separatorBuilder: (context, index) => const Divider(),
            ),
          )
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
  final String status;
  const ItemTile({Key? key, this.status = 'Arrived'}) : super(key: key);

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
            Image.asset('$kIconsPath/clock.png', width: 15, height: 15),
            const Text(
              'just now',
              style: TextStyle(color: Color(0xFF392726)),
            ).paddingOnly(left: 10)
          ],
        ),
        Row(
          children: [
            const Text(
              'Elizabeth B. -Order #44354',
              style: TextStyle(color: Color(0xFF392726)),
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
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: kAppPrimaryColor, size: 20)),
                )
              ],
            ),
          ],
        ).paddingOnly(top: 10, bottom: 5),
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
            const Text('LQR445', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ).paddingOnly(top: 3),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 8);
  }
}

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  late MapController controller;
  @override
  void initState() {
    super.initState();
    controller = MapController(
      areaLimit: BoundingBox(
        east: 10.4922941,
        north: 47.8084648,
        south: 45.817995,
        west: 5.9559113,
      ),
      initMapWithUserPosition: false,
      initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
    );
    controller.listenerMapLongTapping.addListener(() {
      if (controller.listenerMapLongTapping.value != null) {
        controller.addMarker(
          GeoPoint(
              latitude: controller.listenerMapLongTapping.value!.latitude,
              longitude: controller.listenerMapLongTapping.value!.longitude),
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .35,
      child: Stack(
        children: [
          OSMFlutter(
            controller: controller,
            initZoom: 17,
            onMapIsReady: (ready) {
              if (ready) {
                controller.addMarker(
                    GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
                    markerIcon: const MarkerIcon(
                      icon: Icon(Icons.location_pin,
                          color: kAppPrimaryColor, size: 100),
                    ));
              }
            },
            androidHotReloadSupport: true,
            trackMyPosition: false,
            mapIsLoading: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
          Positioned(
            right: 10,
            top: 15,
            child: Container(
                width: 34,
                height: 70,
                decoration: BoxDecoration(
                    color: kAppPrimaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 40,
                          height: 20,
                          child: IconButton(
                              onPressed: () async {
                                await controller.zoomIn();
                              },
                              iconSize: 20,
                              icon: const Icon(Icons.add,
                                  size: 25, color: Colors.white),
                              padding: EdgeInsets.zero)),
                      SizedBox(
                          width: 40,
                          height: 30,
                          child: IconButton(
                              onPressed: () async {
                                await controller.zoomOut();
                              },
                              iconSize: 20,
                              icon: const Icon(Icons.minimize,
                                  size: 25, color: Colors.white),
                              padding: EdgeInsets.zero))
                    ])),
          )
        ],
      ),
    );
  }
}
