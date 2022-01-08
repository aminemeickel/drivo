import 'dart:convert';

import 'package:drivo/Models/token.dart';
import 'package:drivo/core/log.dart';
import 'package:drivo/core/storage.dart';

class AuthController {
  AuthController._();
  static bool get isAuthnthicated => readToken() != null;
  static const String _tokenKey = 'token';
  static Future<void> saveToken(Token user) async {
    Log.verbose('SAVING=>$user');
    await StorageDriver.write(_tokenKey, jsonEncode(user.toJson()));
  }

  static Token? readToken() {
    var token = StorageDriver.read<String>(_tokenKey);
    if (token != null) return Token.fromJson(jsonDecode(token));
  }
}
