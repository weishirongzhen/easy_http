import 'package:easy_http/easy_http.dart';
import 'package:example/ui/pagination_custom_view_page.dart';
import 'package:example/ui/pagination_grid_page.dart';
import 'package:example/ui/pagination_list_page.dart';
import 'package:example/ui/pagination_sliver_list_page.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EasyHttp API Test"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => const PaginationListPage());
              },
              child: const Text("Load task with pagination list "),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const PaginationSliverListPage());
              },
              child: const Text("Load task with pagination sliver list "),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const PaginationGridPage());
              },
              child: const Text("Load task with pagination grid"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const PaginationCustomViewPage());
              },
              child: const Text("Load task with custom pagination view"),
            ),
          ],
        ).paddingSymmetric(
          vertical: 20,
          horizontal: 20,
        ),
      ),
    );
  }
}
