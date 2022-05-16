import 'package:easy_http/easy_http_snackbar.dart';
import 'package:easy_http/http/easy_http_connect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class EasyHttpController<T> extends GetxController with StateMixin<T> {
  T get initHttpResponseData;

  late EasyHttpConnect<T> _httpClient;

  EasyHttpConnect<T> get httpClient => _httpClient;

  late final Rx<T> _httpData = _httpClient.obsHttpData;

  T get httpData => _httpData.value;

  Rx<T> get obsHttpData => _httpData;

  String get localCacheKey => "";

  String get requestUrl;

  bool get needAuthorized => true;

  @override
  void onInit() {
    _httpClient = Get.put(
      EasyHttpConnect<T>(initHttpResponseData, localCacheKey: localCacheKey),
    );

    super.onInit();
  }

  Future<T> get({
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
  }) async {
    return onLoading(() async {
      try {
        final response = await _httpClient.get(
          requestUrl,
          headers: headers,
          contentType: contentType,
          query: query,
        );
        if (!response.isOk) {
          onError("${response.request?.url} ${response.statusText} \n${response.body}");
        }
      } catch (e, _) {
        onError(e.toString());
        rethrow;
      }
      return httpData;
    });
  }

  Future<T> post(
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    return onLoading(() async {
      try {
        final response = await _httpClient.post(
          requestUrl,
          body,
          contentType: contentType,
          headers: headers,
          query: query,
        );

        if (!response.isOk) {
          onError("${response.request?.url} ${response.statusText} \n${response.body}");
        }
      } catch (e, _) {
        onError(e.toString());
        rethrow;
      }
      return httpData;
    });
  }

  Future<T> put(
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    return onLoading(() async {
      try {
        final response = await _httpClient.put(
          requestUrl,
          body,
          contentType: contentType,
          headers: headers,
          query: query,
        );

        if (!response.isOk) {
          onError("${response.request?.url} ${response.statusText} \n${response.body}");
        }
      } catch (e, _) {
        onError(e.toString());
        rethrow;
      }
      return httpData;
    });
  }

  Future<T> patch(
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    return onLoading(() async {
      try {
        final response = await _httpClient.patch(
          requestUrl,
          body,
          contentType: contentType,
          headers: headers,
          query: query,
        );

        if (!response.isOk) {
          onError("${response.request?.url} ${response.statusText} \n${response.body}");
        }
      } catch (e, _) {
        onError(e.toString());
        rethrow;
      }
      return httpData;
    });
  }

  Future<T> delete({
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    return onLoading(() async {
      try {
        final response = await _httpClient.delete(
          requestUrl,
          headers: headers,
          query: query,
          contentType: contentType,
        );

        if (!response.isOk) {
          onError("${response.request?.url} ${response.statusText} \n${response.body}");
        }
      } catch (e, _) {
        onError(e.toString());
        rethrow;
      }
      return httpData;
    });
  }

  Future<T> onLoading(Future<T> Function() asyncFunction) async {
    return Get.showOverlay(
      asyncFunction: asyncFunction,
      opacity: .1,
      loadingWidget: Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(color: Colors.white.withOpacity(.4), borderRadius: BorderRadius.circular(10)),
          child: const SizedBox(
            width: 50,
            height: 50,
            child: Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        ),
      ),
    );
  }

  void onEmpty() {}

  void onSuccess() {}

  void onError([String? message]) {
    easyHttpSnackBar(message ?? "未知错误");
  }
}
