import 'package:easy_http/easy_http.dart';
import 'package:easy_http/pagination/easyhttp_smart_refresher.dart';
import 'package:example/controller/basic_controller.dart';
import 'package:flutter/material.dart';

class BasicRefreshPage extends StatelessWidget {
  const BasicRefreshPage({Key? key}) : super(key: key);

  BasicController get basicController => Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(BasicController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic refresh"),
      ),
      body: Obx(() {
        return BasicSmartRefresh(
          controller: basicController,
          emptyWidget: const Center(
            child: Text("no data"),
          ),
          child: Text(basicController.httpData.toString()),
        );
      }),
    );
  }
}
