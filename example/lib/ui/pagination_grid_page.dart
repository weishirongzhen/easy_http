import 'package:easy_http/easy_http.dart';
import 'package:example/controller/task_list_controller.dart';
import 'package:flutter/material.dart';

class PaginationGridPage extends StatelessWidget {
  const PaginationGridPage({Key? key}) : super(key: key);

  UsersController get usersController => Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(UsersController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination Grid"),
      ),
      body: GridSmartRefresher(
        controller: usersController,
        itemBuilder: (context, index) => ListTile(
          title: Text("${usersController.paginateDataList[index].firstName} ${usersController.paginateDataList[index].lastName}"),
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
