import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final securestorage =const FlutterSecureStorage();

  Future<void> writeToken(String key, String value) async {
    return await securestorage.write(key: key, value: value);
  }

  Future read(String key) async {
    return await securestorage.read(key: key);
  }

  Future delete() async {
    return await securestorage.deleteAll();
  }

  Future<bool> containsData(String key) async {
    return await securestorage.containsKey(key: key);
  }
}
