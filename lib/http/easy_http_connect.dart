import 'dart:convert';
import 'dart:developer';

import 'package:easy_http/easy_http.dart';
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class EasyHttpConnect<T> extends GetConnect {
  /// http response init data, use for initial _httpData obs value
  final T initData;

  /// leave empty will disable local cache
  final String localCacheKey;

  late final Rx<T> _httpData = Rx<T>(initData);

  T get httpData => _httpData.value;

  Rx<T> get obsHttpData => _httpData;


  EasyHttpConnect(this.initData, {this.localCacheKey = ""});

  @override
  Duration get timeout => const Duration(seconds: 10);

  @override
  void onInit() {
    httpClient.defaultDecoder = EasyHttp.config.cacheSerializer;
    httpClient.errorSafety = false;
    httpClient.timeout = timeout;
    for (RequestModifier request in EasyHttp.requestInterceptor) {
      httpClient.addRequestModifier(request);

    }
    for (ResponseModifier response in EasyHttp.responseInterceptor) {
      httpClient.addResponseModifier(response);
    }

    httpClient.addRequestModifier((Request request) {
      if (localCacheKey.isNotEmpty) {
        final cache = EasyHttp.config.cacheRunner.readCache<T>(localCacheKey);
        if (cache != null) {
          log("Found cache  ${T.toString()} request url = ${request.url.toString()}");
          _httpData.value = cache;
        } else {
          log("Cache Not Found  ${T.toString()} request url = ${request.url.toString()}");
        }
      }

      return request;
    });

    httpClient.addResponseModifier((request, response) {
      log("request = ${request.url.toString()} response = ${jsonEncode(response.body)}");

      if (response.isOk) {
        try {
          _httpData.value = EasyHttp.config.cacheSerializer<T>(response.body) ?? initData;
          if (localCacheKey.isNotEmpty) {
            EasyHttp.config.cacheRunner.writeCache(localCacheKey, _httpData.value);
            log("Updated Cache ${T.toString()} request url = ${request.url.toString()}");
          }
        } catch (e, s) {
          log("cacheSerializer error by type ${T.toString()}  request url = ${request.url.toString()}}", error: e, stackTrace: s);
        }
      }

      return response;
    });
  }
}
