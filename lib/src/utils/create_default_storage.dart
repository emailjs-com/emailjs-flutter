import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/storage_provider.dart';

class Storage implements StorageProvider {
  final Future<SharedPreferences> _storage = SharedPreferences.getInstance();

  Future<int?> get(String key) async {
    final SharedPreferences storage = await _storage;
    return storage.getInt(key);
  }

  Future<void> set(String key, int value) async {
    final SharedPreferences storage = await _storage;
    await storage.setInt(key, value);
  }

  Future<void> remove(String key) async {
    final SharedPreferences storage = await _storage;
    await storage.remove(key);
  }
}

StorageProvider createDefaultStorage() {
  return Storage();
}
