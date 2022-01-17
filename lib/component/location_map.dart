import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:drivo/controllers/store_controller.dart';
import 'package:drivo/core/log.dart';
import 'package:http/http.dart' as http;
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
  final LatLng _random = const LatLng(45.521563, -122.677433);
  LatLng? storePosition;
  final Set<Marker> _marks = {};
  BitmapDescriptor? _storeBitMap;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    var store = Get.find<StoreController>().store.value;
    if (store.lat != null && store.lng != null) {
      storePosition = LatLng(store.lat!, store.lng!);
      if (store.storeImage != null) {
        http.get(Uri.parse(store.storeImage!)).then((response) async {
          _storeBitMap = await getImage(response.bodyBytes);
          setState(() {
            _marks.add(Marker(
                markerId: const MarkerId('Store'),
                position: storePosition!,
                icon: _storeBitMap!));
          });
        });
      } else {
        Log.verbose('else');
        _marks.add(Marker(
          markerId: const MarkerId('Store'),
          position: storePosition!,
        ));
      }
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

  Future<BitmapDescriptor> getImage(Uint8List imageByte) async {
    final Codec imageCodec = await instantiateImageCodec(imageByte,
        targetWidth: 200, targetHeight: 200);
    final FrameInfo frameInfo = await imageCodec.getNextFrame();
    final byteData = await frameInfo.image.toByteData(
      format: ImageByteFormat.png,
    );
    final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedMarkerImageBytes);
  }
}
