import 'package:drivo/Models/order.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  RxList<Order> orders = <Order>[].obs;
  @override
  void onReady() async {
    orders(await ApiService.orders());
  }
}
