import 'package:easy_http/easy_http.dart';

class MainController extends GetxController {

  static MainController get i => Get.find();

  final _result = "".obs;

  get result => _result.value;

  set result(val) => _result.value = val;


  final _token = "".obs;

  get token => _token.value;

  set token(val) => _token.value = val;
}
