import 'package:drivo/Models/store.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  Rx<Store> store = Rx(const Store());
  @override
  void onReady() async {
    store(await ApiService.storeInfo());
  }
}
