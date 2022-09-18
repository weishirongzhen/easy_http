import 'package:easy_http/easy_http.dart';
import 'package:example/api/api.dart';
import 'package:example/controller/main_controller.dart';
import 'package:example/model/login_entity.dart';
import 'package:example/model/register_entity.dart';
import 'package:flutter/cupertino.dart';

class RegisterController extends GetxController {
  TextEditingController usernameController = TextEditingController(text: "easyhttp15");
  TextEditingController emailController = TextEditingController(text: "memtopia15@gmail.com");
  TextEditingController passwordController = TextEditingController(text: "123456789");
    TextEditingController ageController = TextEditingController(text: "10");

  Future<RegisterEntity?> register() async {
    if (usernameController.text.isEmpty) {
      MainController.i.result = "Username can not be empty";
      return null;
    }

    if (emailController.text.isEmpty) {
      MainController.i.result = "Email can not be empty";
      return null;
    }

    if (passwordController.text.isEmpty) {
      MainController.i.result = "password can not be empty";
      return null;
    }

    try {
      final res = await EasyHttp.post<RegisterEntity>(
          url: API.register,
          body: {
            "name": usernameController.text,
            "email": emailController.text,
            "password": passwordController.text,
            "age": ageController.text,
          },
          showDefaultLoading: true);
      MainController.i.result = res.toString();

      MainController.i.token = res.token ?? "";

      print(res.toString());
      return res;
    } catch (e) {
      return null;
    }
  }

  Future<LoginEntity?> login() async {

    if (emailController.text.isEmpty) {
      MainController.i.result = "Email can not be empty";
      return null;
    }

    if (passwordController.text.isEmpty) {
      MainController.i.result = "password can not be empty";
      return null;
    }

    try {
      final res = await EasyHttp.post<LoginEntity>(
          url: API.login,
          body: {
            "email": emailController.text,
            "password": passwordController.text,
          },
          showDefaultLoading: true);
      MainController.i.result = res.toString();

      MainController.i.token = res.token ?? "";

      print(res.toString());
      return res;
    } catch (e) {
      return null;
    }
  }

}
