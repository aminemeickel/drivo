import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drivo/core/log.dart';

import 'app.dart';

class HTTPClient {
  HTTPClient._();

  static Future<Dio> getClient({String token = ''}) async {
    return Dio(BaseOptions(baseUrl: APILINK, headers: {
      HttpHeaders.authorizationHeader: 'bearer $token',
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
