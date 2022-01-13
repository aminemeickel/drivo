import 'package:drivo/core/app.dart';
import 'package:flutter/widgets.dart';

Image imageFromassets(String image,
        {double? width, double? height, Color? color, BoxFit? fit}) =>
    Image.asset('$kIconsPath/$image',
        fit: fit, width: width, height: height, color: color);

extension AppString on String? {
  String upper() {
    if (this == null) return '';
    if (this!.isEmpty || this!.length < 2) {
      return this!;
    }
    return this![0].upper() + this!.substring(1, this!.length).toLowerCase();
  }
}
