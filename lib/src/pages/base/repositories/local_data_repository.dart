import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveLocalData({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getLocalData({required String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> removeLocalData({required String key}) async {
    await _storage.delete(key: key);
  }
}