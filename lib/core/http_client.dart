import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drivo/core/log.dart';

import 'app.dart';

class HTTPClient {
  HTTPClient._();
  static Dio? dio;

  Future<Dio> getClient({String token = ''}) async {
    if (dio != null) return dio!;
    dio = Dio(BaseOptions(baseUrl: APILINK, headers: {
      HttpHeaders.authorizationHeader: 'bearer $token',
      'Content-Type': 'application/json; charset=utf-8'
    }))
      ..interceptors.add(InterceptorsWrapper(
        onError: (err, handler) {
          Log.error('error in ${err.requestOptions.uri} ${err.message}');
          handler.next(err);
        },
      ));

    return dio!;
  }
}
