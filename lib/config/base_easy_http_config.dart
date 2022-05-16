import 'package:easy_http/cache/base_cache_runner.dart';

abstract class BaseEasyHttpConfig {
  BaseCacheRunner get cacheRunner;

  CacheSerializer get cacheSerializer;


  Future<void> init();

}
