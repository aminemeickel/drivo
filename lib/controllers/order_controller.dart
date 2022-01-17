import 'package:drivo/Models/order.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  RxList<Order> orders = <Order>[].obs;
  RxList<Order> pending = <Order>[].obs;
  RxList<Order> ready = <Order>[].obs;
  RxList<Order> completed = <Order>[].obs;
  RxList<Order> cancelled = <Order>[].obs;
  RxBool isLoading = false.obs;
  RxBool isWorking = false.obs;
  @override
  Future<void> onReady() async {
    isLoading(true);
    orders(await ApiService.orders(status: null));
    pending(await ApiService.orders(status: 'approved'));
    ready(await ApiService.orders(status: 'delivery'));
    completed(await ApiService.orders(status: 'completed'));
    cancelled(await ApiService.orders(status: 'canceled'));
    isLoading(false);
  }
}
