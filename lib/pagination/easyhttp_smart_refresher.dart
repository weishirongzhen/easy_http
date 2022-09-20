import '../easy_http.dart';
import '../http/easy_http_cache_controller.dart';
import '../pagination/pagination_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListSmartRefresher<T extends PaginationMixin> extends StatelessWidget {
  final T controller;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsetsGeometry? padding;
  final bool initialRefresh;
  final Widget? emptyWidget;
  final Widget? header;
  final Widget? footer;

  const ListSmartRefresher({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.initialRefresh = true,
    this.emptyWidget,
    this.header,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SmartRefresher(
        controller: controller.getRefreshController(initialRefresh: initialRefresh),
        enablePullDown: true,
        physics: const ClampingScrollPhysics(),
        enablePullUp: true,
        onRefresh: controller.refreshList,
        onLoading: () {
          controller.loadMore();
        },
        header: header ?? const ClassicHeader(),
        footer: footer ?? getCustomFooter(),
        child: controller.paginateDataList.isEmpty
            ? emptyWidget ?? const SizedBox()
            : (separatorBuilder == null
                ? ListView.builder(
                    padding: padding,
                    itemBuilder: itemBuilder,
                    itemCount: controller.paginateDataList.length,
                  )
                : ListView.separated(
                    padding: padding,
                    itemBuilder: itemBuilder,
                    separatorBuilder: separatorBuilder!,
                    itemCount: controller.paginateDataList.length,
                  )),
      );
    });
  }
}

class GridSmartRefresher<T extends PaginationMixin> extends StatelessWidget {
  final T controller;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry? padding;
  final bool initialRefresh;
  final SliverGridDelegate gridDelegate;
  final Widget? emptyWidget;
  final Widget? header;
  final Widget? footer;

  const GridSmartRefresher({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.padding,
    this.initialRefresh = true,
    required this.gridDelegate,
    this.emptyWidget,
    this.header,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SmartRefresher(
        controller: controller.getRefreshController(initialRefresh: initialRefresh),
        enablePullDown: true,
        physics: const ClampingScrollPhysics(),
        enablePullUp: true,
        onRefresh: controller.refreshList,
        onLoading: () {
          controller.loadMore();
        },
        header: header ?? const ClassicHeader(),
        footer: footer ?? getCustomFooter(),
        child: controller.paginateDataList.isEmpty
            ? emptyWidget ?? const SizedBox()
            : GridView.builder(
                padding: padding,
                itemBuilder: itemBuilder,
                itemCount: controller.paginateDataList.length,
                gridDelegate: gridDelegate,
              ),
      );
    });
  }
}

class CustomSmartRefresh<T extends PaginationMixin> extends StatelessWidget {
  final T controller;
  final EdgeInsetsGeometry? padding;
  final bool initialRefresh;
  final Widget? emptyWidget;
  final Widget child;
  final Widget? header;
  final Widget? footer;

  const CustomSmartRefresh({
    Key? key,
    required this.controller,
    this.padding,
    this.initialRefresh = true,
    this.emptyWidget,
    required this.child,
    this.header,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.getRefreshController(initialRefresh: initialRefresh),
      enablePullDown: true,
      physics: const ClampingScrollPhysics(),
      enablePullUp: true,
      onRefresh: controller.refreshList,
      onLoading: () {
        controller.loadMore();
      },
      header: header ?? const ClassicHeader(),
      footer: footer ?? getCustomFooter(),
      child: controller.paginateDataList.isEmpty ? emptyWidget ?? const SizedBox() : child,
    );
  }
}

class BasicSmartRefresh<T extends EasyHttpCacheController> extends StatelessWidget {
  final T controller;
  final EdgeInsetsGeometry? padding;
  final bool initialRefresh;
  final Widget? emptyWidget;
  final Widget child;
  final Widget? header;
  final Widget? footer;

  const BasicSmartRefresh({
    Key? key,
    required this.controller,
    this.padding,
    this.initialRefresh = true,
    this.emptyWidget,
    required this.child,
    this.header,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.getRefreshController(initialRefresh: initialRefresh),
      enablePullDown: true,
      physics: const ClampingScrollPhysics(),
      enablePullUp: false,
      onRefresh: controller.refreshData,
      header: header ?? const ClassicHeader(),
      footer: footer ?? getCustomFooter(),
      child: child,
    );
  }
}

CustomFooter getCustomFooter() {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = const Text("Pull up to load more");
      } else if (mode == LoadStatus.loading) {
        body = const CupertinoActivityIndicator();
      } else if (mode == LoadStatus.failed) {
        body = const Text("load failed");
      } else if (mode == LoadStatus.canLoading) {
        body = const Text("Release and load more");
      } else {
        body = const Text("no more data");
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}
