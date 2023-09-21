import 'dart:developer';

import '../easy_http.dart';
import 'easy_http_connect.dart';

abstract class EasyHttpCacheController<T> extends GetxController with StateMixin<T> {
  RefreshController? _refreshController;

  RefreshController? get refreshController => _refreshController;

  T get initHttpResponseData;

  late EasyHttpClient<T> _httpClient;

  EasyHttpClient<T> get httpClient => _httpClient;

  late final Rx<T> _httpData = _httpClient.obsHttpData;

  T get httpData => _httpData.value;

  Rx<T> get obsHttpData => _httpData;

  /// if want to enable cache, override localCacheKey and give localCacheKey a not-empty value. else leave it empty
  String get simpleCacheKey => "";

  Duration get timeout => const Duration(milliseconds: 10000);

  String get requestUrl;

  @override
  void onInit() {
    _httpClient = EasyHttpClient<T>(
      initHttpResponseData,
      localCacheKey: simpleCacheKey,
      timeout: timeout,
      onSuccessCallback: onSuccess,
      onCacheCallback: onCached,
      onNewDataCallback: onNewData,
    );
    super.onInit();
  }

  RefreshController getRefreshController({bool initialRefresh = true}) {
    _refreshController ??= RefreshController(initialRefresh: initialRefresh);
    return _refreshController!;
  }

  Future<T> get({
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) async {
    return EasyHttp.onLoading(() async {
      try {
        final response = await _httpClient.dio.get(
          requestUrl,
          options: Options(headers: headers, contentType: contentType),
          queryParameters: query,
        );
        if (response.data == null) {
          onError("${response.realUri} ${response.statusMessage}");
        } else {
          onSuccess();
        }
      } catch (e, _) {
        onError(e.toString());
        rethrow;
      }
      return httpData;
    }, showDefaultLoading: showDefaultLoading);
  }

  Future<T> post(
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return EasyHttp.onLoading(() async {
      try {
        final response = await _httpClient.dio.post(
          requestUrl,
          data: body,
          queryParameters: query,
          options: Options(headers: headers, contentType: contentType),
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );

        if (response.data == null) {
          onError("${response.realUri} ${response.statusMessage}");
        } else {
          onSuccess();
        }
      } catch (e, _) {
        onError(e.toString());
        rethrow;
      }
      return httpData;
    }, showDefaultLoading: showDefaultLoading);
  }

  Future<T> put(
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) async {
    return EasyHttp.onLoading(() async {
      try {
        final response = await _httpClient.dio.put(
          requestUrl,
          data: body,
          options: Options(headers: headers, contentType: contentType),
          queryParameters: query,
        );

        if (response.data == null) {
          onError("${response.realUri} ${response.statusMessage}");
        } else {
          onSuccess();
        }
      } catch (e, _) {
        onError(e.toString());
        rethrow;
      }
      return httpData;
    }, showDefaultLoading: showDefaultLoading);
  }

  Future<T> patch(
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) async {
    return EasyHttp.onLoading(() async {
      try {
        final response = await _httpClient.dio.patch(
          requestUrl,
          data: body,
          options: Options(headers: headers, contentType: contentType),
          queryParameters: query,
        );

        if (response.data == null) {
          onError("${response.realUri} ${response.statusMessage}");
        } else {
          onSuccess();
        }
      } catch (e, _) {
        onError(e.toString());
        rethrow;
      }
      return httpData;
    }, showDefaultLoading: showDefaultLoading);
  }

  Future<T> delete({
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) async {
    return EasyHttp.onLoading(() async {
      try {
        final response = await _httpClient.dio.delete(
          requestUrl,
          queryParameters: query,
          options: Options(headers: headers, contentType: contentType),
        );

        if (response.data == null) {
          onError("${response.realUri} ${response.statusMessage}");
        } else {
          onSuccess();
        }
      } catch (e, _) {
        onError(e.toString());
        rethrow;
      }
      return httpData;
    }, showDefaultLoading: showDefaultLoading);
  }

  void onEmpty() {}

  void onSuccess() {}

  void onCached(T cache) {}

  void onNewData(T newData) {}

  void onError([String? message]) {
    log("EasyHttp error: $message");
  }

  void deleteCache() {
    EasyHttp.config.cacheRunner.deleteCache(simpleCacheKey);
  }

  Future<T?> refreshData() async {
    return null;
  }
}
