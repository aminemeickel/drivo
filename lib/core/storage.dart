import 'package:get_storage/get_storage.dart';

class StorageDriver {
  final _storage = GetStorage();
  GetStorage get driver => _storage;

  Future<void> write(String key, value) async {
    await _storage.write(key, value);
  }

  T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  void remove(String key) async {
    await _storage.remove(key);
  }

  void clear() async {
    await _storage.erase();
  }
}
