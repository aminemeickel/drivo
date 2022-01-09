import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:drivo/core/app.dart';

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
