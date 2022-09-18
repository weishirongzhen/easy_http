import 'package:easy_http/easy_http.dart';
import 'package:easy_http/pagination/easyhttp_smart_refresher.dart';
import 'package:example/controller/task_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PaginationCustomViewPage extends StatelessWidget {
  const PaginationCustomViewPage({Key? key}) : super(key: key);

  TaskListController get taskListController => Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(TaskListController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination List"),
      ),
      body: Obx(() {
        return CustomSmartRefresh(
          controller: taskListController,
          child: MasonryGridView.count(
            itemCount: taskListController.paginateDataList.length,
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              return Tile(
                index: index,
                extent: (index % 5 + 1) * 100,
              );
            },
          ),
        );
      }),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? Colors.blue,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
