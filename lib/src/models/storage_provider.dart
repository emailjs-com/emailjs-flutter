abstract class StorageProvider {
  Future<int?> get(String key);
  Future<void> set(String key, int value);
  Future<void> remove(String key);
}
