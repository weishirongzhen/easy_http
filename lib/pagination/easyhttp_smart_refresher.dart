import 'package:easy_http/easy_http.dart';
import 'package:easy_http/pagination/pagination_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListSmartRefresher<T extends PaginationMixin> extends StatelessWidget {
  final T controller;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsetsGeometry? padding;
  final bool initialRefresh;
  final Widget? emptyWidget;

  const ListSmartRefresher({Key? key, required this.controller, required this.itemBuilder, this.separatorBuilder, this.padding, this.initialRefresh = true, this.emptyWidget})
      : super(key: key);

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
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("加载失败！点击重试！");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("松手，加载更多!");
            } else {
              body = const Text("没有更多数据了!");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
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

  const GridSmartRefresher({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.padding,
    this.initialRefresh = true,
    required this.gridDelegate,
    this.emptyWidget,
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
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              body = const CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("加载失败！点击重试！");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("松手，加载更多!");
            } else {
              body = const Text("没有更多数据了!");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        child: controller.paginateDataList.isEmpty
            ? emptyWidget
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
