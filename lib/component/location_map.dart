import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivo/core/app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatefulWidget {
  final bool useOpenStreatMap;
  const LocationMap({Key? key, this.useOpenStreatMap = true}) : super(key: key);

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .35,
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: {const Marker(markerId: MarkerId('value'))},
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
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
                              onPressed: () async {},
                              iconSize: 20,
                              icon: const Icon(Icons.add,
                                  size: 25, color: Colors.white),
                              padding: EdgeInsets.zero)),
                      SizedBox(
                          width: 40,
                          height: 30,
                          child: IconButton(
                              onPressed: () async {},
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
/* widget.useOpenStreatMap
              ? OSMFlutter(
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
                )
              : */
