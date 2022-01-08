import 'package:get_storage/get_storage.dart';

class StorageDriver {
  static final _storage = GetStorage('main');
  GetStorage get driver => _storage;

  static Future<void> write(String key, value) async {
    await _storage.write(key, value);
  }

  static T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  static void remove(String key) async {
    await _storage.remove(key);
  }

  static void clear() async {
    await _storage.erase();
  }
}
