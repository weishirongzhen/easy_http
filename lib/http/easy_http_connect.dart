import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../easy_http.dart' hide Response;

class EasyHttpClient<T> {
  /// http response init data, use for initial _httpData obs value
  final T initData;

  /// leave empty will disable local cache
  final String localCacheKey;
  final Duration timeout;

  late final Rx<T> _httpData = Rx<T>(initData);

  T get httpData => _httpData.value;

  Rx<T> get obsHttpData => _httpData;

  late Dio dio;

  EasyHttpClient(
    this.initData, {
    this.localCacheKey = "",
    this.timeout = const Duration(seconds: 10),
    Function? onSuccessCallback,
    Function(T cache)? onCacheCallback,
    Function(T newData)? onNewDataCallback,
  }) {
    dio = Dio();
    dio.options.connectTimeout = timeout;
    dio.options.receiveTimeout = timeout;
    dio.interceptors.clear();
    dio.interceptors.addAll(EasyHttp.interceptor);

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (localCacheKey.isNotEmpty) {
        final cache = EasyHttp.config.cacheRunner.readCache<T>(localCacheKey);
        if (cache != null) {
          if (kDebugMode) {
            log("Found cache  ${T.toString()} request url = ${options.uri}");
          }
          _httpData.value = cache;
          onSuccessCallback?.call();
          onCacheCallback?.call(cache);
        } else {
          if (kDebugMode) {
            log("Cache Not Found  ${T.toString()} request url = ${options.uri}");
          }
        }
      }
      return handler.next(options);
    }, onResponse: (response, handler) {
      if (response.data != null) {
        try {
          _httpData.value = EasyHttp.config.cacheSerializer<T>(response.data) ?? initData;
          onSuccessCallback?.call();
          onNewDataCallback?.call(_httpData.value);

          if (localCacheKey.isNotEmpty) {
            EasyHttp.config.cacheRunner.writeCache(localCacheKey, _httpData.value);
            if (kDebugMode) {
              log("Updated Cache ${T.toString()} request url = ${response.realUri}");
            }
          }
        } catch (e, s) {
          if (kDebugMode) {
            log("cacheSerializer error by type ${T.toString()}  request url = ${response.realUri}}", error: e, stackTrace: s);
          }
        }
      }
      return handler.next(response); // continue
    }, onError: (DioException e, handler) {
      return handler.next(e); //continue
    }));
  }
}
