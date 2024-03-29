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
        actions: [IconButton(onPressed: () {

          usersController.refreshList();

        }, icon: const Icon(Icons.refresh))],
      ),
      body: Obx(() {
        return Stack(
          children: [
            ListSmartRefresher(
              controller: usersController,
              itemBuilder: (context, index) => ListTile(
                title: Text("${usersController.paginateDataList[index].firstName} ${usersController.paginateDataList[index].lastName}"),
              ),
              separatorBuilder: (_, __) => const Divider(),
              emptyWidget: const Center(
                child: Text("no data"),
              ),
            ),
            if (usersController.isScrollDown.isTrue)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        usersController.animateToTop();
                      },
                      child: const Text("top")),
                ),
              ),
          ],
        );
      }),
    );
  }
}
