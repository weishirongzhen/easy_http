library easy_http;

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:easy_http/config/base_easy_http_config.dart';
import 'package:get/get.dart' hide Response;

export 'package:get/get.dart' hide FormData, MultipartFile, Response;
export 'package:dio/dio.dart';
export 'package:pull_to_refresh/pull_to_refresh.dart';
export './http/easy_http_cache_controller.dart';
export './pagination/easyhttp_smart_refresher.dart';
export './pagination/pagination_mixin.dart';

class EasyHttp {
  EasyHttp._(BaseEasyHttpConfig config) {
    _config = config;
  }

  static EasyHttp? _instance;

  static late BaseEasyHttpConfig _config;

  static final List<Interceptor> _interceptor = [];

  static List<Interceptor> get interceptor => _interceptor;

  static final Dio _dio = Dio();

  static BaseEasyHttpConfig get config => _config;

  static init({required BaseEasyHttpConfig config}) async {
    await config.init();
    _instance ??= EasyHttp._(config);
  }

  static addInterceptor(Interceptor interceptor) {
    _interceptor.add(interceptor);
    _dio.interceptors.add(interceptor);
  }

  static Future<T> get<T>({
    required String url,
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.get(
          url,
          options: Options(
            headers: headers,
            contentType: contentType,
            sendTimeout: sendTimeout,
            receiveTimeout: receiveTimeout,
          ),
          queryParameters: query,
        );

        return T.toString() == "dynamic" ? res.data : EasyHttp.config.cacheSerializer<T>(res.data);
      } catch (e) {
        rethrow;
      }
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<Response> rawGet({
    required String url,
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.get(
          url,
          options: Options(
            headers: headers,
            contentType: contentType,
            sendTimeout: sendTimeout,
            receiveTimeout: receiveTimeout,
          ),
          queryParameters: query,
        );

        return res;
      } catch (e) {
        rethrow;
      }
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<T> post<T>({
    required String url,
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.post(
          url,
          data: body,
          options: Options(
            headers: headers,
            contentType: contentType,
            sendTimeout: sendTimeout,
            receiveTimeout: receiveTimeout,
          ),
          queryParameters: query,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        return T.toString() == "dynamic" ? res.data : EasyHttp.config.cacheSerializer<T>(res.data);
      } catch (e) {
        rethrow;
      }
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<Response> rawPost({
    required String url,
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.post(
          url,
          data: body,
          options: Options(
            headers: headers,
            contentType: contentType,
            sendTimeout: sendTimeout,
            receiveTimeout: receiveTimeout,
          ),
          queryParameters: query,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        return res;
      } catch (e) {
        rethrow;
      }
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<T> put<T>({
    required String url,
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.put(
          url,
          data: body,
          options: Options(
            headers: headers,
            contentType: contentType,
            sendTimeout: sendTimeout,
            receiveTimeout: receiveTimeout,
          ),
          queryParameters: query,
        );
        return T.toString() == "dynamic" ? res.data : EasyHttp.config.cacheSerializer<T>(res.data);
      } catch (e) {
        rethrow;
      }
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<Response> rawPut({
    required String url,
    dynamic body,
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.put(
          url,
          data: body,
          options: Options(
            headers: headers,
            contentType: contentType,
            sendTimeout: sendTimeout,
            receiveTimeout: receiveTimeout,
          ),
          queryParameters: query,
        );
        return res;
      } catch (e) {
        rethrow;
      }
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<T> delete<T>({
    required String url,
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    dynamic data,
    bool showDefaultLoading = true,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.delete(
          url,
          options: Options(
            headers: headers,
            contentType: contentType,
            sendTimeout: sendTimeout,
            receiveTimeout: receiveTimeout,
          ),
          queryParameters: query,
          data: data,
        );
        return T.toString() == "dynamic" ? res.data : EasyHttp.config.cacheSerializer<T>(res.data);
      } catch (e) {
        rethrow;
      }
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<Response> rawDelete({
    required String url,
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    dynamic data,
    bool showDefaultLoading = true,
    Duration? sendTimeout,
    Duration? receiveTimeout,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.delete(
          url,
          options: Options(
            headers: headers,
            contentType: contentType,
            sendTimeout: sendTimeout,
            receiveTimeout: receiveTimeout,
          ),
          queryParameters: query,
          data: data,
        );
        return res;
      } catch (e) {
        rethrow;
      }
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<Response> download(
      {required String url,
      required String savePath,
      ProgressCallback? onReceiveProgress,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      bool deleteOnError = true,
      String lengthHeader = Headers.contentLengthHeader,
      data,
      Options? options}) async {
    final downloadDio = Dio();
    final res = await downloadDio.download(
      url,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    );
    return res;
  }

  static Future<T> onLoading<T>(Future<T> Function() asyncFunction, {bool showDefaultLoading = true}) async {
    if (showDefaultLoading) {
      T data;
      Get.dialog(
        EasyHttp.config.loadingWidget,
        barrierDismissible: false,
        barrierColor: Colors.black12,
      );
      try {
        data = await asyncFunction();
        Get.back();
      } on Exception catch (_) {
        Get.back();
        rethrow;
      }

      return data;
    } else {
      return asyncFunction();
    }
  }
}
