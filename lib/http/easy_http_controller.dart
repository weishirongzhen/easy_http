
import 'package:easy_http/easy_http.dart';
import 'package:easy_http/http/easy_http_connect.dart';

abstract class EasyHttpController<T> extends GetxController with StateMixin<T> {
  T get initHttpResponseData;

  late EasyHttpClient<T> _httpClient;

  EasyHttpClient<T> get httpClient => _httpClient;

  late final Rx<T> _httpData = _httpClient.obsHttpData;

  T get httpData => _httpData.value;

  Rx<T> get obsHttpData => _httpData;

  String get localCacheKey => "";

  int get timeout => 100000;

  String get requestUrl;

  bool get needAuthorized => true;

  @override
  void onInit() {
    _httpClient = EasyHttpClient<T>(initHttpResponseData, localCacheKey: localCacheKey, timeout: timeout);

    super.onInit();
  }

  Future<T> get({
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) async {
    return onLoading(() async {
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
  }) async {
    return onLoading(() async {
      try {
        final response = await _httpClient.dio.post(
          requestUrl,
          data: body,
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

  Future<T> put(
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) async {
    return onLoading(() async {
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
    return onLoading(() async {
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
    return onLoading(() async {
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

  Future<T> onLoading(Future<T> Function() asyncFunction, {bool showDefaultLoading = true}) async {
    if (showDefaultLoading) {
      return Get.showOverlay(
        asyncFunction: asyncFunction,
        opacity: .1,
        loadingWidget: EasyHttp.config.loadingWidget,
      );
    } else {
      return asyncFunction();
    }
  }

  void onEmpty() {}

  void onSuccess() {}

  void onError([String? message]) {}
}
