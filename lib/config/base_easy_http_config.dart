import '../cache/base_cache_runner.dart';
import 'package:flutter/material.dart';

abstract class BaseEasyHttpConfig {
  BaseCacheRunner get cacheRunner;

  CacheSerializer get cacheSerializer;

  Widget get loadingWidget;

  Future<void> init();

}
