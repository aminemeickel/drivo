import 'dart:convert';

import 'package:drivo/Models/token.dart';
import 'package:drivo/core/storage.dart';

class AuthController {
  AuthController._();
  static const String _tokenKey = 'token';
  static Future<void> saveToken(Token user) async {
    await StorageDriver.write(_tokenKey, jsonEncode(user.toJson()));
  }

  static Future<Token?> readToken() async {
    var token = StorageDriver.read<String>(_tokenKey);
    if (token != null) return Token.fromJson(jsonDecode(token));
  }
}
