import 'package:drivo/Models/order.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  RxList<Order> orders = <Order>[].obs;
  RxList<Order> pending = <Order>[].obs;
  RxList<Order> ready = <Order>[].obs;
  RxList<Order> completed = <Order>[].obs;
  RxList<Order> cancelled = <Order>[].obs;

  @override
  void onReady() async {
    pending(await ApiService.orders(status: 'pending payment'));
    ready(await ApiService.orders(status: 'approved'));
    completed(await ApiService.orders(status: 'completed'));
    cancelled(await ApiService.orders(status: 'canceled'));
  }
}
