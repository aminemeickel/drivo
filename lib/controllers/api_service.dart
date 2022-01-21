import 'package:dio/dio.dart';
import 'package:drivo/Models/order.dart';
import 'package:drivo/Models/store.dart';
import 'package:drivo/Models/token.dart';
import 'package:drivo/Models/user.dart';
import 'package:drivo/Utils/utils.dart';
import 'package:drivo/controllers/auth_controller.dart';
import 'package:drivo/core/app.dart';
import 'package:drivo/core/http_client.dart';
import 'package:drivo/core/log.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ApiService {
  static Future<Response?> login(
      {required String username, required String password}) async {
    var client = await HTTPClient.getClient();
    try {
      var response = await client.post('/store_app/login',
          data: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        await AuthController.saveToken(Token.fromJson(response.data));
        await updateFCMtoken(await FirebaseMessaging.instance.getToken());
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
      if (response.statusCode! == 200) {
        return Store.fromJson(response.data['data']);
      }
    } on DioError catch (excpetion) {
      Log.error(excpetion.message);
    }
  }

  static Future<User?> userInfo() async {
    var client = await HTTPClient.getClient();
    try {
      var response = await client.get('/store/profile');
      if (response.statusCode! == 200) {
        return User.fromJson(response.data['data']['user']);
      }
    } on DioError catch (excpetion) {
      Log.error(excpetion.message);
    }
  }

  static Future<List<Order>> orders(
      {int page = 1, String key = '', String? status = 'approved'}) async {
    var client = await HTTPClient.getClient();
    try {
      var response = await client.get('/store_app/orders', queryParameters: {
        "page": page,
        "pageLimit": 100,
        "status": status,
        "key": key
      });
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((orderJson) => Order.fromJson(orderJson))
            .toList();
      }
      return [];
    } on DioError catch (ex) {
      Log.error(ex.message);
      return [];
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

  static Future<bool> updateFCMtoken(String? token) async {
    var client = await HTTPClient.getClient();
    try {
      var respose = await client.put('/user/fcm',
          data: {'device_id': await getdeviceID(), 'token': token});
      if (respose.statusCode == 200) {
        return true;
      }
    } on DioError catch (e) {
      Log.error(e.message);
      return false;
    }
    return false;
  }

  static Future<Order?> orderById(String? orderId) async {
    var client = await HTTPClient.getClient();
    try {
      var respose = await client.get('/store_app/orders/id/$orderId');
      if (respose.statusCode == 200) {
        return Order.fromJson(respose.data['data']);
      }
    } on DioError catch (e) {
      Log.error(e.message);
      return null;
    }
  }

  static Future<bool> updateOrderStatus(
      String orderId, String orderStatus) async {
    var client = await HTTPClient.getClient();
    try {
      var respose = await client
          .put('/store_app/orders/$orderId', data: {'status': orderStatus});
      return respose.statusCode == 200;
    } on DioError catch (e) {
      Log.error(e.message);
      return false;
    }
  }

  static Future<bool> updateLanguge(String languge, String name) async {
    var client = await HTTPClient.getClient();
    try {
      var respose = await client
          .put('/store/profile', data: {'name': name, 'language': languge});
      Log.verbose(respose.data);
      if (respose.statusCode == 200) {
        return true;
      }
    } on DioError catch (e) {
      Log.error(e.message);
      return false;
    }
    return false;
  }

  static Future<Order?> setPickupTime(int time, String orderID) async {
    var client = await HTTPClient.getClient();
    try {
      var respose = await client
          .put('/store_app/orders/$orderID', data: {'schedule_at': time});
      Log.verbose(respose.data);
      if (respose.statusCode == 200) {
        return Order.fromJson(respose.data['data']);
      }
    } on DioError catch (e) {
      Log.error(e.message);
    }
  }
}
