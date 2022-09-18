import 'package:easy_http/config/default_easy_http_config.dart';
import 'package:easy_http/easy_http.dart';
import 'package:example/controller/main_controller.dart';
import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/ui/test_page.dart';
import 'package:flutter/material.dart';

void main() async {
  await EasyHttp.init(config: DefaultEasyHttpConfig(JsonConvert.fromJsonAsT));
  EasyHttp.addInterceptor(InterceptorsWrapper(onError: (
    DioError e,
    ErrorInterceptorHandler handler,
  ) {
    MainController.i.result = e.message + (e.response?.data?.toString()??"");
    handler.next(e);
  }, onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    var headers = {'Content-Type': 'application/json',
      "Authorization":"Bearer ${MainController.i.token}"
    };
    options.headers.addAll(headers);
    return handler.next(options);
  }, onResponse: (Response e, ResponseInterceptorHandler handler) {
    return handler.next(e);
  }));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EasyHttp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestPage(),
    );
  }
}
