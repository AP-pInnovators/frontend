import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SigmaStorage {
  final String key = 'session-key';
  var storage = FlutterSecureStorage();

  Future<void>? writeSessionKey(String sessionKey) async {
    storage.write(key: key, value:sessionKey);
  }

  Future<String?> getSessionKey() async {
    return storage.read(key:key);
  }
}