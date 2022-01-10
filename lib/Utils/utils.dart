import 'package:drivo/core/app.dart';
import 'package:flutter/widgets.dart';

Image imageFromassets(String image,
        {double? width, double? height, Color? color, BoxFit? fit}) =>
    Image.asset('$kIconsPath/$image',
        fit: fit, width: width, height: height, color: color);
