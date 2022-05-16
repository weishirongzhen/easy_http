import 'dart:convert';
import 'dart:developer';

import 'package:easy_http/cache/base_cache_runner.dart';
import 'package:easy_http/easy_http.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageCacheRunner implements BaseCacheRunner {
  GetStorageCacheRunner();

  late GetStorage gs;

  @override
  String get name => "easy_http_get_storage";

  @override
  Future<void> setUp() async {
    await GetStorage.init(name);
    gs = GetStorage(name);
  }

  @override
  Future<void> tearDown() async {
    // nothing needs to do
  }

  @override
  Future<void> clearCache() async {
    await gs.erase();
  }

  @override
  Future<void> deleteCache(String key) async {
    await gs.remove(key);
  }

  @override
  T? readCache<T>(String key) {
    if (gs.hasData(key)) {
      String? value = gs.read<String>(key);
      if (value == null) return null;
      try {
        return EasyHttp.config.cacheSerializer<T>(jsonDecode(value));
      } catch (e, s) {
        log("read type of ${T.runtimeType} cache error", error: e, stackTrace: s);
      }
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<void>? writeCache<T>(String key, T? data) async {
    if (data != null) {
      try {
        /// `.toJson()` must implements on T because jsonEncode it defaults to a function that returns the
        /// result of calling `.toJson()` on the unencodable object.
        await gs.write(key, jsonEncode(data));
      } catch (e, s) {
        log("write type of ${T.runtimeType} cache error", error: e, stackTrace: s);
      }
    } else {
      gs.remove(key);
    }
  }
}
