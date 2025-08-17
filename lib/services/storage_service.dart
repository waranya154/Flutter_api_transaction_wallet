import 'package:hive/hive.dart';

class StorageService {
  static const String _boxName = 'auth_box';
  static const String _tokenKey = 'access_token';
  
  late Box _box;

  // Initialize Hive box
  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  // Save token
  Future<void> saveToken(String token) async {
    await _box.put(_tokenKey, token);
  }

  // Get token
  String? getToken() {
    return _box.get(_tokenKey);
  }

  // Delete token
  Future<void> deleteToken() async {
    await _box.delete(_tokenKey);
  }

  // Check if token exists
  bool hasToken() {
    return _box.containsKey(_tokenKey);
  }

  // Clear all data
  Future<void> clearAll() async {
    await _box.clear();
  }
}