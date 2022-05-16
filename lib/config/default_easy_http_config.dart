import 'package:easy_http/cache/base_cache_runner.dart';
import 'package:easy_http/cache/get_storage_cache_runner.dart';
import 'package:easy_http/config/base_easy_http_config.dart';

class DefaultEasyHttpConfig extends BaseEasyHttpConfig {
  late BaseCacheRunner _cacheRunner;
  final CacheSerializer _cacheSerializer;

  DefaultEasyHttpConfig(this._cacheSerializer);

  @override
  CacheSerializer get cacheSerializer => _cacheSerializer;

  @override
  BaseCacheRunner get cacheRunner => _cacheRunner;

  @override
  Future init() async {
    _cacheRunner = GetStorageCacheRunner();
    await _cacheRunner.setUp();
  }
}
