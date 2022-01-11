import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:drivo/controllers/auth_controller.dart';
import 'package:drivo/core/log.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'app.dart';

class HTTPClient {
  HTTPClient._();

  static Future<Dio> getClient() async {
    var token = AuthController.readToken();
    if (token != null && JwtDecoder.isExpired(token.refreshExpiresIn)) {
      token = await ApiService.updateToken(token.refreshToken);
    }
    return Dio(BaseOptions(baseUrl: APILINK, headers: {
      HttpHeaders.authorizationHeader: 'bearer ${token?.token}',
      'Content-Type': 'application/json; charset=utf-8'
    }))
      ..interceptors.add(InterceptorsWrapper(
        onError: (err, handler) {
          Log.error(
              'error in ${err.requestOptions.uri} ${err.message} with respond of ${err.response}');
          handler.next(err);
        },
      ));
  }
}
