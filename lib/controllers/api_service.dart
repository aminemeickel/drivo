import 'package:dio/dio.dart';
import 'package:drivo/Models/store.dart';
import 'package:drivo/Models/token.dart';
import 'package:drivo/controllers/auth_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/core/http_client.dart';
import 'package:drivo/core/log.dart';

class ApiService {
  static Future<Response?> login(
      {required String username, required String password}) async {
    var client = await HTTPClient.getClient();
    try {
      var response = await client.post('/store_app/login',
          data: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        await AuthController.saveToken(Token.fromJson(response.data));
        return response;
      }
    } on DioError catch (error) {
      return error.response;
    }
  }

  static Future<Store?> storeInfo() async {
    var client = await HTTPClient.getClient();
    try {
      var response = await client.get('/store');
      Log.verbose(response.data['data']);
      if (response.statusCode! == 200) {
        return Store.fromJson(response.data['data']);
      }
    } on DioError catch (excpetion) {
      Log.error(excpetion.message);
    }
  }

  static Future<Token> updateToken(String oldToken) async {
    var dio = Dio(BaseOptions(baseUrl: APILINK));
    var response =
        await dio.post('/user/auth/refresh_token', data: {'token': oldToken});
    var token = Token.fromJson(response.data);
    await AuthController.saveToken(token);
    return token;
  }
}
