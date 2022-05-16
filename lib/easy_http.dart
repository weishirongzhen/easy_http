library easy_http;

import 'package:easy_http/config/base_easy_http_config.dart';
import 'package:easy_http/easy_http.dart';
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';

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

  static init({required BaseEasyHttpConfig config}) async {
    await config.init();
    _instance ??= EasyHttp._(config);
  }

  static EasyHttp get instance {
    if (_instance == null) throw Exception('Please call "EasyHttp.init(config)" first.');
    return _instance!;
  }

  static addRequestModifier(RequestModifier interceptor) {
    _requestInterceptor.add(interceptor);
  }

  static addResponseModifier(ResponseModifier interceptor) {
    _responseInterceptor.add(interceptor);
  }
}
