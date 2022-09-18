import 'package:easy_http/easy_http.dart';
import 'package:easy_http/pagination/easyhttp_smart_refresher.dart';
import 'package:example/controller/task_controller.dart';
import 'package:example/controller/task_list_controller.dart';
import 'package:flutter/material.dart';

class PaginationListPage extends StatelessWidget {
  const PaginationListPage({Key? key}) : super(key: key);

  TaskListController get taskListController => Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(TaskListController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination List"),
      ),
      body: ListSmartRefresher(
        controller: taskListController,
        itemBuilder: (context, index) => ListTile(
          title: Text("${taskListController.paginateDataList[index].description} $index"),
        ),
        separatorBuilder: (_, __) => const Divider(),
        emptyWidget: const Center(
          child: Text("no data"),
        ),
      ),
    );
  }
}
