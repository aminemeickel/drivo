import 'package:drivo/Models/store.dart';
import 'package:drivo/Models/user.dart';
import 'package:drivo/controllers/api_service.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  Rx<Store> store = Rx(const Store());
  Rx<User> user = Rx(User());
  RxBool isLoading = false.obs;
  @override
  void onReady() async {
    isLoading(true);
    store(await ApiService.storeInfo());
    user(await ApiService.userInfo());
    isLoading(false);
  }
}
