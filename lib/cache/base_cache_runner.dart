typedef CacheSerializer = T? Function<T>(dynamic data);

abstract class BaseCacheRunner {
  String get name;

  Future<void> setUp();

  Future<void> tearDown();

  T? readCache<T>(String key);

  Future? writeCache<T>(String key, T? data);

  Future<void> deleteCache(String key);

  Future<void> clearCache();
}
