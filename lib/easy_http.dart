library easy_http;

import 'package:dio/dio.dart';
import 'package:easy_http/config/base_easy_http_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;

export 'package:get/get.dart' hide FormData, MultipartFile, Response;
export 'package:dio/dio.dart';

class EasyHttp {
  EasyHttp._(BaseEasyHttpConfig config) {
    _config = config;
  }

  static EasyHttp? _instance;

  static late BaseEasyHttpConfig _config;

  static Map<String, EasyHttp> instanceNameMap = {};

  static final List<Interceptor> _interceptor = [];

  static List<Interceptor> get interceptor => _interceptor;

  static final Dio _dio = Dio();

  static BaseEasyHttpConfig get config => _config;

  static init({required BaseEasyHttpConfig config, String? tag}) async {
    await config.init();
    // if (tag != null && tag.isNotEmpty) {
    //   instanceNameMap[tag] = EasyHttp._(config);
    // }
    _instance ??= EasyHttp._(config);
  }

  static addInterceptor(Interceptor interceptor) {
    _interceptor.add(interceptor);
    _dio.interceptors.add(interceptor);
  }

  static EasyHttp? findByTag(String tag) {
    return instanceNameMap[tag];
  }

  static EasyHttp? removeByTag(String tag) {
    return instanceNameMap.remove(tag);
  }

  static Future<T> get<T>({
    required String url,
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');

    return onLoading(() async {
      try {
        final res = await _dio.get(url,
            options: Options(
              headers: headers,
              contentType: contentType,
            ),
            queryParameters: query);

        return T.toString() == "dynamic" ? res.data : EasyHttp.config.cacheSerializer<T>(res.data);
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
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.post(url, data: body, options: Options(headers: headers, contentType: contentType), queryParameters: query);
        return T.toString() == "dynamic" ? res.data : EasyHttp.config.cacheSerializer<T>(res.data);
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
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.put(
          url,
          data: body,
          options: Options(headers: headers, contentType: contentType),
          queryParameters: query,
        );
        return T.toString() == "dynamic" ? res.data : EasyHttp.config.cacheSerializer<T>(res.data);
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
    bool showDefaultLoading = true,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return onLoading(() async {
      try {
        final res = await _dio.delete(
          url,
          options: Options(headers: headers, contentType: contentType),
          queryParameters: query,
        );
        return T.toString() == "dynamic" ? res.data : EasyHttp.config.cacheSerializer<T>(res.data);
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
