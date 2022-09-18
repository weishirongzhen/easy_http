import 'package:easy_http/easy_http.dart';
import 'package:example/api/api.dart';
import 'package:example/controller/main_controller.dart';
import 'package:example/model/add_task_entity.dart';
import 'package:flutter/material.dart';

class TaskController extends GetxController {
  TextEditingController taskNameController = TextEditingController(text: "task 1");

  Future<AddTaskEntity?> addTask() async {
    if (taskNameController.text.isEmpty) {
      MainController.i.result = "Please input task name";
      return null;
    }
    final res = await EasyHttp.post<AddTaskEntity>(url: API.task, body: {"description": taskNameController.text});
    MainController.i.result = res.toString();
    return res;
  }
}

