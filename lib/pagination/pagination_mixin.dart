import 'dart:developer';

import '../easy_http.dart';

mixin PaginationMixin<R> {
  RefreshController getRefreshController({bool initialRefresh = false}) {
    _refreshController ??= RefreshController(initialRefresh: initialRefresh);
    return _refreshController!;
  }

  /// if want to enable list cache, override paginationCacheKey and give localCacheKey a not-empty value. else leave it empty.
  String get paginationCacheKey => "";

  RefreshController? _refreshController;

  final paginateDataList = <R>[].obs;

  int get defaultStartPage => 1;

  int get defaultPageSize => 15;

  /// will be null?
  late int currentPageNumber;

  final _total = 0.obs;

  int get total => _total.value;

  set total(value) {
    _total.value = value;
  }

  Future<void> refreshList({int? wantPageSize, Function()? onRefreshEnd}) async {
    try {
      currentPageNumber = defaultStartPage;
      _readCache();
      paginateDataList.value = await requestPaginateData(currentPageNumber, wantPageSize ?? defaultPageSize, (t) {
        total = t;
      });
      _writeCache();

      _refreshController?.refreshCompleted(resetFooterState: true);
      if (paginateDataList.length == total) {
        _refreshController?.loadNoData();
      }
      onRefreshed();
      if (onRefreshEnd != null) {
        onRefreshEnd();
      }
    } catch (e, s) {
      _refreshController?.refreshFailed();
      if (onRefreshEnd != null) {
        onRefreshEnd();
      }
      onRefreshed();
    }
  }

  void onRefreshed() {}

  void loadMore() async {
    try {
      currentPageNumber++;
      final list = await requestPaginateData(currentPageNumber, defaultPageSize, (t) {
        total = t;
      });
      paginateDataList.addAll(list);

      _writeCache();
      if (paginateDataList.length == total) {
        _refreshController?.loadNoData();
      } else {
        _refreshController?.loadComplete();
      }
    } catch (e, s) {
      _refreshController?.refreshFailed();
    }
  }

  void _readCache() {
    try {
      if (paginationCacheKey.isNotEmpty) {
        final cache = EasyHttp.config.cacheRunner.readCache<List<R>>(paginationCacheKey);
        if (cache != null) {
          paginateDataList.value = cache;
          log("List<${R.toString()}> Cache found!");
        }
      }
    } catch (e, s) {
      log("read List<${R.toString()}> cache error by type", error: e, stackTrace: s);
    }
  }

  void _writeCache() {
    try {
      if (paginationCacheKey.isNotEmpty) {
        EasyHttp.config.cacheRunner.writeCache(paginationCacheKey, paginateDataList);
        log("Updated List<${R.toString()}> Cache ");
      }
    } catch (e, s) {
      log("write List<${R.toString()}> cache error by type", error: e, stackTrace: s);
    }
  }

  Future<List<R>> requestPaginateData(int currentPageNumber, int pageSize, Function(int total) setTotal);

  void deleteListCache() {
    EasyHttp.config.cacheRunner.deleteCache(paginationCacheKey);
  }
}
