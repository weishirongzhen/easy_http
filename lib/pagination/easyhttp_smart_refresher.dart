import '../easy_http.dart';
import 'package:flutter/cupertino.dart';

class ListSmartRefresher<T extends PaginationMixin> extends StatelessWidget {
  final T controller;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsetsGeometry? padding;
  final bool initialRefresh;
  final Widget? emptyWidget;
  final Widget? header;
  final Widget? footer;
  final int? itemCount;

  const ListSmartRefresher({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.initialRefresh = true,
    this.emptyWidget,
    this.header,
    this.footer,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SmartRefresher(
        controller: controller.getRefreshController(initialRefresh: initialRefresh),
        scrollController: controller.scrollController,
        enablePullDown: true,
        physics: const ClampingScrollPhysics(),
        enablePullUp: true,
        onRefresh: controller.refreshList,
        onLoading: () {
          controller.loadMore();
        },
        header: header ?? const ClassicHeader(),
        footer: footer,
        child: controller.paginateDataList.isEmpty
            ? emptyWidget ?? const SizedBox()
            : (separatorBuilder == null
                ? ListView.builder(
                    padding: padding,
                    itemBuilder: itemBuilder,
                    itemCount: itemCount ?? controller.paginateDataList.length,
                  )
                : ListView.separated(
                    padding: padding,
                    itemBuilder: itemBuilder,
                    separatorBuilder: separatorBuilder!,
                    itemCount: itemCount ?? controller.paginateDataList.length,
                  )),
      );
    });
  }
}

class ListSmartRefresherWithFixedTopItem<T extends PaginationMixin> extends StatelessWidget {
  final T controller;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsetsGeometry? padding;
  final bool initialRefresh;
  final Widget? emptyWidget;
  final Widget? header;
  final Widget? footer;
  final Widget? topItem;
  final int? itemCount;

  const ListSmartRefresherWithFixedTopItem({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.initialRefresh = true,
    this.emptyWidget,
    this.header,
    this.footer,
    this.itemCount,
    required this.topItem,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomSmartRefresh(
        initialRefresh: initialRefresh,
        controller: controller,
        hasTopItem: true,
        child: CustomScrollView(
          slivers: [
            topItem!.sliverBox,
            SliverList(
              delegate: SliverChildBuilderDelegate(
                itemBuilder,
                childCount: itemCount ?? controller.paginateDataList.length,
              ),
            )
          ],
        ),
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
  final int? itemCount;

  const GridSmartRefresher({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.padding,
    this.initialRefresh = true,
    required this.gridDelegate,
    this.emptyWidget,
    this.header,
    this.footer,
    this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SmartRefresher(
        controller: controller.getRefreshController(initialRefresh: initialRefresh),
        scrollController: controller.scrollController,
        enablePullDown: true,
        physics: const ClampingScrollPhysics(),
        enablePullUp: true,
        onRefresh: controller.refreshList,
        onLoading: () {
          controller.loadMore();
        },
        header: header ?? const ClassicHeader(),
        footer: footer,
        child: controller.paginateDataList.isEmpty
            ? emptyWidget ?? const SizedBox()
            : GridView.builder(
                padding: padding,
                itemBuilder: itemBuilder,
                itemCount: itemCount ?? controller.paginateDataList.length,
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
  final bool hasTopItem;

  const CustomSmartRefresh({
    super.key,
    required this.controller,
    this.padding,
    this.initialRefresh = true,
    this.emptyWidget,
    required this.child,
    this.header,
    this.footer,
    this.hasTopItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller.getRefreshController(initialRefresh: initialRefresh),
      scrollController: controller.scrollController,
      enablePullDown: true,
      physics: const ClampingScrollPhysics(),
      enablePullUp: true,
      onRefresh: controller.refreshList,
      onLoading: () {
        controller.loadMore();
      },
      header: header ?? const ClassicHeader(),
      footer: footer,
      child: hasTopItem ? child : (controller.paginateDataList.isEmpty ? emptyWidget ?? const SizedBox() : child),
    );
  }
}

CustomFooter getDefaultFooter({
  String? idle,
  String? loading,
  String? failed,
  String? canLoading,
  String? noMore,
}) {
  return CustomFooter(
    builder: (BuildContext context, LoadStatus? mode) {
      Widget body;
      if (mode == LoadStatus.idle) {
        body = Text(idle ?? "Pull up to load more");
      } else if (mode == LoadStatus.loading) {
        body = Text(loading ?? "Loading");
      } else if (mode == LoadStatus.failed) {
        body = Text(failed ?? "load failed");
      } else if (mode == LoadStatus.canLoading) {
        body = Text(canLoading ?? "Release and load more");
      } else {
        body = Text(noMore ?? "No more");
      }
      return SizedBox(
        height: 55.0,
        child: Center(child: body),
      );
    },
  );
}
