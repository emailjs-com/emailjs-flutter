import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_provider.dart';

class DefaultStorage implements StorageProvider {
  final Future<SharedPreferences> _storage = SharedPreferences.getInstance();

  @override
  Future<int?> get(String key) async {
    final SharedPreferences storage = await _storage;
    return storage.getInt(key);
  }

  @override
  Future<void> set(String key, int value) async {
    final SharedPreferences storage = await _storage;
    await storage.setInt(key, value);
  }

  @override
  Future<void> remove(String key) async {
    final SharedPreferences storage = await _storage;
    await storage.remove(key);
  }
}
