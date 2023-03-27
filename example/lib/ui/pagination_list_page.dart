import 'package:easy_http/easy_http.dart';
import 'package:example/controller/task_list_controller.dart';
import 'package:flutter/material.dart';

class PaginationListPage extends StatelessWidget {
  const PaginationListPage({Key? key}) : super(key: key);

  UsersController get usersController => Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(UsersController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination List"),
      ),
      body: ListSmartRefresher(
        controller: usersController,
        itemBuilder: (context, index) => ListTile(
          title: Text("${usersController.paginateDataList[index].firstName} ${usersController.paginateDataList[index].lastName}"),
        ),
        separatorBuilder: (_, __) => const Divider(),
        emptyWidget: const Center(
          child: Text("no data"),
        ),
      ),
    );
  }
}
