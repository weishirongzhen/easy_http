import 'package:easy_http/easy_http.dart';
import 'package:example/controller/main_controller.dart';
import 'package:example/controller/register_controller.dart';
import 'package:example/controller/task_controller.dart';
import 'package:example/ui/pagination_custom_view_page.dart';
import 'package:example/ui/pagination_grid_page.dart';
import 'package:example/ui/pagination_list_page.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  MainController get mainController => Get.find();

  RegisterController get registerController => Get.find();

  TaskController get taskController => Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    Get.put(RegisterController());
    Get.put(TaskController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("EasyHttp API Test"),
      ),
      body: Obx(() {
        return SafeArea(
          child: ListView(
            children: [
              TextField(controller: registerController.usernameController, decoration: const InputDecoration(hintText: "Username")),
              TextField(controller: registerController.emailController, decoration: const InputDecoration(hintText: "Email")),
              TextField(controller: registerController.passwordController, decoration: const InputDecoration(hintText: "Password")),
              TextField(controller: registerController.ageController, decoration: const InputDecoration(hintText: "Age")),
              ElevatedButton(
                onPressed: () {
                  registerController.register();
                },
                child: const Text("Register"),
              ),
              ElevatedButton(
                onPressed: () {
                  registerController.login();
                },
                child: const Text("Login"),
              ),
              TextField(controller: taskController.taskNameController, decoration: const InputDecoration(hintText: "Task name")),
              ElevatedButton(
                onPressed: () {
                  taskController.addTask();
                },
                child: const Text("Add Task"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const PaginationListPage());
                },
                child: const Text("Load task with pagination list "),
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
              Text(mainController.result),
            ],
          ).paddingSymmetric(
            vertical: 20,
            horizontal: 20,
          ),
        );
      }),
    );
  }
}
