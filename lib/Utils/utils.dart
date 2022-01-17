import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:drivo/core/app.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:google_maps_flutter/google_maps_flutter.dart';

Image imageFromassets(String image,
        {double? width, double? height, Color? color, BoxFit? fit}) =>
    Image.asset('$kIconsPath/$image',
        fit: fit, width: width, height: height, color: color);

Future<String?> getdeviceID() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var deviceInfo = await deviceInfoPlugin.iosInfo;
    return deviceInfo.identifierForVendor;
  }
  if (Platform.isAndroid) {
    var deviceInfo = await deviceInfoPlugin.androidInfo;
    return deviceInfo.id;
  }
  return '';
}

int calculateDistance(LatLng begin, LatLng end) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((end.latitude - begin.latitude) * p) / 2 +
      c(begin.latitude * p) *
          c(end.latitude * p) *
          (1 - c((end.longitude - begin.longitude) * p)) /
          2;
  return (12742 * asin(sqrt(a))).round();
}

extension AppString on String? {
  String upper() {
    if (this == null) return '';
    if (this!.isEmpty || this!.length < 2) {
      return this!;
    }
    return this![0].upper() + this!.substring(1, this!.length).toLowerCase();
  }
}
