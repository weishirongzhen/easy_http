import 'package:easy_http/easy_http.dart';
import 'package:easy_http/pagination/easyhttp_smart_refresher.dart';
import 'package:example/controller/task_controller.dart';
import 'package:example/controller/task_list_controller.dart';
import 'package:flutter/material.dart';

class PaginationGridPage extends StatelessWidget {
  const PaginationGridPage({Key? key}) : super(key: key);

  TaskListController get taskListController => Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(TaskListController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination Grid"),
      ),
      body: GridSmartRefresher(
        controller: taskListController,
        itemBuilder: (context, index) => ListTile(
          title: Text("${taskListController.paginateDataList[index].description} $index"),
        ),
        emptyWidget: const Center(
          child: Text("no data"),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
      ),
    );
  }
}
