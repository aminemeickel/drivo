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
    var all = await ApiService.orders(status: null);
    orders(all.where((order) => order.transportation == 'VEHICLE').toList());
    pending(await ApiService.orders(status: 'approved'));
    ready(await ApiService.orders(status: 'delivery'));
    completed(await ApiService.orders(status: 'completed'));
    cancelled(await ApiService.orders(status: 'canceled'));
    isLoading(false);
  }

  Future<void> updateOnly(int index) async {
    switch (index) {
      case 0:
        var all = await ApiService.orders(status: null);
        orders(
            all.where((order) => order.transportation == 'VEHICLE').toList());
        break;
      case 1:
        pending(await ApiService.orders(status: 'approved'));
        break;
      case 2:
        ready(await ApiService.orders(status: 'delivery'));
        break;
      case 3:
        completed(await ApiService.orders(status: 'completed'));
        break;
      case 4:
        cancelled(await ApiService.orders(status: 'canceled'));
        break;
      default:
        await onReady();
        break;
    }
  }
}
