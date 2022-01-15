import 'package:drivo/Models/store.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  Rx<Store> store = Rx(const Store());
  RxBool isLoading = false.obs;
  @override
  void onReady() async {
    isLoading(true);
    store(await ApiService.storeInfo());
    isLoading(false);
  }
}
