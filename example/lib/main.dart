import 'package:easy_http/config/default_easy_http_config.dart';
import 'package:easy_http/easy_http.dart';
import 'package:example/generated/json/base/json_convert_content.dart';
import 'package:example/ui/test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await EasyHttp.init(config: DefaultEasyHttpConfig(JsonConvert.fromJsonAsT));
  EasyHttp.addInterceptor(InterceptorsWrapper(onError: (
    DioError e,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(e);
  }, onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
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
      localizationsDelegates: const [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // American English
        Locale('zh'), // Israeli Hebrew
        // ...
      ],
      title: 'EasyHttp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestPage(),
    );
  }
}
