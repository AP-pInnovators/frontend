import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SigmaStorage {
  // final String sessionKeyKey = 'session-key';
  // final storage = FlutterSecureStorage();

  // Future<void>? writeSessionKey(String sessionKey) async {
  //   storage.write(key:sessionKeyKey, value:sessionKey);
  // }

  // Future<String?> getSessionKey() async {
  //   return storage.read(key:sessionKeyKey);
  // }
  
  // Private constructor
  SigmaStorage._privateConstructor();

  // The single instance of the class
  static final SigmaStorage _instance = SigmaStorage._privateConstructor();

  // Public factory constructor
  factory SigmaStorage() {
    return _instance;
  }

  // Storage key for the session key
  final String sessionKeyKey = 'session-key';

  // The instance of FlutterSecureStorage
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Method to write the session key
  Future<void> writeSessionKey(String sessionKey) async {
    await _storage.write(key: sessionKeyKey, value: sessionKey);
  }

  // Method to read the session key
  Future<String?> getSessionKey() async {
    return _storage.read(key: sessionKeyKey);
  }
}