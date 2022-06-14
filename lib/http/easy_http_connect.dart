import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_http/easy_http.dart' hide Response;

class EasyHttpClient<T> {
  /// http response init data, use for initial _httpData obs value
  final T initData;

  /// leave empty will disable local cache
  final String localCacheKey;
  final int timeout;

  late final Rx<T> _httpData = Rx<T>(initData);

  T get httpData => _httpData.value;

  Rx<T> get obsHttpData => _httpData;

  late Dio dio;


  EasyHttpClient(this.initData, {this.localCacheKey = "", this.timeout = 100000}) {
    dio = Dio();
    dio.options.connectTimeout = timeout;
    dio.options.receiveTimeout = timeout;
    dio.interceptors.clear();
    dio.interceptors.addAll(EasyHttp.interceptor);

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (localCacheKey.isNotEmpty) {
        final cache = EasyHttp.config.cacheRunner.readCache<T>(localCacheKey);
        if (cache != null) {
          log("Found cache  ${T.toString()} request url = ${options.uri}");
          _httpData.value = cache;
        } else {
          log("Cache Not Found  ${T.toString()} request url = ${options.uri}");
        }
      }
      return handler.next(options);
    }, onResponse: (response, handler) {
      log("request = ${response.realUri} response = ${jsonEncode(response.data)}");

      if (response.data != null) {
        try {
          _httpData.value = EasyHttp.config.cacheSerializer<T>(response.data) ?? initData;
          if (localCacheKey.isNotEmpty) {
            EasyHttp.config.cacheRunner.writeCache(localCacheKey, _httpData.value);
            log("Updated Cache ${T.toString()} request url = ${response.realUri}");
          }
        } catch (e, s) {
          log("cacheSerializer error by type ${T.toString()}  request url = ${response.realUri}}", error: e, stackTrace: s);
        }
      }
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      return handler.next(e); //continue
    }));

  }


}
