import 'package:easy_http/cache/base_cache_runner.dart';
import 'package:easy_http/cache/get_storage_cache_runner.dart';
import 'package:easy_http/config/base_easy_http_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultEasyHttpConfig extends BaseEasyHttpConfig {
  late BaseCacheRunner _cacheRunner;
  final CacheSerializer _cacheSerializer;

  DefaultEasyHttpConfig(this._cacheSerializer);

  @override
  CacheSerializer get cacheSerializer => _cacheSerializer;

  @override
  BaseCacheRunner get cacheRunner => _cacheRunner;

  @override
  Future init() async {
    _cacheRunner = GetStorageCacheRunner();
    await _cacheRunner.setUp();
  }

  @override
  Widget get loadingWidget => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(color: Colors.white.withOpacity(.4), borderRadius: BorderRadius.circular(10)),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.cancel_rounded,
                        color: Colors.white,
                        size: 20,
                      ).paddingAll(10),
                    ),
                  ),
                  const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
