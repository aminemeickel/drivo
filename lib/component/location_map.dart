import 'dart:typed_data';
import 'dart:ui';
import 'package:drivo/controllers/store_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivo/core/app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  late GoogleMapController mapController;
  final LatLng _random = const LatLng(45.521563, -122.677433);
  LatLng? storePosition;
  final Set<Marker> _marks = {};
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    var store = Get.find<StoreController>().store.value;
    if (store.lat != null && store.lng != null) {
      storePosition = LatLng(store.lat!, store.lng!);
      addMarks();
    }

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
            markers: _marks,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: storePosition ?? _random,
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
                              onPressed: () async {
                                await mapController
                                    .animateCamera(CameraUpdate.zoomIn());
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
                                await mapController
                                    .animateCamera(CameraUpdate.zoomOut());
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

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void addMarks() {
    getBytesFromAsset('assets/location/store.png', 100).then((value) {
      setState(() {
        _marks.add(Marker(
            markerId: const MarkerId('Store'),
            position: storePosition!,
            icon: BitmapDescriptor.fromBytes(value)));
      });
    });
    getBytesFromAsset('assets/location/person.png', 90).then((value) {
      setState(() {
        _marks.add(Marker(
            markerId: const MarkerId('person'),
            position: LatLng(
                storePosition!.latitude - .05, storePosition!.longitude - 0.01),
            icon: BitmapDescriptor.fromBytes(value)));
      });
    });
    getBytesFromAsset('assets/location/person.png', 90).then((value) {
      setState(() {
        _marks.add(Marker(
            markerId: const MarkerId('person2'),
            position: LatLng(
                storePosition!.latitude - .05, storePosition!.longitude - 0.01),
            icon: BitmapDescriptor.fromBytes(value)));
      });
    });
    getBytesFromAsset('assets/location/person.png', 90).then((value) {
      setState(() {
        _marks.add(Marker(
            markerId: const MarkerId('person2'),
            position: LatLng(
                storePosition!.latitude - .03, storePosition!.longitude - 0.03),
            icon: BitmapDescriptor.fromBytes(value)));
      });
    });
    getBytesFromAsset('assets/location/car.png', 100).then((value) {
      setState(() {
        _marks.add(Marker(
            markerId: const MarkerId('car'),
            position: LatLng(
                storePosition!.latitude + .05, storePosition!.longitude + 0.01),
            icon: BitmapDescriptor.fromBytes(value)));
      });
    });
    getBytesFromAsset('assets/location/car.png', 100).then((value) {
      setState(() {
        _marks.add(Marker(
            markerId: const MarkerId('car2'),
            position: LatLng(
                storePosition!.latitude + .05, storePosition!.longitude + 0.05),
            icon: BitmapDescriptor.fromBytes(value)));
      });
    });
  }
}
