import 'package:easy_http/cache/base_cache_runner.dart';
import 'package:flutter/material.dart';

abstract class BaseEasyHttpConfig {
  BaseCacheRunner get cacheRunner;

  CacheSerializer get cacheSerializer;

  Widget get loadingWidget;

  bool get showLog;

  Future<void> init();

}
