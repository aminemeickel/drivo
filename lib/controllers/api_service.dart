import 'package:dio/dio.dart';
import 'package:drivo/Models/token.dart';
import 'package:drivo/controllers/auth_controller.dart';
import 'package:drivo/core/http_client.dart';
import 'package:drivo/core/log.dart';

class ApiService {
  static Future<Response?> login(
      {required String username, required String password}) async {
    Log.verbose('LOGIN WITH =>username $username password $password');

    var client = await HTTPClient.getClient();
    try {
      var response = await client
          .post('/login', data: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        await AuthController.saveToken(Token.fromJson(response.data));
        return response;
      }
    } on DioError catch (error) {
      return error.response;
    }
  }
}
