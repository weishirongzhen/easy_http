library easy_http;

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_http/config/base_easy_http_config.dart';
import 'package:get/get.dart' hide Response;

export 'package:get/get.dart' hide  FormData, MultipartFile, Response;
export 'package:dio/dio.dart';

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

  static Future<T> get<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');

    return _onLoading(() async {
      final res = await _dio.get(
        url,
        options: Options(
          headers: headers,
          contentType: contentType,
        ),
        queryParameters: query
      );
      return T.toString() == "dynamic" ? res.data :EasyHttp.config.cacheSerializer<T>(res.data) ;
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<T> post<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return _onLoading(() async {
      final res = await _dio.post(
        url,
        data: body,
        options: Options(headers: headers, contentType: contentType),
        queryParameters: query
      );
      return T.toString() == "dynamic" ? res.data :EasyHttp.config.cacheSerializer<T>(res.data) ;
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<T> put<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return _onLoading(() async {
      final res = await _dio.put(
        url,
        data: body,
        options: Options(headers: headers, contentType: contentType),
        queryParameters: query,
      );
      return T.toString() == "dynamic" ? res.data :EasyHttp.config.cacheSerializer<T>(res.data) ;
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<T> delete<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    bool showDefaultLoading = true,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return _onLoading(() async {
      final res = await _dio.delete(
        url,
        options: Options(headers: headers, contentType: contentType),
        queryParameters: query,
      );
      return T.toString() == "dynamic" ? res.data :EasyHttp.config.cacheSerializer<T>(res.data) ;
    }, showDefaultLoading: showDefaultLoading);
  }

  static Future<T> _onLoading<T>(Future<T> Function() asyncFunction, {bool showDefaultLoading = true}) async {
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
}
