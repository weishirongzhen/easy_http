library easy_http;

import 'dart:developer';

import 'package:easy_http/config/base_easy_http_config.dart';
import 'package:easy_http/easy_http.dart';
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';
import 'package:get/get_connect/http/src/request/request.dart';

export 'package:get/get.dart';

class EasyHttp extends GetConnect {
  EasyHttp._(BaseEasyHttpConfig config) {
    _config = config;
  }

  static EasyHttp? _instance;

  static late BaseEasyHttpConfig _config;

  static final List<RequestModifier> _requestInterceptor = [];
  static final List<ResponseModifier> _responseInterceptor = [];

  static List<RequestModifier> get requestInterceptor => _requestInterceptor;

  static List<ResponseModifier> get responseInterceptor => _responseInterceptor;

  static BaseEasyHttpConfig get config => _config;

  @override
  void onInit() {
    for (RequestModifier request in EasyHttp.requestInterceptor) {
      httpClient.addRequestModifier(request);
    }
    for (ResponseModifier response in EasyHttp.responseInterceptor) {
      httpClient.addResponseModifier(response);
    }
  }

  static init({required BaseEasyHttpConfig config}) async {
    await config.init();
    _instance ??= EasyHttp._(config);
  }

  static addRequestModifier(RequestModifier interceptor) {
    _requestInterceptor.add(interceptor);
  }

  static addResponseModifier(ResponseModifier interceptor) {
    _responseInterceptor.add(interceptor);
  }

  static Future<Response<T>> doGet<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    log("request query = " + query.toString());
    return _instance!.get(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
  }

  static Future<Response<T>> doPost<T>(
    String? url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    log("request body = " + body.toString());
    return _instance!.post(
      url,
      body,
      contentType: contentType,
      headers: headers,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  static Future<Response<T>> doPut<T>(
    String url,
    dynamic body, {
    String? contentType,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
    Progress? uploadProgress,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return _instance!.put(
      url,
      body,
      contentType: contentType,
      headers: headers,
      query: query,
      decoder: decoder,
      uploadProgress: uploadProgress,
    );
  }

  static Future<Response<T>> doDelete<T>(
    String url, {
    Map<String, String>? headers,
    String? contentType,
    Map<String, dynamic>? query,
    Decoder<T>? decoder,
  }) {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return _instance!.delete(
      url,
      headers: headers,
      contentType: contentType,
      query: query,
      decoder: decoder,
    );
  }

  static void registerToGet(Function(EasyHttp instance ) register) {
    register.call(_instance!);
  }
}
