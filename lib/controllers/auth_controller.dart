import 'dart:convert';

import 'package:drivo/Models/token.dart';
import 'package:drivo/controllers/order_controller.dart';
import 'package:drivo/controllers/store_controller.dart';
import 'package:drivo/core/storage.dart';
import 'package:get/get.dart';

class AuthController {
  AuthController._();
  static bool get isAuthnthicated => readToken() != null;
  static const String _tokenKey = 'token';
  static Future<void> saveToken(Token user) async {
    await StorageDriver.write(_tokenKey, jsonEncode(user.toJson()));
  }

  static void initControllers() {
    Get.put<StoreController>(StoreController(), permanent: true);
    Get.put<OrderController>(OrderController(), permanent: true);
  }

  static Token? readToken() {
    var token = StorageDriver.read<String>(_tokenKey);
    if (token != null) return Token.fromJson(jsonDecode(token));
  }

  static logOut() {
    StorageDriver.clear();
  }
}
