import 'package:easy_http/easy_http.dart';
import 'package:example/controller/task_list_controller.dart';
import 'package:flutter/material.dart';

class PaginationSliverListPage extends StatelessWidget {
  const PaginationSliverListPage({Key? key}) : super(key: key);

  UsersController get usersController => Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(UsersController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination Sliver List"),
      ),
      body: ListSmartRefresherWithFixedTopItem(
        controller: usersController,
        itemBuilder: (context, index) => ListTile(
          title: Text("${usersController.paginateDataList[index].firstName} ${usersController.paginateDataList[index].lastName}"),
        ),
        separatorBuilder: (_, __) => const Divider(),
        emptyWidget: const Center(
          child: Text("no data"),
        ),
        topItem: Column(
          mainAxisSize: MainAxisSize.min,
          children:const  [
            Text("first custom widget "),
            Text("second custom widget "),
          ],
        ),
      ),
    );
  }
}
